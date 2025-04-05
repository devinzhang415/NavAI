import { MapComponent } from "../MapComponent/Scripts/MapComponent";
import { makeTween } from "../MapComponent/Scripts/MapUtils";
import { ContainerFrame } from "../SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame";
import WorldCameraFinderProvider from "../SpectaclesInteractionKit/Providers/CameraProvider/WorldCameraFinderProvider";
import { CancelFunction } from "../SpectaclesInteractionKit/Utils/animate";
import { LensConfig } from "../SpectaclesInteractionKit/Utils/LensConfig";
import {
  clamp,
  smoothDamp,
  smoothDampAngle,
} from "../SpectaclesInteractionKit/Utils/mathUtils";
import { UpdateDispatcher } from "../SpectaclesInteractionKit/Utils/UpdateDispatcher";
import { validate } from "../SpectaclesInteractionKit/Utils/validate";
import { TWEEN_DURATION } from "./MapUIController";
import { NorthIndicator } from "./NorthIndicator";

const CONTAINER_SIZE_MINI = new vec2(10, 10);
const CONTAINER_SIZE_FULL = new vec2(54.0, 54.0);
const CONTAINER_FRAME_SIZE_MINI = new vec2(18, 18);
const CONTAINER_DISTANCE_MINI = 130;
const CONTAINER_DISTANCE_FULL = 175;

@component
export class MapContainerController extends BaseScriptComponent {
  @input
  private mapComponent: MapComponent;

  @input private translationXTime: number = 1;
  @input private translationYTime: number = 0.35;
  @input private translationZTime: number = 0.35;
  @input private rotationTime: number = 0.55;
  @input private minFollowDistance: number = 50;
  @input private maxFollowDistance: number = 160;

  private container: ContainerFrame;
  private updateDispatcher: UpdateDispatcher =
    LensConfig.getInstance().updateDispatcher;

  private containerYOffset: number = 0;
  private cameraTransform: Transform;

  private fieldOfView: number = 26;
  private visibleWidth: number = 20;
  private minElevation: number = -40;
  private maxElevation: number = 40;
  private target: vec3;
  private velocity: vec3;
  private omega: number;
  private heading: number;
  private initialRot: quat;
  private containerTransform: Transform;
  private dragging: boolean;

  private tweenCancelFunction: CancelFunction;

  // Offset in world space to apply after follow logic
  private savedOffset: vec3 = vec3.zero();
  private northIndicator: NorthIndicator;

  onAwake() {
    this.createEvent("OnStartEvent").bind(this.onStart.bind(this));
    const updateEvent = this.updateDispatcher.createUpdateEvent("UpdateEvent");
    updateEvent.bind(this.onUpdate.bind(this));
  }

  private onStart() {
    this.container = this.sceneObject.getComponent(
      ContainerFrame.getTypeName()
    );

    // Initial minimap styling
    if (this.mapComponent.startedAsMiniMap) {
      this.container.border = 2;
      this.container.cutOut = true;
      (this.container as any).borderAlpha = 0.3;
    }

    this.container.setIsFollowing(this.mapComponent.startedAsMiniMap);
    
    // Create North indicator
    const northIndicatorObj = global.scene.createSceneObject("NorthIndicator");
    const textComponent = northIndicatorObj.createComponent("Component.Text");
    textComponent.text = "N";
    (textComponent as any).FontSize = 24;
    
    // Position the indicator at the top of the minimap
    northIndicatorObj.setParent(this.sceneObject);
    const transform = northIndicatorObj.getTransform();
    transform.setLocalPosition(new vec3(0, 10, 2));
    
    // Add the NorthIndicator script
    this.northIndicator = northIndicatorObj.createComponent(NorthIndicator.getTypeName()) as NorthIndicator;
    this.northIndicator.text = "N";

    this.container.followButton.onTrigger.add(
      this.handleFollowButtonTrigger.bind(this)
    );
    this.mapComponent.onMiniMapToggled.add(
      this.handleMiniMapToggled.bind(this)
    );

    this.cameraTransform =
      WorldCameraFinderProvider.getInstance().getTransform();
    this.containerYOffset =
      this.container.getWorldPosition().y -
      this.cameraTransform.getWorldPosition().y;
    this.containerTransform = this.container.parentTransform;

    this.initializeSmoothFollow();
  }

  private onUpdate() {
    if (!this.container.isFollowing) return;
    this.updateSmoothFollow();
  }

  private initializeSmoothFollow() {
    this.target = vec3.zero();
    this.velocity = vec3.zero();
    this.omega = 0;
    this.heading = this.cameraHeading;
    this.dragging = false;
    this.initialRot = this.containerTransform.getLocalRotation();

    this.worldRot = quat
      .angleAxis(this.heading, vec3.up())
      .multiply(this.initialRot);
    this.resize(
      this.container.innerSize.x +
        this.container.border * 2 +
        this.container.constantPadding.x
    );

    this.container.onTranslationStart.add(this.startDragging.bind(this));
    this.container.onTranslationEnd.add(this.finishDragging.bind(this));
  }

  private updateSmoothFollow() {
    if (this.dragging) return;

    // Smooth cylindrical follow (ignores savedOffset here)
    const pos = this.cartesianToCylindrical(
      this.worldToBody(
        this.worldPos.sub(this.savedOffset)
      )
    );

    // Smooth heading
    [pos.x, this.velocity.x] = smoothDamp(
      pos.x,
      this.target.x,
      this.velocity.x,
      this.translationXTime,
      getDeltaTime()
    );
    [pos.z, this.velocity.z] = smoothDamp(
      pos.z,
      this.target.z,
      this.velocity.z,
      this.translationZTime,
      getDeltaTime()
    );

    // Compute new world XZ position (base follow position)
    const worldXZPos = this.bodyToWorld(this.cylindricalToCartesian(pos));

    // Vertical follow
    const currentY = this.worldPos.y - this.savedOffset.y;
    const targetY =
      this.cameraTransform.getWorldPosition().y + this.containerYOffset;
    let newY: number;
    [newY, this.velocity.y] = smoothDamp(
      currentY,
      targetY,
      this.velocity.y,
      this.translationYTime,
      getDeltaTime()
    );

    // Reconstruct base follow position
    const basePosition = new vec3(worldXZPos.x, newY, worldXZPos.z);

    // Apply saved offset (clamped already)
    this.worldPos = basePosition.add(this.savedOffset);

    // Smooth rotation to face camera
    [this.heading, this.omega] = smoothDampAngle(
      this.heading,
      this.cameraHeading,
      this.omega,
      this.rotationTime,
      getDeltaTime()
    );
    this.worldRot = quat
      .lookAt(this.cameraPos.sub(this.worldPos).normalize(), vec3.up())
      .multiply(this.initialRot);
  }

  private handleMiniMapToggled(isMiniMap: boolean) {
    if (this.tweenCancelFunction) {
      this.tweenCancelFunction();
      this.tweenCancelFunction = undefined;
    }

    const containerWorldPosition =
      this.containerTransform.getWorldPosition();

    if (isMiniMap) {
      this.mapComponent.centerMap();
      this.container.border = 2;
      this.container.cutOut = true;
      (this.container as any).borderAlpha = 0.3;

      const cameraForward = this.cameraTransform.forward;
      const cameraRight = this.cameraTransform.right;
      const cameraUp = this.cameraTransform.up; // fixed: property not callable
      const offset = 0.1;
      const targetWorldPosition = this.cameraPos
        .add(cameraForward.uniformScale(CONTAINER_DISTANCE_MINI))
        .add(cameraRight.uniformScale(-CONTAINER_DISTANCE_MINI * offset))
        .add(cameraUp.uniformScale(CONTAINER_DISTANCE_MINI * offset))
        .add(new vec3(0, this.containerYOffset, 0))
        .add(this.savedOffset);

      this.tweenCancelFunction = makeTween((t) => {
        this.container.innerSize = vec2.lerp(
          CONTAINER_SIZE_FULL,
          CONTAINER_SIZE_MINI,
          t
        );
        (this.container as any).outerSize = vec2.lerp(
          CONTAINER_SIZE_FULL,
          CONTAINER_FRAME_SIZE_MINI,
          t
        );
        this.containerTransform.setWorldPosition(
          vec3.lerp(containerWorldPosition, targetWorldPosition, t)
        );
        if (t > 0.9999) {
          this.container.setIsFollowing(true);
          this.clampPosition();
        }
      }, TWEEN_DURATION);
    } else {
      this.container.border = 7;
      this.container.cutOut = false;
      (this.container as any).borderAlpha = 1.0;
      this.container.setIsFollowing(true);

      const cameraForward = this.cameraTransform.forward;
      const targetWorldPosition = this.cameraPos
        .add(cameraForward.uniformScale(CONTAINER_DISTANCE_FULL))
        .add(new vec3(0, this.containerYOffset, 0))
        .add(this.savedOffset);

      this.tweenCancelFunction = makeTween((t) => {
        const newSize = vec2.lerp(
          CONTAINER_SIZE_MINI,
          CONTAINER_SIZE_FULL,
          t
        );
        this.container.innerSize = newSize;
        (this.container as any).outerSize = newSize;
        this.containerTransform.setWorldPosition(
          vec3.lerp(containerWorldPosition, targetWorldPosition, t)
        );
      }, TWEEN_DURATION);
    }
  }

  private handleFollowButtonTrigger() {
    this.clampPosition();
  }

  startDragging(): void {
    this.dragging = true;
  }

  finishDragging(): void {
    this.dragging = false;
    
    // Get the camera's forward and right vectors
    const cameraForward = this.cameraTransform.forward;
    const cameraRight = this.cameraTransform.right;
    
    // Get the current world position
    const currentWorldPos = this.worldPos;
    
    // Calculate the vector from camera to current position
    const cameraToMap = currentWorldPos.sub(this.cameraPos);
    
    // Project onto camera's forward and right planes
    const forwardDistance = cameraToMap.dot(cameraForward);
    const rightDistance = cameraToMap.dot(cameraRight);
    
    // Calculate the base position (where the map should be without offset)
    const isMini = this.container.cutOut;
    const baseDistance = isMini ? CONTAINER_DISTANCE_MINI : CONTAINER_DISTANCE_FULL;
    const basePosition = this.cameraPos
      .add(cameraForward.uniformScale(baseDistance))
      .add(new vec3(0, this.containerYOffset, 0));
    
    // Calculate the offset in camera space
    const cameraSpaceOffset = new vec3(
      rightDistance,
      currentWorldPos.y - basePosition.y,
      forwardDistance - baseDistance
    );
    
    // Clamp the offset
    const maxOffset = isMini ? 20 : 40;
    this.savedOffset = new vec3(
      clamp(cameraSpaceOffset.x, -maxOffset, maxOffset),
      clamp(cameraSpaceOffset.y, -maxOffset, maxOffset),
      clamp(cameraSpaceOffset.z, -maxOffset, maxOffset)
    );

    // Re-clamp target ignoring offset
    this.clampPosition();
  }

  resize(visibleWidth: number): void {
    this.visibleWidth = visibleWidth;
    this.clampPosition();
  }

  private clampPosition(): void {
    if (this.dragging) return;
    // Use world position minus offset to compute pure follow target
    const pureWorldPos = this.worldPos.sub(this.savedOffset);
    this.target = this.cartesianToCylindrical(
      this.worldToBody(pureWorldPos)
    );

    this.target.z = clamp(
      this.target.z,
      this.minFollowDistance,
      this.maxFollowDistance
    );
    this.target.z = Math.max(
      this.target.z,
      (1.1 * this.visibleWidth) /
        2 /
        Math.tan((this.fieldOfView / 2) * MathUtils.DegToRad)
    );

    this.target.y = clamp(
      this.target.y,
      this.minElevation,
      this.maxElevation
    );
    const halfFov = this.halfFov;
    this.target.x = clamp(this.target.x, -halfFov, halfFov);

    this.velocity = vec3.zero();
    this.omega = 0;
  }

  private get halfFov(): number {
    const dist = new vec2(this.target.y, this.target.z).length;
    return Math.atan(
      (Math.tan((this.fieldOfView / 2) * MathUtils.DegToRad) * dist -
        this.visibleWidth / 2) /
        this.target.z
    );
  }

  private cartesianToCylindrical(v: vec3): vec3 {
    return new vec3(
      Math.atan2(-v.x, -v.z),
      v.y,
      Math.sqrt(v.x * v.x + v.z * v.z)
    );
  }

  private cylindricalToCartesian(v: vec3): vec3 {
    return new vec3(v.z * -Math.sin(v.x), v.y, v.z * -Math.cos(v.x));
  }

  private worldToBody(v: vec3): vec3 {
    return quat
      .angleAxis(-this.cameraHeading, vec3.up())
      .multiplyVec3(v.sub(this.cameraPos));
  }

  private bodyToWorld(v: vec3): vec3 {
    return quat
      .angleAxis(this.cameraHeading, vec3.up())
      .multiplyVec3(v)
      .add(this.cameraPos);
  }

  private get cameraHeading(): number {
    const forward = this.cameraTransform
      .getWorldTransform()
      .multiplyDirection(new vec3(0, 0, -1));
    return Math.atan2(-forward.x, -forward.z);
  }

  private get cameraPos(): vec3 {
    return this.cameraTransform.getWorldPosition();
  }

  private get worldRot(): quat {
    validate(this.containerTransform);
    return this.containerTransform.getWorldRotation();
  }

  private set worldRot(value: quat) {
    validate(this.containerTransform);
    this.containerTransform.setWorldRotation(value);
  }

  private get worldPos(): vec3 {
    validate(this.containerTransform);
    return this.containerTransform.getWorldPosition();
  }

  private set worldPos(value: vec3) {
    validate(this.containerTransform);
    this.containerTransform.setWorldPosition(value);
  }
}
