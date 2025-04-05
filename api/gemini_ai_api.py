# gemini_ai_api.py
import os
import requests
from dotenv import load_dotenv

# Load environment variables from .env file.
load_dotenv()

class GeminiAIAPI:
    def __init__(self):
        """
        Initialize the Gemini AI API wrapper.
        API key and endpoint can be provided explicitly or loaded from the .env file.
        """
        self.api_key = os.getenv("GEMINI_API_KEY")
        self.endpoint = os.getenv("GEMINI_API_ENDPOINT", "https://api.gemini.ai/v1/generate")
    
    def generate_query_urls(self, image_data=None, detected_text="", location_data=None, amenity_limit=15, user_summary=""):
        """
        Uses Gemini AI to generate Google Places API query URLs.
        
        Parameters:
            image_data: Optional; binary or base64-encoded image data captured from the AR view.
            detected_text: Text extracted from the image (if any).
            location_data: Dictionary with keys 'lat' and 'lng' indicating the current location.
            amenity_limit: Maximum total number of amenities to be returned (e.g., 15).
            user_summary: Additional summary information about the user, if available.
            
        Returns:
            A list of generated query URLs or None if an error occurred.
        """
        # Construct the location string for the prompt.
        location_str = ""
        if location_data:
            location_str = f"Longitude: {location_data.get('lng')}\nLatitude: {location_data.get('lat')}"
        
        # Construct the prompt text according to guidelines.
        prompt = f"""
Below is a summary of a user. Based on the provided information, your task is to generate one or more Google Maps Places API query URLs that—when combined—return a maximum of {amenity_limit} unique amenities. Each query URL must target only one place type at a time.

Requirements:
    Total Limit:
        The combined queries should yield no more than {amenity_limit} total amenities.

    User Data:
        Location: {location_str}

    Detected Text: {detected_text}

    Additional User Summary: {user_summary}

Google Maps Places API Query Guidelines:
    Place Types:
        Select from the following list (you may choose one per query):
        [list of google places categories]
    URL Format:
        Use the following template for each query URL:
        https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=YOUR_API_KEY&location={{LATITUDE}},{{LONGITUDE}}&radius={{RADIUS_IN_METERS}}&type={{PLACE_TYPE}}&keyword={{SEARCH_KEYWORD}}
    Important: The string "YOUR_API_KEY" must remain unchanged as the placeholder.

Your Task:
Using the guidelines above, generate the necessary query URLs so that the final combined result set from the Google Maps API will include a maximum of {amenity_limit} amenities, covering all required categories and any additional relevant categories based on the user's background.
"""
        # Build the payload. Attach the image data if provided.
        payload = {
            "prompt": prompt,
            "image": image_data  # Depending on Gemini AI's spec, this may be omitted if not supported.
        }
        
        headers = {
            "Content-Type": "application/json",
            "Authorization": f"Bearer {self.api_key}"
        }
        
        try:
            response = requests.post(self.endpoint, json=payload, headers=headers)
            response.raise_for_status()
            data = response.json()
            # Assume the response contains a 'query_urls' field with a list of URLs.
            query_urls = data.get("query_urls", [])
            return query_urls
        except requests.RequestException as e:
            print(f"Error calling Gemini AI API: {e}")
            return None

# Example usage:
# if __name__ == "__main__":
#     gemini = GeminiAIAPI()
#     # Optionally load or capture image_data and detected_text from your AR tool (e.g., Spectacles).
#     urls = gemini.generate_query_urls(
#         detected_text="Sample detected writing from the captured image.",
#         location_data={"lat": 40.7128, "lng": -74.0060},
#         amenity_limit=15,
#         review_summary="User prefers local artisan coffee and vintage bookstores."
#     )
#     print("Generated query URLs:", urls)
