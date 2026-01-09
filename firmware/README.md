# Firmware (ESP32) 🔌

This directory contains the C++ firmware for the ESP32 microcontroller.

## Hardware Components

- **MCU:** ESP32 WROOM-32
- **Input:** Capacitive Soil Moisture Sensor (Analog), DHT22 (Digital)
- **Output:** 5V Relay (Water Pump), 0.96" OLED I2C Display

## Features

- WiFi Manager for easy connection.
- MQTT Client (`PubSubClient`) for bidirectional communication.
- OLED Status Display with "Emotion" faces.
- Failsafe logic for pump operation.

## Setup

1.  Open `smart_pot_firmware.ino` in Arduino IDE or PlatformIO.
2.  Install required libraries: `DHT sensor library`, `Adafruit SSD1306`, `PubSubClient`.
3.  Configure `wifi.h` and `mqtt_config.h` (to be created) with your credentials.
4.  Upload to ESP32.
