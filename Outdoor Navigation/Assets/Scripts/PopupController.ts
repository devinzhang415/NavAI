import { ContainerFrame } from "SpectaclesInteractionKit/Components/UI/ContainerFrame/ContainerFrame";

@component
export class PopupController extends BaseScriptComponent {
    
    @input nameComponent: Text;
    @input infoComponent: Text;
    @input frame: ContainerFrame;
    
    onAwake() {
        // Initialize with default text
        this.updateInfo("", "");
        
        // Hide the frame by default
        this.hideFrame();
    }
    
    updateInfo(nameVal: string, info: string): void {
        if (this.nameComponent) {
            this.nameComponent.text = nameVal;
        }
        if (this.infoComponent) {
            this.infoComponent.text = info;
        }
    }
    
    // Method to show the frame and update content
    showFrameWithInfo(nameVal: string, info: string): void {
        if (!this.frame) return;
        
        // Update the text first
        this.updateInfo(nameVal, info);
        
        // Enable the frame's GameObject
        this.frame.getSceneObject().enabled = true;
    }
    
    // Method to hide the frame
    hideFrame(): void {
        if (!this.frame) return;
        
        // Disable the frame's GameObject
        this.frame.getSceneObject().enabled = false;
    }
    
    // You can also create a toggle method if needed
    toggleFrame(nameVal: string = "", info: string = ""): void {
        if (!this.frame) return;
        
        const frameObject = this.frame.getSceneObject();
        if (frameObject.enabled) {
            this.hideFrame();
        } else {
            this.showFrameWithInfo(nameVal, info);
        }
    }
}