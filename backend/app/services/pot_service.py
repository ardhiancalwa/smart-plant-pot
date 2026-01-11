from app.repositories.pot_repository import (
    PotRepository, SensorReadingRepository, ActionRepository, 
    AlertRepository, PotSettingsRepository, PredictionRepository
)
from app.models import SensorReading, Action, Alert, PotSettings, Prediction

class PotService:
    def __init__(self):
        self.pot_repo = PotRepository()
        self.reading_repo = SensorReadingRepository()
        self.action_repo = ActionRepository()
        self.alert_repo = AlertRepository()
        self.settings_repo = PotSettingsRepository()
        self.prediction_repo = PredictionRepository()

    def add_reading(self, pot_id, data):
        pot = self.pot_repo.get_by_id(pot_id)
        if not pot:
            return None, "Pot not found"

        reading = SensorReading(
            pot_id=pot_id,
            moisture=data.get('moisture'),
            temperature=data.get('temperature'),
            light_level=data.get('light_level')
        )
        self.reading_repo.save(reading)

        # Business Logic: Check Thresholds
        settings = pot.settings
        if settings and reading.moisture < settings.min_moisture:
            self.create_alert(pot_id, "Low Moisture", "warning")
            if settings.auto_water:
                self.create_action(pot_id, "WATER")

        return reading, None

    def get_pot_status(self, pot_id):
        pot = self.pot_repo.get_by_id(pot_id)
        if not pot:
            return None, "Pot not found"
        
        latest_reading = self.reading_repo.get_by_pot_id(pot_id).first()
        data = pot.to_dict()
        if latest_reading:
            data['latest_reading'] = latest_reading.to_dict()
        return data, None

    def create_action(self, pot_id, action_type):
        pot = self.pot_repo.get_by_id(pot_id)
        if not pot:
            return None, "Pot not found"

        action = Action(pot_id=pot_id, action_type=action_type, status='pending')
        self.action_repo.save(action)
        return action, None

    def create_alert(self, pot_id, message, severity="info"):
        alert = Alert(pot_id=pot_id, message=message, severity=severity)
        self.alert_repo.save(alert)
        return alert

    def get_readings_history(self, pot_id, page, per_page):
        query = self.reading_repo.get_by_pot_id(pot_id)
        return self.reading_repo.get_paginated(query, page, per_page)

    def get_predictions_history(self, pot_id, page, per_page):
        query = self.prediction_repo.get_by_pot_id(pot_id)
        return self.prediction_repo.get_paginated(query, page, per_page)

    def update_settings(self, pot_id, data):
        pot = self.pot_repo.get_by_id(pot_id)
        if not pot:
            return None, "Pot not found"
        
        settings = pot.settings
        if not settings:
            settings = PotSettings(pot_id=pot_id)
            # Must save first if new to establish relationship ID if not auto-handled
            # But here PotSettings expects pot_id.
            
        if 'min_moisture' in data:
            settings.min_moisture = data['min_moisture']
        if 'max_moisture' in data:
            settings.max_moisture = data['max_moisture']
        if 'auto_water' in data:
            settings.auto_water = data['auto_water']
            
        self.settings_repo.save(settings)
        return settings, None

    def diagnose_pot(self, pot_id):
        # Business Logic for Diagnosis
        result = {
            "disease": "Root Rot",
            "probability": 0.85,
            "recommendation": "Reduce watering frequency"
        }
        pred = Prediction(
            pot_id=pot_id,
            prediction_result=result,
            confidence_score=0.85
        )
        self.prediction_repo.save(pred)
        return pred
