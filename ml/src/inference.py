import os
import joblib
import numpy as np

# Define relative paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODELS_DIR = os.path.join(BASE_DIR, '../models')

class SmartPotInference:
    def __init__(self):
        self.rf_model = None
        self.le_plant = None
        self.le_status = None
        self._load_models()

    def _load_models(self):
        try:
            # Load Random Forest Model
            rf_path = os.path.join(MODELS_DIR, 'smart_pot_model.pkl')
            if os.path.exists(rf_path):
                self.rf_model = joblib.load(rf_path)
            else:
                print(f"Warning: {rf_path} not found.")

            # Load Plant Label Encoder
            le_plant_path = os.path.join(MODELS_DIR, 'label_encoder_plant.pkl')
            if os.path.exists(le_plant_path):
                self.le_plant = joblib.load(le_plant_path)
            else:
                print(f"Warning: {le_plant_path} not found.")
            
            # Load Status Label Encoder (Generic handling if available)
            le_status_path = os.path.join(MODELS_DIR, 'label_encoder_status.pkl')
            if os.path.exists(le_status_path):
                self.le_status = joblib.load(le_status_path)

        except Exception as e:
            print(f"Error loading models: {e}")

    def get_plant_analysis(self, plant_name, soil, temp, hum, lux):
        """
        Predict plant status.
        Anomaly detection has been removed.
        
        Args:
            plant_name (str): Name of the plant.
            soil (float): Soil moisture value.
            temp (float): Temperature value.
            hum (float): Humidity value.
            lux (float): Light intensity value.
            
        Returns:
            dict: {"status": str, "message": str}
        """
        # Default response for error cases
        response = {
            "status": "Unknown",
            "message": "Error in processing"
        }

        if not self.rf_model or not self.le_plant:
            response["message"] = "Models not loaded correctly."
            return response

        try:
            # Encode plant name
            if plant_name not in self.le_plant.classes_:
                response["message"] = f"Plant '{plant_name}' not found in training data."
                return response
            
            plant_encoded = self.le_plant.transform([plant_name])[0]

            # Prepare features: ensure the order matches training [plant_encoded, soil, temp, hum, lux]
            features = np.array([[plant_encoded, soil, temp, hum, lux]])

            # Predict Status (Classification)
            status_pred = self.rf_model.predict(features)[0]
            
            # Decode status if encoder exists and prediction is likely an index (int/float representation)
            if self.le_status and (isinstance(status_pred, (int, np.integer)) or isinstance(status_pred, float)):
                 status_str = self.le_status.inverse_transform([int(status_pred)])[0]
            else:
                # If model predicts string directly or no encoder found
                status_str = str(status_pred)

            response["status"] = status_str
            response["message"] = f"{plant_name} is in {status_str} state."

        except Exception as e:
            response["message"] = f"Prediction error: {str(e)}"
        
        return response

# Singleton instance for easy import
inference_engine = SmartPotInference()

def get_plant_analysis(plant_name, soil, temp, hum, lux):
    return inference_engine.get_plant_analysis(plant_name, soil, temp, hum, lux)
