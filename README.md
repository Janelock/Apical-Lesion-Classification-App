# Apical Lesion Classification App

This repository contains the code for an Apical Lesion Classification app that uses a deep learning model based on DenseNet121 architecture to detect the existence of apical lesions in periapical X-rays. The app includes a Flask server for model inference and a Flutter front-end for user interaction.

## Contents

- `gp_app/`: Contains the Flutter application code.
- `densenet121.ipynb`: Jupyter Notebook for training the DenseNet121 model.
- `server.py`: Flask server script for model inference.

## Features

- **Image Manipulation and Annotation**:
  - Includes tools for manipulating and annotating periapical X-ray images.
  - Allows users to mark and annotate apical lesions for further analysis.

- **Medical Report Management**:
  - Manages medical reports associated with dental x-rays.
  - Provides storage and retrieval of reports for multiple patients.
