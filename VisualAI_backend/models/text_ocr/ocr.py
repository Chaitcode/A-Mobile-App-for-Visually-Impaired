from PIL import Image
import pytesseract

def read_text(image_path):
    return pytesseract.image_to_string(Image.open(image_path))
