import os
from app import create_app, db
from app.models import User, Pot, SensorReading, Prediction, Action, Alert, PotSettings

app = create_app(os.getenv('FLASK_CONFIG') or 'default')

@app.shell_context_processor
def make_shell_context():
    return dict(db=db, User=User, Pot=Pot, SensorReading=SensorReading, 
                Prediction=Prediction, Action=Action, Alert=Alert, PotSettings=PotSettings)

if __name__ == '__main__':
    app.run()
