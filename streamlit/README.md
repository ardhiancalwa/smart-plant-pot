# User Interface (UI) 📱

This directory contains the frontend applications for interacting with the Smart Plant Pot.

## Components

1.  **Telegram Bot (`telegram_bot.py`):**

    - Built with `python-telegram-bot`.
    - Commands: `/start`, `/status`, `/water`, `/graph`.
    - usage: `python telegram_bot.py`

2.  **Web Dashboard (`dashboard.py`):**
    - Built with `Streamlit`.
    - Features: Real-time sensor gauges, historical data charts, manual control toggle.
    - Usage: `streamlit run dashboard.py`

## Setup

1.  Install dependencies: `pip install -r requirements.txt`
2.  Set environment variables (Bot Token, API URL) in `.env`.
3.  Run the desired interface.
