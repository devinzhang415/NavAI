// Distance in meters around the location to search for places
export let NEARBY_PLACES_RANGE = 100;

// Category filters
export let NEARBY_PLACES_FILTER = ["Coffee", "Bar", "Restaurant"];

// Maximum number of places to return in a query
export let NEARBY_PLACES_LIMIT = 20;

export function setNearbyPlacesRange(newRange: number) {
  print(`Setting nearby places range from ${NEARBY_PLACES_RANGE}m to ${newRange}m`);
  NEARBY_PLACES_RANGE = newRange;
  print(`New nearby places range: ${NEARBY_PLACES_RANGE}m`);
}

export function setNearbyPlacesFilter(newFilter: string[]) {
  NEARBY_PLACES_FILTER = newFilter;
}

export function setNearbyPlacesLimit(newLimit: number) {
  NEARBY_PLACES_LIMIT = newLimit;
}

export function updateNearbyPlacesConfig(newRange: number, newFilter: string[], newLimit: number) {
  NEARBY_PLACES_RANGE = newRange;
  NEARBY_PLACES_FILTER = newFilter;
  NEARBY_PLACES_LIMIT = newLimit;
}

// Export as a module
export default {
  NEARBY_PLACES_RANGE,
  NEARBY_PLACES_FILTER,
  NEARBY_PLACES_LIMIT,
  setNearbyPlacesRange,
  setNearbyPlacesFilter,
  setNearbyPlacesLimit,
  updateNearbyPlacesConfig
};