# static_maps_api.py
import os
import requests
from dotenv import load_dotenv

# Load environment variables from .env file.
load_dotenv()

class GoogleStaticMapsAPI:
    def __init__(self):
        """
        Initialize the GoogleStaticMapsAPI wrapper with your API key.
        If no API key is provided, it will use the one from the .env file.
        """
        self.api_key = os.getenv("GOOGLE_API_KEY")
        self.static_map_url = "https://maps.googleapis.com/maps/api/staticmap"

    def get_static_map(self, center, zoom=15, size="300x300", maptype="roadmap", markers=None):
        """
        Retrieve a static map image based on the center coordinates.
        
        Parameters:
          - center: A string in the format "lat,lng" (e.g., "40.7128,-74.0060")
          - zoom: Map zoom level (default 15)
          - size: Dimensions of the image (default "300x300")
          - maptype: Type of map (default "roadmap")
          - markers: Optional; add markers to the map (e.g., "color:blue|label:S|40.7128,-74.0060")
        
        Returns the image data (bytes) if successful.
        """
        params = {
            "center": center,
            "zoom": zoom,
            "size": size,
            "maptype": maptype,
            "key": self.api_key
        }
        if markers:
            params["markers"] = markers
        
        try:
            response = requests.get(self.static_map_url, params=params)
            response.raise_for_status()
            return response.content  # image bytes
        except requests.RequestException as e:
            print(f"Error retrieving static map: {e}")
            return None

# Example usage:
# if __name__ == "__main__":
#     maps_api = GoogleStaticMapsAPI()
#     center = "40.7128,-74.0060"  # Example center (New York City)
#     image_data = maps_api.get_static_map(center)
#     if image_data:
#         with open("minimap.png", "wb") as f:
#             f.write(image_data)
