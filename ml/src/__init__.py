# ml/src/__init__.py

from .inference import get_plant_analysis
from .llm_handler import get_voice_response
from .processor import clean_sensor_data
from .audio_handler import transcribe_audio, text_to_speech

# Versi paket ML
__version__ = "1.0.0"