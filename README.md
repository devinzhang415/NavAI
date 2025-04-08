# GTXR - Reimagining Navigation Through AR

[![MLH Winner](https://img.shields.io/badge/MLH%20Winner-Best%20Use%20of%20Gemini%20AI-FF1694?style=for-the-badge&logo=mlh&logoColor=white)](https://mlh.io)
[![Spectacles](https://img.shields.io/badge/Spectacles-Light%20Gray?color=FFFC00&logo=snapchat&logoColor=white)](https://spectacles.com)
[![TypeScript](https://img.shields.io/badge/TypeScript-Light%20Gray?color=3178C6&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Snap AR](https://img.shields.io/badge/Snap%20AR-Light%20Gray?color=000000&logo=snapchat&logoColor=white)](https://ar.snap.com/)

> 🏆 **Winner of "Best Use of Gemini AI" at ImmerseGT 2024** - Georgia Tech's Premier VR/XR Hackathon

Imagine exploring a new city with your own AI-powered guide, right in your field of view. GTXR transforms location discovery by combining voice commands, augmented reality, and artificial intelligence. Using Snap's Spectacles, our solution lets you naturally interact with your environment while discovering exactly what you're looking for.

<img src="./Outdoor Navigation/README-ref/sample-list-outdoor-navigation-rounded-edges.gif" alt="Outdoor Navigation Demo" width="500" />

## Why GTXR?

Traditional location discovery requires constant phone interaction - typing searches, reading reviews, and manually filtering results. GTXR revolutionizes this experience through:

- 🗣️ **Natural Voice Interaction**: Simply ask for what you want - "Find me a quiet coffee shop to work" - and let AI do the work
- 🤖 **AI-Powered Understanding**: Leveraging Gemini AI to intelligently interpret your needs and provide relevant guidance
- 🌟 **Seamless Experience**: No more juggling between devices - everything you need is in your field of view
- 📸 **Instant Insights**: Get AI-generated descriptions of any building by simply pinching your fingers - combining visual data with location intelligence

## The Innovation

What sets GTXR apart is our unique combination of Gemini AI and AR technology. Our system:

1. **Understanding Natural Intent through Voice**: Uses Gemini AI to interpret spoken requests naturally - "Find me a quiet coffee shop to work" becomes an intelligent search considering ambiance, reviews, and current occupancy
2. **Dynamic Map Visualization**: Displays relevant points of interest as pins on an AR map, updating in real-time as you move
3. **Smart Snapshot Analysis**: Combines OCR, Google Places data, and Gemini AI to generate comprehensive descriptions of buildings and storefronts with a simple gesture

---
## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Development Setup](#development-setup)
- [Usage Guide](#usage-guide)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

GTXR reimagines how we discover and understand our surroundings through AR technology. By combining voice commands, real-time mapping, and AI-powered insights, we've created an intuitive system that makes location discovery feel natural and effortless.

## Key Features

### 🗣️ Voice-Powered Discovery
- **Voice-Powered Activation**: Trigger with "Hey Alice" for hands-free operation
- **Natural Language Processing**: Ask questions as you would to a local guide
- **Context-Aware Queries**: AI interprets your needs and finds relevant locations

### 🗺️ Dynamic Map Visualization
- **Real-time Location Pins**: See points of interest appear instantly on your AR map
- **Intelligent Filtering**: Results tailored to your specific request
- **Location-Aware Updates**: Map updates as you move through your environment

### 📸 Smart Snapshot Feature
- **Gesture Recognition**: Simple pinch gesture with both hands to capture
- **Visual Analysis**: Processes captured images to identify locations
- **Rich Descriptions**: Combines visual data, Places API, and Gemini AI for comprehensive insights
- **Real-time Feedback**: Shows loading states and generated descriptions in AR

## Gemini AI Integration 🤖

Our project won MLH's "Best Use of Gemini AI" award by leveraging Gemini's capabilities in multiple innovative ways:

### Natural Language Understanding
When processing voice commands, Gemini AI:
1. Interprets user intent from natural language queries
2. Maps requests to relevant place categories from a predefined set
3. Considers context and qualitative aspects (e.g., "quiet" coffee shop)
4. Generates structured queries for the Places API

### Visual Analysis & Description Generation
For the snapshot feature, Gemini AI:
1. Receives image data and a list of nearby places from Places API
2. Identifies the most likely match based on visual characteristics
3. Generates natural, context-aware descriptions that combine:
   - Visual elements from the captured image
   - Location data from Places API
   - Surrounding area context
   - Operating hours and relevant details

### Why Gemini?
We chose Gemini AI for its:
- Strong multi-modal capabilities (text + image processing)
- Natural language understanding accuracy
- Fast inference speed for real-time AR applications
- Ability to combine multiple data sources into coherent outputs

This integration showcases how AI can enhance AR experiences by making them more natural and informative, earning us recognition at ImmerseGT 2024.

## Places API Integration

Our project leverages the Google Places API in two key ways:

### Voice-Driven Location Search
When users make voice queries like "Find me a quiet coffee shop to work":
1. Gemini AI processes the natural language to identify relevant place categories
2. Places API searches within a 2.4km radius of the user's location
3. Results are filtered based on the AI's understanding of the request
4. Matching locations are displayed as pins on the AR map

### Snapshot Analysis Pipeline
When users capture a building with the pinch gesture:
1. Places API provides a list of nearby establishments
2. Our backend compares the captured image against these possibilities
3. Gemini AI generates a rich description combining:
   - Visual information from the image
   - Place details from the Places API (type, ratings, etc.)
   - Contextual information about the surrounding area

This dual integration ensures accurate location identification and rich contextual information, whether users are searching by voice or analyzing their surroundings visually.

## Tech Stack

### Hardware
> **Snap Spectacles**: AR-enabled smart glasses for hands-free interaction  
> **Built-in Camera & Mic**: Image capture and voice input  
> **Location Services**: Precise positioning for map functionality

### Core Technologies
> **TypeScript**: Strongly-typed development environment  
> **Snap AR SDK**: AR content rendering and spatial tracking  
> **VoiceML Module**: Snap's built-in speech recognition system  
> **SIK (Spectacles Interaction Kit)**: Gesture recognition for pinch controls  
> **Google Places API**: Rich location data and POI information

### AI & Backend
> **Google Gemini AI**: Natural language understanding and content generation  
> **Google Speech-to-Text API**: Backup voice transcription service  
> **Custom Flask Backend**: Image processing and AI integration  
> **Custom Integration Layer**: Combining voice, vision, and location services

### Development Tools
> **Lens Studio**: Primary development environment  
> **Version Control**: Git LFS for large asset management

## Usage Guide

### Basic Features
1. **Voice Search**
   - Activate with voice command
   - Ask natural questions (e.g., "Find me a quiet coffee shop to work")
   - View results on AR map

2. **Map Interaction**
   - View location pins in AR
   - Move around to update map view
   - Select pins for basic information

3. **Snapshot Analysis**
   - Make a pinching gesture to capture
   - Wait for AI-generated description
   - Get combined insights from visual and location data

## License

This project is licensed under the MIT License - see the [LICENSE](license.txt) file for details.

---

**Note**: This project is part of the ImmerseGT Hackathon and showcases innovative applications of AR technology in dynamic outdoor navigation.
