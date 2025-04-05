import WorldCameraFinderProvider from "../SpectaclesInteractionKit/Providers/CameraProvider/WorldCameraFinderProvider";
import { LensConfig } from "../SpectaclesInteractionKit/Utils/LensConfig";
import { ContainerFrame } from "../SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame";

@component
export class NorthIndicator extends BaseScriptComponent {
  @input
  public text: string = "N";

  /** How far in front of the map‐plane to sit */
  @input
  public depth: number = 2;

  private cameraTransform: Transform;
  private updateDispatcher = LensConfig.getInstance().updateDispatcher;
  private containerFrame: ContainerFrame;

  onAwake() {
    this.createEvent("OnStartEvent").bind(this.onStart.bind(this));
  }

  private onStart() {
    // grab the world camera
    this.cameraTransform = WorldCameraFinderProvider.getInstance().getTransform();

    // find the parent ContainerFrame so we can read its innerSize.x each frame
    this.containerFrame = this.sceneObject
      .getParent()
      .getComponent(ContainerFrame.getTypeName()) as ContainerFrame;

    // set up the "N" label
    const txt = this.sceneObject.getComponent("Component.Text") as Text;
    if (txt) {
      txt.text = this.text;
      (txt as any).FontSize = 24;
    }

    // initially push it out in Z so it's in front of the map
    const t = this.sceneObject.getTransform();
    t.setLocalPosition(new vec3(0, 0, this.depth));
    t.setLocalRotation(quat.fromEulerAngles(0, 0, 0));

    // drive the orbit every frame
    const upd = this.updateDispatcher.createUpdateEvent("UpdateEvent");
    upd.bind(this.onUpdate.bind(this));
  }

  private onUpdate() {
    const t = this.sceneObject.getTransform();
    const fwd = this.cameraTransform.forward;

    // project to horizontal (XZ) and flip so -Z is north
    const dirXZ = new vec3(fwd.x, 0, fwd.z).normalize();
    const northDir = dirXZ.uniformScale(-1);

    // compute heading angle (0 = north, +clockwise toward east)
    const angle = Math.atan2(northDir.x, northDir.z);

    // get the current radius from the container's innerSize.x
    const radius = this.containerFrame
      ? this.containerFrame.innerSize.x * 0.5
      : 0;

    // place on the circle in the container's LOCAL XY plane
    const x = Math.sin(angle) * radius;
    const y = Math.cos(angle) * radius;
    t.setLocalPosition(new vec3(x, y, this.depth));

    // zero out any local rotation so the text always faces the camera
    t.setLocalRotation(quat.fromEulerAngles(0, 0, 0));
  }
}
