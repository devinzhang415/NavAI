const SnapchatPlacesAPI = require('SnapchatPlacesAPI');


@component
export class PlacesExample extends BaseScriptComponent {
    private placesApi = require('SnapchatPlacesAPI');
    
    onAwake() {
        // Initialize the API if necessary
        if (this.placesApi.initialize) {
            this.placesApi.initialize();
        }
        
        // Example usage: Fetch places near a given location
        this.placesApi.getPlaces({ lat: 33.7756, lng: -84.3963 })
            .then((places) => {
                print("Fetched places: " + JSON.stringify(places));
            })
            .catch((err) => {
                print("Error fetching places: " + err);
            });
    }
}
