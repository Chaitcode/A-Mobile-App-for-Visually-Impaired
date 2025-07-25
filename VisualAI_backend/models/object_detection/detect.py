import cv2
import numpy as np

# Load class labels from COCO dataset
with open("models/object_detection/labels.txt", "r") as f:
    class_names = f.read().strip().split("\n")

# Load the pretrained TensorFlow model (SSD with MobileNet)
model_path = "models/object_detection/frozen_inference_graph.pb"
config_path = "models/object_detection/ssd_mobilenet_v3_large_coco_2020_01_14.pbtxt"

# Load the model using OpenCV's DNN module
net = cv2.dnn_DetectionModel(model_path, config_path)
net.setInputSize(320, 320)
net.setInputScale(1.0 / 127.5)
net.setInputMean((127.5, 127.5, 127.5))
net.setInputSwapRB(True)

# Function to perform object detection on uploaded image
def detect_objects(image_path):
    image = cv2.imread(image_path)
    if image is None:
        print(f"[ERROR] Cannot load image: {image_path}")
        return []

    class_ids, confidences, boxes = net.detect(image, confThreshold=0.5)
    detections = []

    for class_id, confidence, box in zip(class_ids.flatten(), confidences.flatten(), boxes):
        if 0 < class_id <= len(class_names):
            label = f"{class_names[class_id - 1]}"
        else:
            label = f"Unknown({class_id})"
        detections.append({
            'label': label,
            'confidence': float(confidence),
            'box': [int(x) for x in box]
        })
        cv2.rectangle(image, box, (0, 255, 0), 2)
        cv2.putText(image, f"{label}: {confidence*100:.1f}%", (box[0], box[1] - 10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

    output_path = "output_detected.jpg"
    cv2.imwrite(output_path, image)
    print(f"[INFO] Detection complete. Output saved to {output_path}")

    return detections
