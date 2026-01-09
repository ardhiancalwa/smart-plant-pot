# Machine Learning (Ai) 🧠

This directory contains the machine learning workflows for the Smart Plant Pot.

## Overview

We use Python and Scikit-learn to develop predictive models for:

1.  **Watering Needs:** Classification model (Random Forest) to predict if the plant needs water based on soil moisture and environment.
2.  **Anomaly Detection:** Isolation Forest model to detect sensor malfunctions or extreme environmental conditions.
3.  **Disease Detection:** (Optional) MobileNetV2 model for visual leaf disease identification.

## Directory Structure

- `notebooks/`: Jupyter notebooks for EDA, Training, and Evaluation.
- `data/`: Raw and processed datasets (ignored by git).
- `models/`: Serialized `.pkl` or `.tflite` model files.
- `scripts/`: Python scripts for data preprocessing and training automation.

## Usage

1.  Install dependencies: `pip install -r requirements.txt`
2.  Run training script: `python scripts/train.py`
