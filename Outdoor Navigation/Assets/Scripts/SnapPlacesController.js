// @input Asset.RemoteServiceModule remoteServiceModule

// Import module
const Module = require("../Snapchat Places API API Module");
const ApiModule = new Module.ApiModule(script.remoteServiceModule);

// import { NEARBY_PLACES_LIMIT } from "./PlacesConfig";

const NEARBY_PLACES_LIMIT = 20;

/**
 * Place retrieval utilities
 */
const PlacesAPI = {
    // // Get information about a specific place by ID
    // getPlaceById: function(placeId) {
    //     print("Fetching place with ID: " + placeId);
    //     return ApiModule.get_place({
    //         parameters: {
    //             "place_id": placeId
    //         }
    //     }).then((response) => {
    //         print("Place details retrieved successfully");
    //         const placeData = response.bodyAsJson();
    //         print("Place data: " + JSON.stringify(placeData, null, 2));
    //         return placeData;
    //     }).catch((error) => {
    //         print("Error fetching place: " + error);
    //         throw error;
    //     });
    // },
    
    // Get nearby places based on coordinates
    getNearbyPlaces: function(latitude, longitude, accuracy = 10, limit = NEARBY_PLACES_LIMIT) {
        print("Finding places near: " + latitude + ", " + longitude);
        return ApiModule.get_nearby_places({
            parameters: {
                "lat": latitude.toString(),
                "lng": longitude.toString(),
                "gps_accuracy_m": accuracy.toString(),
                "places_limit": limit.toString()
            }
        }).then((response) => {
            print("Nearby places retrieved successfully");
            const placesData = response.bodyAsJson();
            const placesCount = (placesData.places && placesData.places.length) || 0;
            print("Found " + placesCount + " places nearby");
            print("Nearby places: " + JSON.stringify(placesData, null, 2));
            return placesData;
        }).catch((error) => {
            print("Error fetching nearby places: " + error);
            throw error;
        });
    },
    
    // Get detailed profiles for multiple places
    getPlacesProfiles: function(placeIds, locale = "en_US") {
        const placeIdsString = Array.isArray(placeIds) ? placeIds.join(",") : placeIds;
        print("Fetching profiles for places: " + placeIdsString);
        
        return ApiModule.get_places_profile({
            parameters: {
                "place_ids": placeIdsString,
                "locale": locale
            }
        }).then((response) => {
            print("Place profiles retrieved successfully");
            const profilesData = response.bodyAsJson();
            print("Place profiles: " + JSON.stringify(profilesData, null, 2));
            return profilesData;
        }).catch((error) => {
            print("Error fetching place profiles: " + error);
            throw error;
        });
    }
};

// Example usage - uncomment and modify as needed:

// 1. Get a specific place
// PlacesAPI.getPlaceById("ChIJgUbEo8cfqokR5lP9_Wh_DaM");

// 2. Get nearby places (New York City coordinates example)
// PlacesAPI.getNearbyPlaces(40.7128, -74.0060, 100, 5);

// 3. Get profiles for multiple places
// PlacesAPI.getPlacesProfiles(["ChIJgUbEo8cfqokR5lP9_Wh_DaM", "ChIJZ4JI8YJZBI0RGHoFsP_rVN8"]);
// ...existing code...

// Full example - find places and then get detailed profiles
function demonstrateFullWorkflow() {
    // Example coordinates (Times Square, NYC)
    const lat = 40.7580;
    const lng = -73.9855;
    
    PlacesAPI.getNearbyPlaces(lat, lng, 50, 3)
        .then((nearbyData) => {
            if (nearbyData.places && nearbyData.places.length > 0) {
                // Extract place IDs from nearby places
                const placeIds = nearbyData.places.map(place => place.id);
                print("Found place IDs: " + placeIds.join(", "));
                
                // Get detailed profiles for these places
                return PlacesAPI.getPlacesProfiles(placeIds);
            } else {
                print("No places found nearby");
            }
        })
        .catch((error) => {
            print("Workflow error: " + error);
        });
}

// Add onAwake function to automatically demonstrate the API
function onAwake() {
    print("=== Snapchat Places API Demonstration ===");
    
    // Example 1: Get place by ID (Empire State Building)
    PlacesAPI.getPlaceById("ChIJaXQRs6lZwokRY6EFpJnhNNE")
        .then(() => {
            print("\n=== Example 2: Get Nearby Places ===");
            // Example 2: Get nearby places (Central Park coordinates)
            return PlacesAPI.getNearbyPlaces(40.7812, -73.9665, 100, 3);
        })
        .then((nearbyData) => {
            print("\n=== Example 3: Full Workflow ===");
            // Example 3: Run the full workflow demonstration
            demonstrateFullWorkflow();
        })
        .catch(error => {
            print("API demonstration error: " + error);
        });
        
    print("API calls initiated. Check console for results...");
}

// Execute the onAwake function when script initializes

module.exports = PlacesAPI;

onAwake();