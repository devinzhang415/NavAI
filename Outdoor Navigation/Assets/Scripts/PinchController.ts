import { SIK } from "SpectaclesInteractionKit/SIK";

@component
export class PinchController extends BaseScriptComponent {
    private rightHand = SIK.HandInputData.getHand("right");
    private leftHand = SIK.HandInputData.getHand("left");
    private cameraModule: CameraModule = require('LensStudio:CameraModule');
//    private cameraRequest: CameraModule.CameraRequest;
    private cameraTexture: Texture;
//    private cameraTextureProvider: CameraTextureProvider;

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
        
//        this.createEvent('OnStartEvent').bind(() => {
//          this.cameraRequest = CameraModule.createCameraRequest();
//          this.cameraRequest.cameraId = CameraModule.CameraId.Default_Color;
//    
//          this.cameraTexture = this.cameraModule.requestCamera(this.cameraRequest);
//          this.cameraTextureProvider = this.cameraTexture
//            .control as CameraTextureProvider;
//    
//          this.cameraTextureProvider.onNewFrame.add((cameraFrame) => {
//            if (this.uiImage) {
//              this.uiImage.mainPass.baseTex = this.cameraTexture;
//            }
//          });
//        });
    }
    
    private update() {
//        print('update called');
//        print(this.isClosed);
//        print(this.rightDown);
//        print(this.leftDown);
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
                print("ACTION")
                
             let cameraModule = require('LensStudio:CameraModule');
             let cameraRequest = CameraModule.createCameraRequest();
//             cameraRequest.id = CameraModule.CameraId.Left_Color;
//                
                let cameraTexture = cameraModule.requestCamera(cameraRequest);
                print(typeof(cameraTexture))
                this.uiImage.mainPass.baseTex = cameraTexture      
            }
        }
        
    }
}