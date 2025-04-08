# NavAI - Reimagining Navigation Through AR

[![MLH Winner](https://img.shields.io/badge/MLH%20Winner-Best%20Use%20of%20Gemini%20AI-F7302F?style=for-the-badge&logo=mlh&logoColor=white)](https://mlh.io)
[![Gemini AI](https://img.shields.io/badge/Powered%20by-Gemini%20AI-1A73E8?style=for-the-badge&logo=google&logoColor=white)](https://deepmind.google/technologies/gemini/)
[![Spectacles](https://img.shields.io/badge/Spectacles-Light%20Gray?color=FFFC00&logo=snapchat&logoColor=white)](https://spectacles.com)
[![TypeScript](https://img.shields.io/badge/TypeScript-Light%20Gray?color=3178C6&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Snap AR](https://img.shields.io/badge/Snap%20AR-Light%20Gray?color=000000&logo=snapchat&logoColor=white)](https://ar.snap.com/)

> 🏆 **Winner of "Best Use of Gemini AI" at ImmerseGT 2024** - Georgia Tech's Premier VR/XR Hackathon

An AR-powered navigation platform that transforms urban exploration through natural voice commands, dynamic AR mapping, and AI-generated insights. Using Snap Spectacles and Gemini AI, NavAI delivers a hands-free, immersive wayfinding experience for modern explorers.

<a href="https://ibb.co/sd1nPwHx"><img src="./Outdoor Navigation/README-ref/sample-list-outdoor-navigation-rounded-edges.gif" alt="AR Navigation Demo" width="500" /></a>

---

## Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Directory Structure](#directory-structure)
- [Modules and Functions](#modules-and-functions)
  - [Voice Interaction & Gemini AI](#voice-interaction--gemini-ai)
  - [Dynamic AR Mapping](#dynamic-ar-mapping)
  - [Snapshot Analysis](#snapshot-analysis)
- [Usage](#usage)
- [License](#license)

---

## Overview

NavAI reimagines navigation by integrating immersive AR with AI-driven natural language understanding and image analysis. With voice-activated queries and real-time AR map overlays, users can effortlessly discover points of interest and obtain contextual information—all without ever pulling out their phone.

---

## Tech Stack

### Hardware
> **Snap Spectacles** — AR-enabled smart glasses  
> **Built-in Camera & Mic** — For seamless image capture and voice input  
> **Location Sensors** — Precise geolocation for dynamic mapping

### Core Technologies
> **TypeScript** — Strongly-typed development environment  
> **Snap AR SDK** — AR content rendering and spatial tracking  
> **SIK (Spectacles Interaction Kit)** — Gesture recognition and interaction

### AI & APIs
> **Google Gemini AI** — Natural language processing and visual analysis  
> **Google Places API** — Dynamic retrieval of nearby points of interest  
> **Custom Flask Backend** — Image processing and AI integration

---

## Directory Structure

```
/Outdoor Navigation
├── Assets/                      # Main project assets and code
│   ├── VoiceController.ts      # Voice command processing
│   ├── SpeechToText.ts         # Speech recognition integration
│   ├── Scripts/                # Core TypeScript/JavaScript files
│   │   ├── geminiHandler.ts    # Gemini AI integration
│   │   ├── PlacesWrapper.ts    # Places API wrapper
│   │   ├── MapUIController.ts  # Map interface controls
│   │   ├── MapManipulation.ts  # Map interaction handling
│   │   ├── MapConstants.ts     # Configuration constants
│   │   ├── NorthIndicator.ts   # Compass functionality
│   │   ├── PinchController.ts  # Gesture recognition
│   │   ├── PopupController.ts  # Information display
│   │   ├── QuestMarkController.ts  # Navigation markers
│   │   ├── UICollisionDetector.ts  # UI interaction handling
│   │   ├── MapMessageController.ts  # Map messaging system
│   │   ├── MapContainerController.ts # Map container management
│   │   └── Logging.ts          # Logging utilities
│   ├── MapComponent/           # Map visualization system
│   │   ├── Scripts/           # Map-specific scripts
│   │   ├── Prefabs/           # Reusable map elements
│   │   ├── Materials/         # Map styling assets
│   │   └── Textures/          # Map visual resources
│   ├── SpectaclesInteractionKit/  # SIK integration
│   ├── Device Camera Texture   # Camera input handling
│   ├── VoiceInput             # Voice input configuration
│   └── SoundOutput            # Audio output handling
├── Support/                    # Project support files
├── Workspaces/                # Lens Studio workspace configs
├── README-ref/                # Documentation assets
├── tsconfig.json              # TypeScript configuration
└── OutdoorNavigation.esproj   # Project configuration file
```

### Key Components

- **Voice Processing**: `VoiceController.ts` and `SpeechToText.ts` handle wake word detection ("Hey Alice") and voice commands
- **Map System**: Multiple controllers (`MapUIController`, `MapManipulation`, etc.) manage the AR map experience
- **AI Integration**: `geminiHandler.ts` coordinates between Gemini AI and the system, while `PlacesWrapper.ts` handles Places API interactions
- **Interaction**: `PinchController.ts` and `PopupController.ts` manage user input and feedback
- **Supporting Systems**: Includes camera, voice input, and sound output configurations

The project follows a modular architecture, separating concerns between voice processing, map visualization, AI integration, and user interaction. This structure enables easy maintenance and future enhancements of individual components.

---

## Modules and Functions

### Voice Interaction & Gemini AI

- **Purpose:** Interprets natural language queries (e.g., "Find me a quiet coffee shop") via voice commands.
- **Functionality:** Uses Gemini AI to map user intent to relevant location categories, generating structured requests for the Places API.

### Dynamic AR Mapping

- **Purpose:** Renders a real-time, interactive AR map overlay displaying nearby points of interest.
- **Functionality:** Updates map pins dynamically as the user moves, ensuring location-aware navigation.

### Snapshot Analysis

- **Purpose:** Captures and processes visual data using simple gesture controls.
- **Functionality:** Uses a pinch gesture to capture surroundings and leverages OCR and AI to generate rich, contextual descriptions of buildings or landmarks.

---

## Usage

1. **Activate Voice Command:** Say the trigger phrase (e.g., "Hey Alice") and ask for your desired location.
2. **Explore AR Map:** Watch as dynamic location pins appear over your real-world view.
3. **Capture Insights:** Use a pinch gesture to capture a scene and receive immediate AI-generated insights.

---

## License

This project is licensed under the [MIT License](license.txt).
