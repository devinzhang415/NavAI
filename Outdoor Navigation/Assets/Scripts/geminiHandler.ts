@component
export class geminiHandler extends BaseScriptComponent {
    // Expose an Image component via Lens input.
    @input imageComponent: Image;
    // Expose the RemoteServiceModule via Lens input.
    @input remoteServiceModule: RemoteServiceModule;

    onAwake() {
        // For testing, call choosePlace with a sample list and coordinates.
        const places = ["Wendy's", "CULC", "Georgia Tech", "Taco Bell"];
        const randomLocation = { lat: 33.776, lng: -84.398 };
        this.choosePlace(places, randomLocation);
    }

    // choosePlace now takes possible_places and location as inputs.
    async choosePlace(possible_places: string[], location: { lat: number; lng: number }): Promise<void> {
        try {
            // Convert the image texture to a Base64 string using the asynchronous API.
            const base64Image = await this.ImageToBase64(this.imageComponent);
            
            // Build the payload using the converted image.
            const requestPayload = {
                image_data: base64Image,
                possible_places: possible_places,
                location: location
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