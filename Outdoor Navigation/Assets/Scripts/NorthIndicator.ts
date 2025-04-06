import WorldCameraFinderProvider from "../SpectaclesInteractionKit/Providers/CameraProvider/WorldCameraFinderProvider";
import { LensConfig } from "../SpectaclesInteractionKit/Utils/LensConfig";
import { ContainerFrame } from "../SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame";

@component
export class NorthIndicator extends BaseScriptComponent {
  /** How far in front of the map‐plane to sit */
  @input
  public depth: number = 2;

  /** Radius of the circle around the map (as a fraction of the container width) */
  @input
  public radiusScale: number = 0.6;

  private cameraTransform: Transform;
  private updateDispatcher = LensConfig.getInstance().updateDispatcher;
  private containerFrame: ContainerFrame;
  private textComponent: Text;

  onAwake() {
    this.createEvent("OnStartEvent").bind(this.onStart.bind(this));
  }

  private onStart() {
    print("NorthIndicator: Starting initialization");

    // Get the world camera
    this.cameraTransform = WorldCameraFinderProvider.getInstance().getTransform();
    if (!this.cameraTransform) {
      return;
    }

    // Get the parent ContainerFrame component
    this.containerFrame = this.sceneObject
      .getParent()
      .getComponent(ContainerFrame.getTypeName()) as ContainerFrame;
    if (!this.containerFrame) {
      print("Error: Could not get container frame");
      return;
    }
    print("NorthIndicator: Got container frame");

    // Set up the "N" label
    this.textComponent = this.sceneObject.createComponent("Component.Text") as Text;
    if (this.textComponent) {
      this.textComponent.text = "N";
      (this.textComponent as any).FontSize = 30;
      (this.textComponent as any).color = new vec4(0.2, 0.6, 1.0, 1.0); // Pleasant blue color
      print("NorthIndicator: Created and configured text component");
    } else {
      print("Error: Could not create text component");
      return;
    }

    // Initially position it in front of the map
    const t = this.sceneObject.getTransform();
    t.setLocalPosition(new vec3(0, 0, this.depth));
    t.setLocalRotation(quat.fromEulerAngles(0, 0, 0));

    // Update every frame
    const upd = this.updateDispatcher.createUpdateEvent("UpdateEvent");
    upd.bind(this.onUpdate.bind(this));
  }

  private onUpdate() {
    if (!this.containerFrame || !this.cameraTransform || !this.textComponent) {
      return;
    }

    const t = this.sceneObject.getTransform();
    
    // Get the camera's forward direction
    const fwd = this.cameraTransform.forward;
    
    // Project to horizontal (XZ) plane and normalize
    const dirXZ = new vec3(fwd.x, 0, fwd.z).normalize();
    
    // Flip to get north direction (since -Z is north in world space)
    const northDir = dirXZ.uniformScale(-1);
    
    // Calculate the angle between the north direction and the forward direction
    const angle = Math.atan2(northDir.x, northDir.z);
    
    // Get the radius based on the container's width
    const radius = this.containerFrame.innerSize.x * this.radiusScale;
    
    // Calculate position on the circle
    const x = Math.sin(angle) * radius;
    const y = Math.cos(angle) * radius;
    
    // Update position
    t.setLocalPosition(new vec3(x, y, this.depth));
    
    // Make the text always face the camera
    t.setLocalRotation(quat.fromEulerAngles(0, 0, 0));
  }
} 