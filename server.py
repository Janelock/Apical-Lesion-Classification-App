from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import base64
from io import BytesIO
from PIL import Image
import cv2

# Initialize Flask application
app = Flask(__name__)

# Load the Keras model
model = tf.keras.models.load_model(r'C:\Users\Ruba\Desktop\model.h5')

print("Model loaded")

def resize_image(img, target_size=(256, 256)):
    # Convert img to numpy array if it's not already
    img_np = np.array(img)

    # Resize the image
    resized_image = cv2.resize(img_np, target_size, interpolation=cv2.INTER_AREA)

    # Normalize the resized image
    resized_image = resized_image.astype(np.float32) / 255.0

    return resized_image

def preprocess_image(image):
    # Resize and convert to RGB if necessary
    resized = resize_image(image)
    resized_rgb = cv2.cvtColor(resized, cv2.COLOR_BGR2RGB)  # Ensure RGB format
    print("Image resized to:", resized_rgb.shape)
    return resized_rgb

@app.route('/test', methods=['GET'])
def test():
    return jsonify({"message": "Test endpoint is working!"})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    image_data = data['image']

    # Decode the base64 image data and convert to PIL Image
    image = Image.open(BytesIO(base64.b64decode(image_data)))

    image.show()
    # Preprocess the image
    processed_image = preprocess_image(image)

    # Expand dimensions to create a batch of size 1
    processed_image = np.expand_dims(processed_image, axis=0)

    # Ensure the processed image has the correct shape
    processed_image = tf.image.resize(processed_image, [256, 256])
    processed_image = processed_image.numpy()  # Convert to numpy array

    # Perform prediction using loaded model
    prediction = model.predict(processed_image)

    # Convert prediction to list for JSON serialization

    pred=0

    if(prediction[0][1]>prediction[0][0]):
        pred=1

    print("******")
    print(pred)

    response = {
        'prediction': pred
    }
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)

