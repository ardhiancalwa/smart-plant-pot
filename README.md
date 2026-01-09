# Smart Personalized Plant Pot 🌱

**Project Code:** SIC-2026-PLANT-POT-001  
**Status:** In Development (Stage 4)

A comprehensive IoT solution integrating Machine Learning, robust backend infrastructure, and an intuitive user interface to provide personalized care for your plants.

---

## 🚀 Project Overview

The Smart Personalized Plant Pot is designed to make plant care intelligent and effortless. By monitoring real-time soil moisture, temperature, and humidity, the system automates watering and allows users to interact with their plant through a Telegram bot and a rich web dashboard.

### Key Features

- **Smart Watering:** Automated irrigation based on ML predictions (>85% accuracy).
- **Disease & Anomaly Detection:** Early warning system for plant health issues.
- **Emotion Display:** OLED screen shows the plant's "mood" based on its condition.
- **Remote Control:** Monitor and control via Telegram Bot and Web Dashboard.

---

## 👥 Team Structure & Roles

| Role              | Lead      | Responsibilities                                                                 |
| ----------------- | --------- | -------------------------------------------------------------------------------- |
| **ML & AI Lead**  | Azziz Abdul Ghofur | Developing Watering Prediction, Anomaly Detection, and Disease Detection models. |
| **Software Lead** | Ardhian Calwa Nugraha | Building REST API (Flask), Database (PostgreSQL), and MQTT infrastructure.       |
| **Hardware Lead** | Syahdan Rizqi Ruhendy | ESP32 firmware development, sensor integration, and hardware assembly.           |
| **UI/UX Lead**    | Irvan Tegar Yunadi | Creating the Telegram Bot and Streamlit Dashboard for user interaction.          |

---

## 🛠 Technology Stack

### Backend Infrastructure

- **Framework:** Python Flask / FastAPI
- **Database:** PostgreSQL (Railway.app)
- **Caching:** Redis
- **Message Broker:** MQTT (HiveMQ)
- **Deployment:** Railway

### Machine Learning (AI)

- **Libraries:** Scikit-learn, Pandas, NumPy, TensorFlow/Keras
- **Models:** Random Forest (Watering), Isolation Forest (Anomaly), MobileNetV2 (Disease)

### Hardware (IoT)

- **Controller:** ESP32 WROOM-32
- **Sensors:** Capacitive Soil Moisture, DHT22 (Temp/Hum)
- **Actuators:** 5V Water Pump, 0.96" OLED Display
- **Firmware:** C++ (Arduino Framework)

### Frontend (UI)

- **Bot:** `python-telegram-bot`
- **Dashboard:** Streamlit
- **Visualization:** Plotly

---

## 📂 Project Structure

This repository is organized into four main components, mirroring the specialized roles of the team.

```bash
smart-plant-pot/
├── backend/          # API, Database models, and Controller logic
│   ├── api/          # REST Endpoint definitions
│   ├── database/     # DB connection and models
│   └── models/       # Integration of trained ML models
├── ml/               # Data Science workspace
│   ├── notebooks/    # EDA, Training, and Evaluation notebooks
│   ├── data/         # Raw and Processed datasets
│   └── models/       # Serialized model files (.pkl, .tflite)
├── firmware/         # ESP32 C++ Code
│   └── diagrams/     # Wiring schematics
├── ui/               # User Interfaces
│   ├── telegram_bot.py
│   └── dashboard.py
└── docs/             # Comprehensive documentation and reports
```

## ⚡ Quick Start

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-org/smart-plant-pot.git
   cd smart-plant-pot
   ```

2. **Backend Setup:**

   ```bash
   cd backend
   pip install -r requirements.txt
   flask run
   ```

3. **UI Setup:**
   ```bash
   cd ../ui
   pip install -r requirements.txt
   streamlit run dashboard.py
   ```

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
