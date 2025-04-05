
from flask import Flask, request, jsonify
import os
from dotenv import load_dotenv
import base64
from typing import List

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Initialize APIs only if needed, with proper error handling
try:
    from google_places_api import GooglePlacesAPI
    from google_static_maps_api import GoogleStaticMapsAPI
    from gemini_ai_api import GeminiAIAPI
    
    # Add a dummy URL for initialization (will be overridden by the actual URLs in the class)
    places_api = GooglePlacesAPI("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
    maps_api = GoogleStaticMapsAPI()
    gemini_api = GeminiAIAPI()
    apis_loaded = True
except Exception as e:
    print(f"Error loading APIs: {e}")
    apis_loaded = False

@app.route('/', methods=['GET'])
def home():
    return jsonify({
        "status": "ok",
        "message": "GTXR API is running",
        "apis_loaded": apis_loaded
    })

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({
        "status": "ok",
        "message": "API is running",
        "apis_loaded": apis_loaded
    })


@app.route('/get_place_info', methods=['POST'])
def get_place_info():
    if not apis_loaded:
        return jsonify({"error": "Google APIs not loaded correctly"}), 500
        
    try:
        data = request.get_json()
        lat = data.get('lat')
        lng = data.get('lng')
        
        if not lat or not lng:
            return jsonify({"error": "Missing lat or lng parameters"}), 400
        
        nearby_places = places_api.get_nearby_places(lat, lng)
        if nearby_places and nearby_places.get("results"):
            first_place = nearby_places["results"][0]
            details = places_api.get_place_details(first_place["place_id"])
        else:
            details = {"error": "No place found"}
            
        return jsonify(details)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/identify-place', methods=['POST'])
def identify_place():
    print("Starting identify_place function...")
    if not apis_loaded:
        print("APIs not loaded correctly")
        return jsonify({"error": "Gemini API not loaded correctly"}), 500
    
    try:
        # Check if the request is JSON or form data
        print(f"Request content type: {request.content_type}")
        print(f"Request size: {request.content_length} bytes")
        
        if request.is_json:
            data = request.get_json()
            
            # Validate required fields
            if not data.get('image_data'):
                return jsonify({"error": "Missing image_data parameter"}), 400
            
            if not data.get('possible_places') or not isinstance(data.get('possible_places'), list):
                return jsonify({"error": "Missing or invalid possible_places parameter (should be a list)"}), 400
            
            # Extract data
            image_data = data['image_data']
            possible_places = data['possible_places']
            location_data = data.get('location')
            
            # Process base64 data if needed
            if image_data.startswith('data:image'):
                # Remove data URL prefix
                image_data = image_data.split('base64,')[1]
            
            # Base64 decode if needed
            if not isinstance(image_data, bytes):
                try:
                    image_data = base64.b64decode(image_data)
                except:
                    # If it can't be decoded, pass it as is (assuming it's already in a format Gemini can use)
                    pass
            
        else:  # Form data
            # Check for image file
            if 'image' not in request.files:
                return jsonify({"error": "Missing image file"}), 400
            
            image_file = request.files['image']
            if image_file.filename == '':
                return jsonify({"error": "No selected file"}), 400
            
            # Read the image file
            image_data = image_file.read()
            
            # Get possible places (comma-separated string)
            possible_places_str = request.form.get('possible_places', '')
            if not possible_places_str:
                return jsonify({"error": "Missing possible_places parameter"}), 400
            
            possible_places = [place.strip() for place in possible_places_str.split(',')]
            
            # Get location data if provided
            location_data = None
            lat = request.form.get('lat')
            lng = request.form.get('lng')
            
            if lat and lng:
                try:
                    location_data = {
                        "lat": float(lat),
                        "lng": float(lng)
                    }
                except ValueError:
                    return jsonify({"error": "Invalid lat or lng values"}), 400
        
        # Before calling the Gemini API
        print("About to call Gemini API with image data length:", 
              len(image_data) if isinstance(image_data, bytes) else "non-bytes data")
        print("Possible places:", possible_places)
        
        # Call the Gemini API
        result = gemini_api.identify_place_from_image(
            image_data=image_data,
            possible_places=possible_places,
            location_data=location_data
        )
        
        print("Gemini API call completed with result:", result)
        return jsonify(result)
        
    except Exception as e:
        import traceback
        print(f"DETAILED ERROR in identify_place endpoint: {str(e)}")
        print(traceback.format_exc())
        return jsonify({
            "success": False,
            "identified_place": None,
            "error": str(e)
        }), 500

@app.route('/test_gemini', methods=['GET'])
def test_gemini():
    if not apis_loaded:
        return jsonify({"error": "APIs not loaded correctly"}), 500
        
    try:
        # Test with a simple prompt
        location_data = {"lat": 40.7128, "lng": -74.0060}  # New York City coordinates
        test_result = gemini_api.generate_query_urls(
            detected_text="Test request",
            location_data=location_data,
            amenity_limit=3,
            user_summary="Testing Gemini API connection"
        )
        
        if test_result is not None:
            return jsonify({
                "status": "success",
                "message": "Successfully connected to Gemini API",
                "api_key_configured": bool(gemini_api.api_key),
                "endpoint_configured": gemini_api.endpoint,
                "test_results": test_result
            })
        else:
            return jsonify({
                "status": "error",
                "message": "Failed to get response from Gemini API",
                "api_key_configured": bool(gemini_api.api_key),
                "endpoint_configured": gemini_api.endpoint
            }), 500
    except Exception as e:
        return jsonify({
            "status": "error", 
            "message": f"Error testing Gemini API: {str(e)}",
            "api_key_configured": apis_loaded and bool(gemini_api.api_key) if 'gemini_api' in locals() else "Unknown"
        }), 500

@app.route('/test_gemini_direct', methods=['GET'])
def test_gemini_direct():
    """
    Test endpoint that directly uses the Google Gemini API format
    """
    if not apis_loaded:
        return jsonify({"error": "APIs not loaded correctly"}), 500
        
    try:
        # Use the new test_simple_prompt method
        test_result = gemini_api.test_simple_prompt()
        
        return jsonify({
            "status": "success" if test_result.get("success") else "error",
            "message": "Connected to Gemini API" if test_result.get("success") else "Failed to connect to Gemini API",
            "api_key_configured": bool(gemini_api.api_key),
            "endpoint_details": test_result,
            "raw_error": test_result.get("error") if not test_result.get("success") else None
        })
    except Exception as e:
        return jsonify({
            "status": "error", 
            "message": f"Error testing Gemini API directly: {str(e)}",
            "trace": str(e)
        }), 500

@app.route('/gemini_ocr', methods=['POST'])
def gemini_ocr():
    # Get the image from the request

    if 'image' not in request.files:
        return jsonify({"error": "No image provided"}), 400
    
    image_blob = request.files['image']
    # Read the image data
    image_data = image_blob.read()

    google_maps_text = request.form['google_maps_info']
    
    client = genai.Client(api_key=os.environ['GEMINI_API_KEY'])
    response = client.models.generate_content(
        model='gemini-2.0-flash-exp',
        contents=['In this picture, are there any distinctive text? If so return ONLY the text, otherwise output "None"', types.Part.from_bytes(data=image_data, mime_type='image/jpeg')]
    )
    words = response.text.split('\n')
    return jsonify({'words': words})

if __name__ == '__main__':
    # Use the PORT environment variable provided by Heroku, or default to 5000
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)
