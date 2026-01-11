from app.models import Pot, SensorReading, Prediction, Action, Alert, PotSettings
from .base_repository import BaseRepository

class PotRepository(BaseRepository):
    def __init__(self):
        super().__init__(Pot)

    def get_with_readings(self, pot_id):
        return self.model.query.get(pot_id)

class SensorReadingRepository(BaseRepository):
    def __init__(self):
        super().__init__(SensorReading)

    def get_by_pot_id(self, pot_id):
        return self.model.query.filter_by(pot_id=pot_id).order_by(self.model.timestamp.desc())

class PredictionRepository(BaseRepository):
    def __init__(self):
        super().__init__(Prediction)
    
    def get_by_pot_id(self, pot_id):
         return self.model.query.filter_by(pot_id=pot_id).order_by(self.model.timestamp.desc())

class ActionRepository(BaseRepository):
    def __init__(self):
        super().__init__(Action)

class AlertRepository(BaseRepository):
    def __init__(self):
        super().__init__(Alert)

class PotSettingsRepository(BaseRepository):
    def __init__(self):
        super().__init__(PotSettings)
    
    def get_by_pot_id(self, pot_id):
        return self.model.query.filter_by(pot_id=pot_id).first()
