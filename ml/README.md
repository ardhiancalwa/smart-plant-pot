# 🧠 Smart Guardian Pot - AI & Machine Learning Module

Dokuntasi ini diperuntukkan bagi tim Backend (Flask/Node.js) untuk mengintegrasikan modul Analitik dan Generative AI ke dalam sistem Smart Guardian Pot. Modul ini berfungsi sebagai "otak" yang memproses data sensor mentah dan memberikan kepribadian pada tanaman.

## 📋 Daftar Isi
1. [Overview](#-overview)
2. [Instalasi & Konfigurasi](#-instalasi--konfigurasi)
3. [Panduan Integrasi](#-panduan-integrasi)
4. [Data Dictionary](#-data-dictionary)
5. [Troubleshooting](#-troubleshooting)

---

## 🌟 Overview

Modul ini (`ml/`) terdiri dari dua komponen utama:

1.  **Analytic Engine (`inference.py`)**: Menggunakan model *Machine Learning* (Random Forest & Isolation Forest) untuk mengubah data sensor mentah menjadi status gamifikasi (misal: "THIRSTY") dan mendeteksi anomali kesehatan.
2.  **Generative AI (`llm_handler.py`)**: Menggunakan **Google Gemini API** untuk memungkinkan tanaman "berbicara" dengan anak, merespon pertanyaan dengan kepribadian yang dinamis sesuai kondisi kesehatannya.

Struktur Direktori:
```text
ml/
├── data/               # Dataset pelatihan (referensi)
├── models/             # Model PKL tersimpan (JANGAN DIHAPUS)
│   ├── smart_pot_model.pkl
│   ├── isolation_forest_model.pkl
│   └── *.pkl
├── src/
│   ├── __init__.py     # Titik masuk paket (Exports functions)
│   ├── processor.py    # Pre-processing & Cleaning data sensor
│   ├── inference.py    # Logika prediksi ML
│   └── llm_handler.py  # Logika percakapan (LLM)
└── requirements_ml.txt # Dependensi Python
```

---

## ⚙️ Instalasi & Konfigurasi

### 1. Instalasi Dependensi
Pastikan Anda berada di root proyek, lalu jalankan:

```bash
pip install -r ml/requirements_ml.txt
```

Paket utama yang digunakan: `scikit-learn`, `joblib`, `numpy`, `pandas`, `google-generativeai`.

### 2. Konfigurasi Environment Variables
Modul ini membutuhkan API Key untuk fitur Chatbot. Tambahkan ke file `.env` di root proyek Anda:

```env
GEMINI_API_KEY=Isi_Dengan_API_Key_Google_Gemini_Anda
```

Tanpa key ini, fitur `get_voice_response` akan mengembalikan pesan error default.

---

## 💻 Panduan Integrasi

Anda dapat mengimpor tiga fungsi utama langsung dari paket `ml.src`.

```python
from ml.src import clean_sensor_data, get_plant_analysis, get_voice_response
```

### Skenario 1: Memproses Data Sensor (Loop Utama)
Gunakan ini setiap kali data sensor baru diterima dari ESP32. Alur kerjanya adalah: **Menerima Raw Data -> Cleaning -> Prediksi AI**.

```python
# 1. Terima data mentah dari MQTT/HTTP
raw_data = {
    "soil": 2400,   # Nilai ADC (Contoh)
    "temp": 28.5,   # Celcius
    "hum": 60.0,    # Persen
    "lux": 150.0    # Lux
}

# 2. Bersihkan dan Normalisasi Data
cleaned = clean_sensor_data(
    raw_soil=raw_data["soil"],
    raw_temp=raw_data["temp"],
    raw_hum=raw_data["hum"],
    raw_lux=raw_data["lux"]
)
# Output 'cleaned': 
# {'soil_percent': 65.3, 'temperature': 28.5, 'humidity': 60.0, 'lux': 150.0}

# 3. Dapatkan Analisis AI (Status & Anomali)
# PENTING: Nama tanaman harus sesuai dengan Data Dictionary di bawah.
analysis = get_plant_analysis(
    plant_name="Lidah Buaya",
    soil=cleaned["soil_percent"],
    temp=cleaned["temperature"],
    hum=cleaned["humidity"],
    lux=cleaned["lux"]
)

print(analysis)
```

**Contoh Output `analysis`:**
```json
{
  "status": "NORMAL",
  "is_anomaly": false,
  "message": "Lidah Buaya is in NORMAL state."
}
```

### Skenario 2: Interaksi Suara (Chatbot)
Gunakan ini ketika frontend mengirimkan input suara (STT) dari anak.

```python
voice_reply = get_voice_response(
    child_question="Halo Guardian, kamu haus tidak?",
    analytic_status="THIRSTY",  # Didapat dari hasil analisis sebelumnya
    current_hp=45.0,            # Health Point saat ini (dari database game logic)
    plant_type="Lidah Buaya"
)

print(voice_reply)
```

**Contoh Output `voice_reply`:**
> "Halo teman kecil... Aku haus sekali nih.. Daunku rasanya kering. Boleh minta tolong siram aku sedikit?"

---

## 📚 Data Dictionary

### 1. Daftar Tanaman yang Didukung
Pastikan input `plant_name` persis seperti tabel di bawah (Case Sensitive) karena digunakan oleh Label Encoder.

| Nama Tanaman (Input String) | Keterangan |
|Data Dictionary| |
| :--- | :--- |
| **Bayam** | Tanaman sayur, rentan terhadap panas. |
| **Kacang Hijau** | Sering digunakan untuk eksperimen sekolah. |
| **Sirih Gading** | Tanaman hias dalam ruangan. |
| **Lidah Buaya** | Tanaman tahan kering (Succulent). |

### 2. Status Game (Output Prediksi)
Model akan memprediksi salah satu status berikut berdasarkan kondisi lingkungan.

| Status Code | Kondisi Pemicu (General) | Implikasi Game |
| :--- | :--- | :--- |
| **NORMAL** | Semua parameter ideal. | HP Regen, XP Bonus. |
| **THIRSTY** | Kelembapan tanah rendah (< Batas aman). | HP berkurang perlahan. |
| **SICK** | Kelembapan tanah TERLALU TINGGI (Overwatering). | HP berkurang cepat (Akar busuk). |
| **GLOOMY** | Cahaya kurang (Gelap). | Pertumbuhan terhambat. |
| **SQUINT** | Cahaya berlebih (Terlalu terik). | Daun terbakar, HP berkurang. |
| **COLD** | Suhu ruangan terlalu dingin. | - |
| **HOT** | Suhu ruangan terlalu panas. | Penguapan tinggi. |

---

## 🔧 Troubleshooting

### Masalah Umum

**1. `FileNotFoundError` saat memuat model (.pkl)**
*   **Penyebab**: Script Python dijalankan dari direktori yang salah, sehingga path relative ke folder `models/` rusak.
*   **Solusi**: Pastikan Anda menjalankan aplikasi utama (misal `app.py`) dari **root directory** proyek. Modul `inference.py` menggunakan `os.path.abspath(__file__)` untuk mencoba menangani ini, tapi struktur folder harus tetap dijaga.

**2. Respon Chatbot: "Maaf, aku kehilangan koneksi..."**
*   **Penyebab**: `GEMINI_API_KEY` belum diset atau salah, atau kuota API habis.
*   **Solusi**: Cek file `.env`, pastikan key valid. Cek koneksi internet server.

**3. Output Status selalu "Unknown" atau Error**
*   **Penyebab**: Kemungkinan nama tanaman yang diinput tidak ada di daftar *Label Encoder*.
*   **Solusi**: Pastikan ejaan `plant_name` persis dengan [Daftar Tanaman yang Didukung](#1-daftar-tanaman-yang-didukung).

**4. Data Sensor aneh (misal Soil -50%)**
*   **Penyebab**: Kabel sensor terlepas atau belum dikalibrasi.
*   **Solusi**: Fungsi `clean_sensor_data` sudah memilik *clamping* (batas min 0, max 100), tapi cek hardware fisik Anda jika nilai mentah (`raw`) konstan di 0 atau 4095.
