# gemini_ai_api.py
import os
import google.generativeai as genai
from dotenv import load_dotenv
import base64
from typing import List, Dict, Union, Optional

# Load environment variables from .env file.
load_dotenv()

class GeminiAIAPI:
    def __init__(self):
        """
        Initialize the Gemini AI API wrapper using the official Google library.
        API key can be provided explicitly or loaded from the .env file.
        """
        self.api_key = os.getenv("GEMINI_API_KEY")
        
        # Configure the Google Generative AI library with the API key
        genai.configure(api_key=self.api_key)
        
        # Get the model
        self.model = genai.GenerativeModel('gemini-1.5-flash')
    
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
        try:
            # Construct the location string for the prompt.
            location_str = ""
            if location_data:
                location_str = f"Longitude: {location_data.get('lng')}\nLatitude: {location_data.get('lat')}"
            
            # Construct the prompt text according to guidelines.
            prompt = f"""
Based on the provided information, your task is to generate one or more Google Maps Places API query URLs that—when combined—return a maximum of {amenity_limit} unique amenities. Each query URL must target only one place type at a time.

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
        - restaurant
        - cafe
        - bar
        - museum
        - park
        - shopping_mall
        - grocery_or_supermarket
        - movie_theater
        - gym
        - library
    
    URL Format:
        Use the following template for each query URL:
        https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=YOUR_API_KEY&location={{LATITUDE}},{{LONGITUDE}}&radius={{RADIUS_IN_METERS}}&type={{PLACE_TYPE}}&keyword={{SEARCH_KEYWORD}}
    Important: The string "YOUR_API_KEY" must remain unchanged as the placeholder.

Your Task:
Using the guidelines above, generate the necessary query URLs so that the final combined result set from the Google Maps API will include a maximum of {amenity_limit} amenities, covering all required categories and any additional relevant categories based on the user's background.

Only respond with the URLs, one per line, and nothing else.
"""
            
            # Make the API request using the Google library
            response = self.model.generate_content(prompt)
            
            # Extract URLs from the response text
            query_urls = []
            if response.text:
                for line in response.text.split('\n'):
                    if "maps.googleapis.com" in line and "nearbysearch" in line:
                        query_urls.append(line.strip())
            
            return query_urls
        except Exception as e:
            print(f"Error calling Gemini AI API: {e}")
            return None
    
    def identify_place_from_image(self, image_data: Union[bytes, str], possible_places: List[str], 
                                 location_data: Optional[Dict[str, float]] = None) -> Dict:
        """
        Uses Gemini AI to identify which place from a provided list is shown in an image.
        
        Parameters:
            image_data: Binary image data or base64-encoded string of the captured image.
            possible_places: List of possible place names (e.g., ["Taco Bell", "Wendy's", "CULC", "Starbucks"]).
            location_data: Optional dictionary with keys 'lat' and 'lng' for the current location.
            
        Returns:
            A dictionary containing:
                - 'identified_place': The name of the identified place
                - 'success': Boolean indicating success of the API call
                - 'error': Error message if any
        """
        try:
            # Process image data
            if isinstance(image_data, bytes):
                # Convert binary data to base64 if necessary
                image_parts = [{"mime_type": "image/jpeg", 
                              "data": image_data}]
            elif isinstance(image_data, str):
                # Assume it's already base64 encoded
                image_parts = [{"mime_type": "image/jpeg", 
                              "data": image_data}]
            else:
                raise ValueError("Image data must be either bytes or base64-encoded string")
            
            # Construct location string if available
            location_str = ""
            if location_data:
                location_str = f"Longitude: {location_data.get('lng')}, Latitude: {location_data.get('lat')}"
            
            # Create a comma-separated list of possible places
            places_list = ", ".join(possible_places)
            
            # Construct the prompt
            prompt = f"""
You are analyzing an image to identify which specific place it shows.

Choose exactly one place from this list: {places_list}

Instructions:
1. Look at the image carefully and identify architectural features, signage, logos, and distinguishing characteristics.
2. Consider the location information if provided: {location_str}
3. The place you identify MUST be one of the places in the given list.
4. If none of the places in the list match the image with sufficient confidence, choose the closest match.

Your response must be just a single name from the list with nothing else. For example: "Taco Bell"
"""
            
            # Make the API request
            response = self.model.generate_content([prompt, *image_parts])
            
            # Process the response
            place_name = response.text.strip()
            
            # Validate that the response is one of the possible places
            if place_name in possible_places:
                return {
                    "identified_place": place_name,
                    "success": True,
                    "error": None
                }
            else:
                # Try to match with case insensitivity
                for place in possible_places:
                    if place.lower() == place_name.lower():
                        return {
                            "identified_place": place,  # Return the original case
                            "success": True,
                            "error": None
                        }
                
                # If still no match, return the response as is but mark as potentially inaccurate
                return {
                    "identified_place": place_name,
                    "success": True,
                    "error": "Warning: Identified place may not exactly match one of the provided options"
                }
                
        except Exception as e:
            error_message = str(e)
            print(f"Error identifying place from image: {error_message}")
            
            return {
                "identified_place": None,
                "success": False,
                "error": error_message
            }
        
    def test_simple_prompt(self):
        """
        Simple test to verify connection to Gemini API using the official Google library.
        Returns the response details or error information.
        """
        try:
            # Make a simple request to test the connection
            response = self.model.generate_content("Hello, tell me a 2 sentenc story please.")
            
            return {
                "success": True,
                "status_code": 200,  # The library doesn't expose the status code directly
                "response": response.text
            }
        except Exception as e:
            # Handle any exceptions that might occur
            error_message = str(e)
            error_type = type(e).__name__
            
            return {
                "success": False,
                "error": error_message,
                "error_type": error_type,
                "response": None
            }
            
    def generate_place_description(self, place_name: str, maps_info: str) -> Dict:
        """
        Uses Gemini AI to generate a concise 3-sentence description about a place.
        
        Parameters:
            place_name: The name of the place to describe
            maps_info: Google Maps information about the place
            
        Returns:
            A dictionary containing:
                - 'success': Boolean indicating success of the API call
                - 'description': The generated 3-sentence description
                - 'error': Error message if any
        """
        try:
            # Construct the prompt
            prompt = f"""
You are given information about a place called "{place_name}".
Here is information from Google Maps about this place:
{maps_info}

Write exactly 3 sentences explaining:
1. What this place is about
2. Something interesting or cool about it
3. Why someone might want to visit it

Your response should ONLY contain the 3 sentences, with no additional text, introductions, or conclusions.
"""
            
            # Make the API request
            response = self.model.generate_content(prompt)
            
            # Return the description
            return {
                "success": True,
                "description": response.text.strip(),
                "error": None
            }
            
        except Exception as e:
            error_message = str(e)
            print(f"Error generating place description: {error_message}")
            
            return {
                "success": False,
                "description": None,
                "error": error_message
            }

# Example usage:
# if __name__ == "__main__":
#     gemini = GeminiAIAPI()
#     # Test connection
#     result = gemini.test_simple_prompt()
#     print(f"Connection test: {result['success']}")
#     if result['success']:
#         print(f"Response: {result['response']}")
#     else:
#         print(f"Error: {result['error']}")
#
#     # Example of using the identify_place_from_image function:
#     # with open("path/to/image.jpg", "rb") as image_file:
#     #     image_data = image_file.read()
#     #     result = gemini.identify_place_from_image(
#     #         image_data=image_data,
#     #         possible_places=["Taco Bell", "Wendy's", "CULC", "Starbucks"],
#     #         location_data={"lat": 33.7756, "lng": -84.3963}  # Example coordinates
#     #     )
#     #     print(f"Identified place: {result['identified_place']}")
#     #     print(f"Confidence: {result['confidence']}")
#     #     print(f"Reasoning: {result['reasoning']}")
