# 🧠 Smart Guardian Pot - AI & Machine Learning Module

Dokumentasi teknis ini diperuntukkan bagi **Tim Backend (Flask)** untuk mengintegrasikan modul "Otak" dan "Indra" buatan ke dalam sistem Smart Guardian Pot. 

Modul ini bersifat mandiri (standalone package) yang menangani tiga fungsi kognitif utama:
1.  **Analytic AI**: Menerjemahkan data sensor menjadi status gamifikasi dan kesehatan tanaman.
2.  **Generative AI**: Memberikan kepribadian pada tanaman untuk bercakap-cakap (via Google Gemini).
3.  **Audio Engine**: Menangani *Speech-to-Text* (Pendengaran) dan *Text-to-Speech* (Suara).

---

## 📋 Daftar Isi
1. [Struktur Direktori](#-struktur-direktori)
2. [Instalasi & Konfigurasi](#-instalasi--konfigurasi)
3. [Panduan Integrasi (Flask)](#-panduan-integrasi-flask)
4. [Data Dictionary](#-data-dictionary)
5. [Troubleshooting](#-troubleshooting)

---

## 📂 Struktur Direktori

```text
ml/
├── data/               # Dataset referensi
├── models/             # File model (.pkl) dan encoders (JANGAN DIHAPUS)
├── src/
│   ├── __init__.py     # Interface utama package
│   ├── processor.py    # Pembersihan & Kalibrasi data sensor
│   ├── inference.py    # Logika prediksi status & anomali
│   ├── llm_handler.py  # Chatbot Persona (Gemini API)
│   └── audio_handler.py# STT (Google) & TTS (Edge-TTS)
└── requirements_ml.txt # Dependensi Python khusus modul ini
```

---

## ⚙️ Instalasi & Konfigurasi

### 1. Instalasi Library Python
jalankan perintah berikut dari **root directory** proyek:

```bash
pip install -r ml/requirements_ml.txt
```

### 2. Instalasi FFmpeg (WAJIB)
Modul audio memerlukan **FFmpeg** di level sistem operasi untuk memproses file suara (konversi MP3 <-> WAV).
*   **Mac (Homebrew):** `brew install ffmpeg`
*   **Ubuntu/Debian:** `sudo apt update && sudo apt install ffmpeg`
*   **Windows:** Download binary FFmpeg dan tambahkan ke PATH environment variable.

### 3. Konfigurasi Environment Variables
Buat atau update file `.env` di root proyek Anda untuk mengaktifkan fitur chat:

```env
GEMINI_API_KEY=Isi_Dengan_API_Key_Google_Gemini_Anda
```

---

## 💻 Panduan Integrasi (Flask)

Anda dapat mengimpor semua fungsi utama langsung dari namespace `ml.src`:

```python
from ml.src import (
    clean_sensor_data, 
    get_plant_analysis, 
    get_voice_response,
    transcribe_audio,
    text_to_speech
)
```

### Skenario 1: Loop Pemrosesan Sensor (IoT)
Gunakan alur ini saat Backend menerima data JSON dari ESP32 (via MQTT/HTTP).

```python
# 1. Terima data mentah
raw_data = {"soil": 2400, "temp": 28.5, "hum": 60.0, "lux": 150.0}

# 2. Cleaning & Kalibrasi
# Mengubah nilai voltase/raw menjadi satuan manusia (%, Celcius, Lux)
cleaned = clean_sensor_data(
    raw_soil=raw_data["soil"],
    raw_temp=raw_data["temp"],
    raw_hum=raw_data["hum"],
    raw_lux=raw_data["lux"]
)

# 3. Analisis AI (Status & Anomali)
# PENTING: plant_name harus sesuai Data Dictionary!
analysis = get_plant_analysis(
    plant_name="Lidah Buaya",
    soil=cleaned["soil_percent"],
    temp=cleaned["temperature"],
    hum=cleaned["humidity"],
    lux=cleaned["lux"]
)

# Contoh Output 'analysis':
# {
#   "status": "THIRSTY",
#   "is_anomaly": False,
#   "message": "Lidah Buaya is in THIRSTY state."
# }
```

### Skenario 2: Interaksi Suara (Voice Chat)
Gunakan alur ini saat Frontend mengupload file rekaman suara anak.

```python
# Path file input (dari upload user) dan output (untuk response)
input_audio_path = "uploads/suara_anak.wav" 
output_audio_path = "static/audio/response_tanaman.mp3"

# 1. Transkripsi Suara (STT)
child_text = transcribe_audio(input_audio_path)

if not child_text:
    print("Suara tidak jelas.")
else:
    # 2. Dapatkan Jawaban AI (Berdasarkan kondisi tanaman terakhir)
    # Gunakan data status terakhir dari database/cache
    ai_reply_text = get_voice_response(
        child_question=child_text,
        analytic_status="THIRSTY",  # Contoh status saat ini
        current_hp=60.0,            # Contoh HP saat ini
        plant_type="Lidah Buaya"
    )

    # 3. Konversi Jawaban ke Suara (TTS)
    success = text_to_speech(ai_reply_text, output_audio_path)

    if success:
        return jsonify({
            "user_text": child_text,
            "bot_text": ai_reply_text,
            "audio_url": "/static/audio/response_tanaman.mp3"
        })
```

---

## 📚 Data Dictionary

### 1. Daftar Tanaman (Supported Plants)
*Case Sensitive*. Input nama tanaman ke fungsi `get_plant_analysis` **HARUS** persis salah satu dari ini:

| Nama Tanaman | Karakteristik |
| :--- | :--- |
| **Bayam** | Butuh air sedang, tidak tahan panas ekstrem. |
| **Kacang Hijau** | Tumbuh cepat, sensitif pada cahaya. |
| **Sirih Gading** | Tanaman hias, toleransi cahaya rendah. |
| **Lidah Buaya** | Tahan kering (Succulent), butuh cahaya terang. |

### 2. Status Game (Game Statuses)
Output dari `analysis["status"]`.

| Status Code | Pemicu Utama | Logika Game (Saran) |
| :--- | :--- | :--- |
| **NORMAL** | Semua sensor dalam range ideal. | `HP +1`, `XP +10` (Happy). |
| **THIRSTY** | Soil Moisture < Batas Min. | `HP -2` per jam. Tanaman minta minum. |
| **SICK** | Soil Moisture > Batas Max (Overwatering). | `HP -5` (Cepat mati). Akar busuk. |
| **GLOOMY** | Sensor Cahaya < Batas Min. | Pertumbuhan melambat. |
| **SQUINT** | Sensor Cahaya > Batas Max (Silau). | `HP -1`, Daun terbakar. |
| **COLD** | Suhu < Batas Min. | Tanaman menggigil. |
| **HOT** | Suhu > Batas Max. | Penguapan tinggi, `HP -1`. |

---

## 🔧 Troubleshooting

### Masalah Umum

**1. `FileNotFoundError` / Path Error**
*   **Gejala**: Error saat memuat file `.pkl` atau membaca audio.
*   **Solusi**: Pastikan script Flask dijalankan dari **root directory** proyek (`python app.py`), BUKAN dari dalam folder `ml/` atau `src/`. Modul ini menggunakan relative path yang bergantung pada root context.

**2. Error Audio / Pydub**
*   **Gejala**: `RuntimeWarning: Couldn't find ffmpeg or avconv`.
*   **Solusi**: Anda belum menginstall **FFmpeg** di sistem operasi. Lihat bagian **Instalasi**. Pip install saja tidak cukup, harus install binary system-nya.

**3. Respon Chatbot: "Maaf, aku kehilangan koneksi..."**
*   **Gejala**: AI selalu menjawab error default.
*   **Solusi**: Cek file `.env`. Pastikan `GEMINI_API_KEY` terisi dan valid. Pastikan juga server memiliki koneksi internet.

**4. Prediksi Status Selalu "Unknown"**
*   **Gejala**: Output status tidak sesuai prediksi.
*   **Solusi**: Cek ejaan `plant_name`. Jika Anda kirim "Mawar" tapi model dilatih hanya dengan "Bayam", maka akan error. Gunakan tabel **Unsupported Plants**.
