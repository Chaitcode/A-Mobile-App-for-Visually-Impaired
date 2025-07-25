from flask import Flask, request, jsonify
import os
from gtts import gTTS
from playsound import playsound
import uuid

from models.object_detection.detect import detect_objects
from models.text_ocr.ocr import read_text
from models.image_captioning.caption import generate_caption

app = Flask(__name__)
UPLOAD_FOLDER = 'static/uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def speak_text(text):
    """Convert text to speech, play it, and clean up the audio file."""
    try:
        tts = gTTS(text)
        filename = f"temp_{uuid.uuid4().hex}.mp3"
        tts.save(filename)
        playsound(filename)
        os.remove(filename)
    except Exception as e:
        print(f"TTS error: {e}")

@app.route('/detect', methods=['POST'])
def object_detect():
    file = request.files['image']
    file_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(file_path)
    detections = detect_objects(file_path)

    labels = [d['label'] for d in detections]
    if labels:
        speak_text("Detected " + ", ".join(labels))

    return jsonify(detections)

@app.route('/ocr', methods=['POST'])
def text_recognition():
    file = request.files['image']
    file_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(file_path)
    text = read_text(file_path)

    speak_text(text)
    return jsonify({"text": text})

@app.route('/caption', methods=['POST'])
def caption_image():
    file = request.files['image']
    file_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(file_path)
    caption = generate_caption(file_path)

    speak_text(caption)
    return jsonify({"caption": caption})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
