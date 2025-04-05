import flask
from flask import Flask, request, jsonify, Response
from google_places_api import GooglePlacesAPI
from google_static_maps_api import GoogleStaticMapsAPI
from google import genai
from google.genai import types
import json
import os

app = Flask(__name__)
places_api = GooglePlacesAPI(query_url="https://maps.googleapis.com/maps/api/place/nearbysearch/json")
maps_api = GoogleStaticMapsAPI()

@app.route('/get_place_info', methods=['POST'])
def get_place_info():
    data = request.get_json()
    lat = data.get('lat')
    lng = data.get('lng')
    
    nearby_places = places_api.get_nearby_places(lat, lng)
    if nearby_places and nearby_places.get("results"):
        first_place = nearby_places["results"][0]
        details = places_api.get_place_details(first_place["place_id"])
    else:
        details = {"error": "No place found"}
        
    return jsonify(details)

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
    app.run(host='0.0.0.0', port=5000)
