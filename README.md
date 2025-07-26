```markdown
# 🔍 A Mobile App for Visually Impaired

A Flutter + Flask powered assistive AI app that transforms images into audio-based insights using object detection, OCR, and image captioning.

---

## 📱 Overview

This mobile application is designed to empower **visually impaired users** by transforming captured or uploaded images into meaningful **spoken feedback**. Using artificial intelligence, the app provides three core functionalities:

- 🎯 **Object Detection**
- 🖼️ **Image Captioning**
- 📝 **Text Recognition (OCR)**

All features are accessible through a **simple interface**, built in Flutter, and backed by a Flask API that runs AI models.

---

## 🧠 Core Features

| Feature              | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| 🔎 **Object Detection** | Identifies multiple objects within the image using **SSD MobileNet**.        |
| 🖋️ **Image Captioning** | Describes the image using a full sentence via the **BLIP model**.           |
| 🔤 **Text Recognition** | Extracts text content from the image using **Tesseract OCR**.              |
| 🔊 **Audio Feedback**    | All results are read aloud using **Text-to-Speech** for user convenience. |

---

## 📂 Project Structure

```

A-Mobile-App-for-Visually-Impaired/
├── VisualAI\_backend/               # Flask backend (AI logic)
│   ├── app.py
│   ├── models/
│   ├── utils/
│   ├── requirements.txt
│   └── static/, .venv/, \*.mp3, etc.
│
├── visually\_impaired\_assist/       # Flutter frontend (mobile app)
│   ├── lib/
│   ├── android/
│   ├── assets/
│   ├── pubspec.yaml
│   └── build/, .dart\_tool/, etc.
│
└── README.md

````

---

## 🚀 How to Run the Project

### ⚙️ 1. Backend Setup (Flask API)

```bash
cd VisualAI_backend
python -m venv venv
venv\Scripts\activate   # On Windows
pip install -r requirements.txt
python app.py
````

🔗 Server runs at: `http://localhost:5000/`

---

### 📲 2. Flutter App Setup

```bash
cd visually_impaired_assist
flutter pub get
flutter run
```

📱 Connect a physical Android device or emulator to run the app.

---

## 🔗 Backend–Frontend Communication

* The Flutter app sends a captured or uploaded image + selected task (object detection, captioning, OCR) to the Flask server.
* The backend processes the image and returns the result.
* The app reads the result out loud using **TTS (Text-to-Speech)**.

---

## 🧾 Tech Stack

| Layer             | Technologies Used                                               |
| ----------------- | --------------------------------------------------------------- |
| **Frontend**      | Flutter, Dart, image\_picker, flutter\_tts, http                |
| **Backend**       | Flask, Python, Tesseract OCR, SSD MobileNet, BLIP, gTTS/pyttsx3 |
| **Communication** | REST API (HTTP)                                                 |

---

## 📂 Recommended `.gitignore`

### For `VisualAI_backend/`

```
*.mp3
.venv/
__pycache__/
*.pyc
```

### For `visually_impaired_assist/`

```
build/
.dart_tool/
.flutter-plugins
.packages
pubspec.lock
```

---

## 👩‍💻 Developer Info

**Project Title**: *A Mobile App for Visually Impaired*
**Academic Year**: *2024–2025*
**Technology Focus**: Assistive Tech, Computer Vision, AI/ML
**Frontend**: Flutter
**Backend**: Flask (Python)

---

## 🙌 Contributions

Have suggestions or want to contribute?
Feel free to fork the repo, open an issue, or submit a pull request! 💡

---

<p align="center"><b>Made with ❤️ for accessibility and inclusion.</b></p>
```

---
