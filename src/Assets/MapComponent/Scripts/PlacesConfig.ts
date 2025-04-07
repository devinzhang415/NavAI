// Category filters
export let NEARBY_PLACES_FILTER = ["Coffee", "Bar", "Restaurant"];

// Maximum number of places to return in a query
export let NEARBY_PLACES_LIMIT = 20;

export let NEARBY_PLACES_RANGE = 30;

export function setNearbyPlacesFilter(newFilter: string[]) {
  NEARBY_PLACES_FILTER = newFilter;
}

export function setNearbyPlacesLimit(newLimit: number) {
  NEARBY_PLACES_LIMIT = newLimit;
}

export function updateNearbyPlacesConfig(newFilter: string[], newLimit: number) {
  NEARBY_PLACES_FILTER = newFilter;
  NEARBY_PLACES_LIMIT = newLimit;
}

// Export as a module
//export default {
//  NEARBY_PLACES_FILTER,
//  NEARBY_PLACES_LIMIT,
//  NEARBY_PLACES_RANGE,
//  setNearbyPlacesFilter,
//  setNearbyPlacesLimit,
//  updateNearbyPlacesConfig
//};