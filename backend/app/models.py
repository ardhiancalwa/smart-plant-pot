from app import db
from datetime import datetime
from sqlalchemy.dialects.postgresql import JSON

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password_hash = db.Column(db.String(128))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    pots = db.relationship('Pot', backref='owner', lazy='dynamic')

    def to_dict(self):
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email,
            'created_at': self.created_at.isoformat()
        }

class Pot(db.Model):
    __tablename__ = 'pots'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False, index=True)
    name = db.Column(db.String(64), nullable=False)
    plant_type = db.Column(db.String(64))
    location = db.Column(db.String(64))
    current_status = db.Column(db.String(20), default='healthy')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    readings = db.relationship('SensorReading', backref='pot', lazy='dynamic')
    predictions = db.relationship('Prediction', backref='pot', lazy='dynamic')
    actions = db.relationship('Action', backref='pot', lazy='dynamic')
    alerts = db.relationship('Alert', backref='pot', lazy='dynamic')
    settings = db.relationship('PotSettings', uselist=False, backref='pot', cascade="all, delete-orphan")

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'plant_type': self.plant_type,
            'location': self.location,
            'status': self.current_status,
            'created_at': self.created_at.isoformat()
        }

class SensorReading(db.Model):
    __tablename__ = 'sensor_readings'

    id = db.Column(db.Integer, primary_key=True)
    pot_id = db.Column(db.Integer, db.ForeignKey('pots.id'), nullable=False)
    moisture = db.Column(db.Float)
    temperature = db.Column(db.Float)
    light_level = db.Column(db.Float)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow, index=True)

    __table_args__ = (
        db.Index('idx_pot_timestamp', 'pot_id', timestamp.desc()),
    )

    def to_dict(self):
        return {
            'id': self.id,
            'pot_id': self.pot_id,
            'moisture': self.moisture,
            'temperature': self.temperature,
            'light_level': self.light_level,
            'timestamp': self.timestamp.isoformat()
        }

class Prediction(db.Model):
    __tablename__ = 'predictions'

    id = db.Column(db.Integer, primary_key=True)
    pot_id = db.Column(db.Integer, db.ForeignKey('pots.id'), nullable=False)
    prediction_result = db.Column(JSON)
    confidence_score = db.Column(db.Float)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'result': self.prediction_result,
            'confidence': self.confidence_score,
            'timestamp': self.timestamp.isoformat()
        }

class Action(db.Model):
    __tablename__ = 'actions'

    id = db.Column(db.Integer, primary_key=True)
    pot_id = db.Column(db.Integer, db.ForeignKey('pots.id'), nullable=False)
    action_type = db.Column(db.String(32), nullable=False) # e.g., 'WATER'
    status = db.Column(db.String(20), default='pending')
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'type': self.action_type,
            'status': self.status,
            'timestamp': self.timestamp.isoformat()
        }

class Alert(db.Model):
    __tablename__ = 'alerts'

    id = db.Column(db.Integer, primary_key=True)
    pot_id = db.Column(db.Integer, db.ForeignKey('pots.id'), nullable=False)
    message = db.Column(db.String(255), nullable=False)
    severity = db.Column(db.String(20), default='info')
    is_read = db.Column(db.Boolean, default=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'message': self.message,
            'severity': self.severity,
            'is_read': self.is_read,
            'timestamp': self.timestamp.isoformat()
        }

class PotSettings(db.Model):
    __tablename__ = 'pot_settings'

    id = db.Column(db.Integer, primary_key=True)
    pot_id = db.Column(db.Integer, db.ForeignKey('pots.id'), nullable=False, unique=True)
    min_moisture = db.Column(db.Float, default=30.0)
    max_moisture = db.Column(db.Float, default=70.0)
    auto_water = db.Column(db.Boolean, default=False)

    def to_dict(self):
        return {
            'min_moisture': self.min_moisture,
            'max_moisture': self.max_moisture,
            'auto_water': self.auto_water
        }
