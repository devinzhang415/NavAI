# places_api.py
import os
import requests
from dotenv import load_dotenv

# Load environment variables from .env file.
load_dotenv()

class GooglePlacesAPI:
    def __init__(self, query_url):
        """
        Initialize the GooglePlacesAPI wrapper with your API key.
        If no API key is provided, it will use the one from the .env file.
        """
        self.api_key = os.getenv("GOOGLE_API_KEY")
        self.nearby_search_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        self.details_url = "https://maps.googleapis.com/maps/api/place/details/json"

    def get_nearby_places(self, lat, lng, radius=50):
        """
        Search for places near the specified latitude and longitude within a given radius.
        Returns the JSON response from the API.
        """
        params = {
            "location": f"{lat},{lng}",
            "radius": radius,
            "key": self.api_key
        }
        try:
            response = requests.get(self.nearby_search_url, params=params)
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Error during nearby search: {e}")
            return None

    def get_place_details(self, place_id):
        """
        Retrieve detailed information about a place given its place_id.
        Returns the JSON response from the API.
        """
        params = {
            "place_id": place_id,
            "key": self.api_key
        }
        try:
            response = requests.get(self.details_url, params=params)
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Error retrieving place details: {e}")
            return None

# Example usage:
# if __name__ == "__main__":
#     places_api = GooglePlacesAPI()
#     lat, lng = 40.7128, -74.0060  # Example coordinates (New York City)
#     nearby = places_api.get_nearby_places(lat, lng)
#     if nearby and nearby.get("results"):
#         first_place = nearby["results"][0]
#         details = places_api.get_place_details(first_place["place_id"])
#         print(details)
