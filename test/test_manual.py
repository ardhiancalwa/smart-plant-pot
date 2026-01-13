import os
import time
from ml.src import clean_sensor_data, get_plant_analysis, get_voice_response, transcribe_audio, text_to_speech

# ==========================================
# 1. TEST ANALYTIC AI (KECERDASAN SENSOR)
# ==========================================
print("\n--- 🧪 TEST 1: ANALYTIC AI ---")
print("Skenario: Data sensor masuk (Tanah Kering & Panas)")

# Simulasi data mentah dari ESP32
raw_data = {
    "soil": 1000,  # Agak kering (Ingat: 4095=Kering Total)
    "temp": 23,  # Panas
    "hum": 40.0,
    "lux": 4000   # Terang sekali
}

# Cleaning Data
clean = clean_sensor_data(raw_data['soil'], raw_data['temp'], raw_data['hum'], raw_data['lux'])
print(f"Data Bersih: {clean}")

# Prediksi Status (Misal tanaman Bayam)
analysis = get_plant_analysis("Bayam", clean['soil_percent'], clean['temperature'], clean['humidity'], clean['lux'])
print(f"Hasil Analisis: {analysis}")
# Harapan: Status mungkin 'THIRSTY' atau 'HOT'


# ==========================================
# 2. TEST GENERATIVE AI (CHATBOT GEMINI)
# ==========================================
print("\n--- 🧪 TEST 2: GENERATIVE AI (GEMINI) ---")
print("Skenario: Anak bertanya 'Kamu haus gak?' saat kondisi THIRSTY")

question = "bayam tuh tanaman kayak gimana?"
response_text = get_voice_response(
    child_question=question,
    analytic_status=analysis['status'], # Menggunakan hasil analisis di atas
    current_hp=60,                      # Pura-pura HP tinggal 60
    plant_type="Bayam"
)
print(f"Anak: {question}")
print(f"Tanaman (Teks): {response_text}")


# ==========================================
# 3. TEST AUDIO ENGINE (TTS)
# ==========================================
print("\n--- 🧪 TEST 3: TEXT-TO-SPEECH (TTS) ---")
output_mp3 = "test_output.mp3"

print(f"Sedang mengubah teks menjadi suara ke '{output_mp3}'...")
success = text_to_speech(response_text, output_mp3)

if success:
    print("✅ Berhasil! Silakan cek file 'test_output.mp3' dan putar suaranya.")
else:
    print("❌ Gagal membuat file audio.")

# ==========================================
# 4. TEST AUDIO ENGINE (STT - Opsional)
# ==========================================
# Hanya jalan jika ada file 'test_input.wav'
input_wav = "test_input.wav"
if os.path.exists(input_wav):
    print("\n--- 🧪 TEST 4: SPEECH-TO-TEXT (STT) ---")
    text_result = transcribe_audio(input_wav)
    print(f"Hasil Transkripsi '{input_wav}': {text_result}")
else:
    print("\n⚠️ Skip Test 4 (STT) karena tidak ada file 'test_input.wav'.")

print("\n=== PENGUJIAN SELESAI ===")