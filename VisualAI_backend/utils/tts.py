from gtts import gTTS
import os
import platform

def speak_text(text, filename="output.mp3"):
    if not text:
        return

    tts = gTTS(text=text, lang='en')
    tts.save(filename)

    # Auto-play the audio (platform-specific)
    if platform.system() == "Windows":
        os.system(f"start {filename}")
    elif platform.system() == "Darwin":  # macOS
        os.system(f"afplay {filename}")
    else:  # Linux
        os.system(f"mpg123 {filename}")
