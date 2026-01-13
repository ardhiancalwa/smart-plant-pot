# ml/src/processor.py

def clean_sensor_data(raw_soil, raw_temp, raw_hum, raw_lux):
    """
    Fungsi untuk membersihkan dan memvalidasi data sensor 
    sebelum dimasukkan ke model AI.
    """
    
    # 1. Normalisasi Soil Moisture (Mana Bar) 
    # Contoh kalibrasi: 4095 (kering), 1500 (basah) pada ADC ESP32
    # Kita ubah menjadi persentase 0-100%
    try:
        # Rumus: ((Kering - Sekarang) / (Kering - Basah)) * 100
        soil_percent = ((4095 - raw_soil) / (4095 - 1500)) * 100
        soil_percent = max(0, min(100, round(soil_percent, 2)))
    except ZeroDivisionError:
        soil_percent = 0

    # 2. Validasi DHT22 (Suhu & Kelembapan Udara) [cite: 130]
    # Sensor DHT22 terkadang mengirimkan nilai 'NaN' atau di luar batas wajar
    temp = round(raw_temp, 2) if -40 <= raw_temp <= 80 else 25.0
    hum = round(raw_hum, 2) if 0 <= raw_hum <= 100 else 50.0

    # 3. Pemrosesan BH1750 (Intensitas Cahaya)
    # Memastikan nilai Lux tidak negatif (Lux 0-65535)
    lux = max(0, round(raw_lux, 2))

    return {
        "soil_percent": soil_percent,
        "temperature": temp,
        "humidity": hum,
        "lux": lux
    }

def calculate_xp(status, is_anomaly):
    """
    Logika tambahan untuk menghitung perolehan XP anak 
    berdasarkan kondisi tanaman.
    """
    if status == "NORMAL" and not is_anomaly:
        return 10  # Bonus XP karena merawat dengan baik
    return 0