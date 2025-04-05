import { SIK } from "SpectaclesInteractionKit/SIK";
import { MapComponent } from "../MapComponent/Scripts/MapComponent";


@component
export class PinchController extends BaseScriptComponent {
    private rightHand = SIK.HandInputData.getHand("right");
    private leftHand = SIK.HandInputData.getHand("left");
    private cameraModule: CameraModule = require('LensStudio:CameraModule');
    private cameraTexture: Texture;
    
    @input
    private mapComponent: MapComponent;
    
    
    private leftDown : boolean;
    private rightDown : boolean;
    private isClosed: boolean;
    @input
    uiImage: Image | undefined;
    
    onAwake() {
        
        this.leftDown = false;
        this.rightDown = false;
        this.isClosed = false;
        // Bind the update event
        this.createEvent("UpdateEvent").bind(this.update.bind(this));
        
        this.leftHand.onPinchDown.add(() => {
          this.leftDown = true;
        });
        this.rightHand.onPinchDown.add(() => {
          this.rightDown = true;
        });
        
        this.leftHand.onPinchUp.add(() => {
            this.leftDown = false;
        });
        this.rightHand.onPinchUp.add(() => {
            this.rightDown = false;
        })
        
    }
    
    private update() {
        if (!this.isClosed) {
            // if open and both are down then set to close
            if (this.rightDown && this.leftDown) {
                print("Both Down")
                this.isClosed = true;
            }
        } else {
            // If closed, and both fingers are up then open
            if (!this.rightDown && !this.leftDown) {
                this.isClosed = false;
                print("here is when we call the function")
                
                let cameraModule = require('LensStudio:CameraModule');
                let cameraRequest = CameraModule.createCameraRequest();           
                let cameraTexture = cameraModule.requestCamera(cameraRequest);
                this.uiImage.mainPass.baseTex = cameraTexture
                    
                
                // Run Fetch to find the right location, and pull that locations x, y 
                
                let x = 0;
                let y = 0;
                const position = new vec2(x, y);

                this.mapComponent.addPinByLocalPosition(position)
                
            
            // this.mapComponent.addPinByLocalPosition(vec2.zero());
            }
        }
        
    }
}