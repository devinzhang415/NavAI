import { SIK } from "SpectaclesInteractionKit/SIK";
import { MapComponent } from "../MapComponent/Scripts/MapComponent";
import { PopupController } from "./PopupController"
import { Handler } from "Scripts/geminiHandler";


@component
export class PinchController extends BaseScriptComponent {
    private rightHand = SIK.HandInputData.getHand("right");
    private leftHand = SIK.HandInputData.getHand("left");
    private cameraModule: CameraModule = require('LensStudio:CameraModule');
    private cameraTexture: Texture;
    
    @input
    private mapComponent: MapComponent;
    
    // New input to reference the PopupController component.
    @input
    private popupController: PopupController;
    
    @input
    geminiHandler: Handler;
    
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
    
    private async update() {
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
                print("here is when we call the function");
                
                let cameraModule = require('LensStudio:CameraModule');
                // let cameraRequest = CameraModule.createCameraRequest();           
                // let cameraTexture = cameraModule.requestCamera(cameraRequest);
                // this.uiImage.mainPass.baseTex = cameraTexture;
                let imageRequest = CameraModule.createImageRequest();
                try {
                    let imageFrame = await cameraModule.requestImage(imageRequest);
                    this.uiImage.mainPass.baseTex = imageFrame.texture;
                } catch (error) {
                    print("still image request failed");
                }
                
                // Use the geminiHandler input directly
                if (this.geminiHandler) {
                    // Show the popup immediately with "loading" text
                    if (this.popupController) {
//                        this.popupController.toggleFrame();
                        this.popupController.showFrameWithInfo("", "Loading...");
                        this.popupController.updateInfo("Identifying location...", "Loading...");
                    }
                    
                    // Set default coordinates (you can replace these with actual GPS coords)
                    const lat = 33.776;
                    const lng = -84.398;
                    
                    // First, identify the place
                    
                    
                    this.geminiHandler.choosePlace(lat, lng)
                        .then(async (result) => {
                            try {
                                // Extract the identified place from the result
                                let identifiedPlace = "Unknown location";
                                if (result.identified_place) {
                                   identifiedPlace = result.identified_place;
                                }
//                                print("Identified place: " + identifiedPlace);
                                
                                // Update the popup with the identified place and loading message
                                if (this.popupController) {
                                    this.popupController.updateInfo(identifiedPlace, "Loading description...");
                                }
                                
                                // Prepare maps info for the description generation
                                const mapsInfo = {
                                    location: { lat, lng },
                                    type: "landmark",
                                    nearby: result?.possible_places || []
                                };
                                
                                // Now generate a description for the identified place
                                const description = await this.geminiHandler.generatePlaceDescription(identifiedPlace, mapsInfo);
                                print("Generated description: " + description);
                                
                                // Update the popup with the complete information
                                if (this.popupController) {
                                    this.popupController.updateInfo(identifiedPlace, description);
                                    print("WE ARE UPDATING PROPERLY!");
                                }
                            } catch (error) {
                                print("Error processing place info: " + error);
                                if (this.popupController) {
                                    this.popupController.updateInfo("Error", "Could not get place description");
                                }
                            }
                        })
                        .catch((error) => {
                            print("Error calling geminiHandler.choosePlace: " + error);
                            if (this.popupController) {
                                this.popupController.updateInfo("Error", "Could not identify location");
                            }
                        });
                } else {
                    print("geminiHandler input not set");
                    
                    // Show popup with error message
                    if (this.popupController) {
//                        this.popupController.toggleFrame();
                        this.popupController.showFrameWithInfo("", "Location services unavailable");
                        this.popupController.updateInfo("Error", "Location services unavailable");
                    }
                }
            }
        }
        
    }
}
