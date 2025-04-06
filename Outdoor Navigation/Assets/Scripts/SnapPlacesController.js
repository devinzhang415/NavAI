


const Module    = require("../Snapchat Places API API Module");
const ApiModule = require("LensStudio:RemoteServiceModule");


let NEARBY_PLACES_LIMIT = 20;

const PlacesAPI = {
 /**
  * Fetch a place by its ID
  * @param {string} placeId
  * @returns {Promise<PlaceInfo>}
  */
 getPlaceById(placeId) {
   print("Fetching place with ID: " + placeId);
   return ApiModule.get_place({
     parameters: { place_id: placeId }
   })
   .then(response => {
     print("Place details retrieved successfully");
     const placeData = response.bodyAsJson();
     print("Place data:", JSON.stringify(placeData, null, 2));
     return placeData;
   })
   .catch(error => {
     print("Error fetching place:", error);
     throw error;
   });
 },

 /**
  * Find nearby places
  * @param {number} latitude
  * @param {number} longitude
  * @param {number} [accuracy=10]
  * @param {number} [limit=NEARBY_PLACES_LIMIT]
  * @returns {Promise<{ places: PlaceInfo[] }>}
  */
 getNearbyPlaces(latitude, longitude, accuracy = 10, limit = NEARBY_PLACES_LIMIT) {
   print(`Finding places near: ${latitude}, ${longitude}`);
   return ApiModule.get_nearby_places({
     parameters: {
       lat: latitude.toString(),
       lng: longitude.toString(),
       gps_accuracy_m: accuracy.toString(),
       places_limit: limit.toString()
     }
   })
   .then(response => {
     print("Nearby places retrieved successfully");
     const placesData = response.bodyAsJson();
     print("Nearby places:", JSON.stringify(placesData, null, 2));
     return placesData;
   })
   .catch(error => {
     print("Error fetching nearby places:", error);
     throw error;
   });
 },

 /**
  * Get detailed profiles for a list of place IDs
  * @param {string[]|string} placeIds
  * @param {string} [locale="en_US"]
  * @returns {Promise<{ profiles: PlaceInfo[] }>}
  */
 getPlacesProfiles(placeIds, locale = "en_US") {
   const ids = Array.isArray(placeIds) ? placeIds.join(",") : placeIds;
   print("Fetching profiles for places:", ids);
   return ApiModule.get_places_profile({
     parameters: { place_ids: ids, locale }
   })
   .then(response => {
     print("Place profiles retrieved successfully");
     const profilesData = response.bodyAsJson();
     print("Place profiles:", JSON.stringify(profilesData, null, 2));
     return profilesData;
   })
   .catch(error => {
     print("Error fetching place profiles:", error);
     throw error;
   });
 }
};

function onAwake() {
  
};

// module.exports = PlacesAPI;
onAwake();
