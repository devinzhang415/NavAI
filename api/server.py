from flask import Flask, request, jsonify
from google_places_api import GooglePlacesAPI
from google_static_maps_api import GoogleStaticMapsAPI

app = Flask(__name__)
places_api = GooglePlacesAPI()
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

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
