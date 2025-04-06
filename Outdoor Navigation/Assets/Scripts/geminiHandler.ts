import { NEARBY_PLACES_LIMIT } from "../MapComponent/Scripts/PlacesConfig";

@component
export class  Handler extends BaseScriptComponent {
    // Expose an Image component via Lens input.
    @input imageComponent: Image;
    // Expose the RemoteServiceModule via Lens input.
    @input remoteServiceModule: RemoteServiceModule;

    // SnapPlacesController.js
    private PlacesAPI: any;

    onAwake() {
        // load your JS wrapper
        this.PlacesAPI = require("./SnapPlacesController.js");
    
        // TODO: replace these dummy coords with real GPS
        const lat = 33.776;
        const lng = -84.398;
    
        // now choosePlace will fetch nearby places internally
        this.choosePlace(lat, lng)
      }

    // choosePlace now takes possible_places and location as inputs.
    async choosePlace(lat: number, lng: number): Promise<void> {
        try {
            // Convert the image texture to a Base64 string using the asynchronous API.
            const base64Image = await this.ImageToBase64(this.imageComponent);
            
            // Build the payload using the converted image.
            const placesData = await this.PlacesAPI.getNearbyPlaces(
                lat,
                lng,
                /* accuracy */ 10,
                /* limit */ NEARBY_PLACES_LIMIT
            );

            const possible_places = placesData.places ?? [];
            if (possible_places.length === 0) {
                print("No nearby places found; aborting choosePlace.");
                return;
            }

            const requestPayload = {
                image_data: base64Image,
                possible_places: possible_places,
                location: { lat, lng }
              };

            // Create a Request object for the POST call.
            const request = new Request("https://gtxr-flask-7c107d1c5356.herokuapp.com/identify-place", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(requestPayload)
            });

            // Use RemoteServiceModule's fetch method.
            const response = await this.remoteServiceModule.fetch(request);
            if (!response.ok) {
                throw new Error("HTTP error " + response.status);
            }
            const data = await response.json();
            print("Response received: " + JSON.stringify(data));
        } catch (error) {
            print("Error in choosePlace: " + error);
        }
    }

    // ImageToBase64 converts an Image's texture to a Base64 string.
    ImageToBase64(img: Image): Promise<string> {
        return new Promise((resolve, reject) => {
            const texture = img.mainPass.baseTex;
            if (!texture) {
                reject("No texture found on image");
                return;
            }
            // Use the asynchronous encoding method.
            Base64.encodeTextureAsync(
                texture,
                resolve,
                reject,
                CompressionQuality.LowQuality,
                EncodingType.Png
            );
        });
    }
}