// @input Component.HandTracking handTracker

// Require Spectacles Gesture Module
const Gesture = require('SceneUnderstandingModule');

// Initialize when scene starts
function initialize() {
    const handType = Gesture.HandType.Dominant; // Tracks user's dominant hand
    const pinchEvent = Gesture.getPinchStartEvent(handType);
    
    pinchEvent.bind(onPinchDetected);
}

function onPinchDetected(eventData) {
    print("PINCH DETECTED!");
    // Spawn your box here (see next step)
}

// Delay initialization for scene load
script.createEvent("OnStartEvent").bind(initialize);
