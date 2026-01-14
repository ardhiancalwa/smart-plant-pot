import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import time
from datetime import datetime, timedelta

# --- page config ---
st.set_page_config(
    page_title="Smart Plant Pot",
    page_icon="🌿",
    layout="wide",
    initial_sidebar_state="expanded"
)

# --- mocking engine ---
def generate_mock_data():
    """Generates 24h of realistic sensor data"""
    dates = pd.date_range(end=datetime.now(), periods=24, freq='h')
    
    # Create realistic patterns
    # Temp: Sine wave to simulate day/night cycle + noise
    t = np.linspace(0, 4*np.pi, 24)
    temp = 25 + 5 * np.sin(t) + np.random.normal(0, 0.5, 24)
    
    # Moisture: Slowly decaying trend (drying out) + noise
    moisture = np.linspace(70, 40, 24) + np.random.normal(0, 1, 24)
    
    # Light: Bell curve for daylight
    light = 1000 * np.exp(-(np.linspace(-2, 2, 24)**2)) + np.random.normal(0, 50, 24)
    light = np.maximum(light, 0) # No negative light
    
    return pd.DataFrame({
        'timestamp': dates,
        'temperature': temp,
        'soil_moisture': moisture,
        'light_level': light,
        'humidity': 60 + np.random.normal(0, 2, 24)
    }).set_index('timestamp')

# --- session state ---
if 'data' not in st.session_state:
    st.session_state.data = generate_mock_data()

if 'last_watered' not in st.session_state:
    st.session_state.last_watered = None

# --- sidebar ---
with st.sidebar:
    st.title("🌱 Control Panel")
    
    plant_type = st.selectbox(
        "Plant Species",
        ["Monstera Deliciosa", "Snake Plant", "Peace Lily", "Fiddle Leaf Fig"]
    )
    
    st.divider()
    
    st.subheader("Manual Override")
    if st.button("Activate Pump 💧", use_container_width=True):
        st.session_state.last_watered = datetime.now()
        # Simulate quick moisture jump in next update (conceptually)
        st.toast("Pump Activated! Watering plant... 🌊")
        time.sleep(1)
        
    st.divider()
    st.caption("✅ System Online | Battery: 85%")

# --- main layout ---
# Title Area with Badge
col1, col2 = st.columns([3, 1])
with col1:
    st.markdown("# Smart Personalized Plant Pot")
    st.caption(f"Monitoring: **{plant_type}** | ID: #SPP-2024-XFD")
with col2:
    # Health Score Calculation
    current_moisture = st.session_state.data['soil_moisture'].iloc[-1]
    health_score = int(min(100, max(0, 100 - abs(current_moisture - 60))))
    
    if health_score > 80:
        color = "green"
        status = "Excellent"
    elif health_score > 50:
        color = "orange"
        status = "Needs Attention"
    else:
        color = "red"
        status = "Critical"
        
    st.markdown(f"""
        <div style="text-align: right; padding: 10px; border-radius: 10px; border: 1px solid #ddd;">
            <p style="margin:0; font-size: 0.8rem; color: #666;">Health Status</p>
            <h2 style="margin:0; color: {color};">{status} ({health_score}%)</h2>
        </div>
    """, unsafe_allow_html=True)

st.divider()

# Top Row: Metrics
current_data = st.session_state.data.iloc[-1]
prev_data = st.session_state.data.iloc[-2]

m1, m2, m3, m4 = st.columns(4)
m1.metric("Soil Moisture", f"{current_data['soil_moisture']:.1f}%", f"{current_data['soil_moisture']-prev_data['soil_moisture']:.1f}%")
m2.metric("Temperature", f"{current_data['temperature']:.1f}°C", f"{current_data['temperature']-prev_data['temperature']:.1f}°C")
m3.metric("Humidity", f"{current_data['humidity']:.1f}%", f"{current_data['humidity']-prev_data['humidity']:.1f}%")
if st.session_state.last_watered:
    since = datetime.now() - st.session_state.last_watered
    mins = int(since.total_seconds() / 60)
    m4.metric("Last Watered", f"{mins} mins ago")
else:
    m4.metric("Last Watered", "Unknown")

# Middle Row: Charts
st.subheader("Sensor Trends (24h)")
tab1, tab2, tab3 = st.tabs(["💧 Moisture", "🌡️ Temperature", "☀️ Light"])

with tab1:
    fig_moisture = px.line(st.session_state.data, y='soil_moisture', title="Soil Moisture %")
    fig_moisture.update_layout(yaxis_range=[0, 100], xaxis_title=None)
    st.plotly_chart(fig_moisture, use_container_width=True)

with tab2:
    fig_temp = px.line(st.session_state.data, y='temperature', title="Temperature °C")
    st.plotly_chart(fig_temp, use_container_width=True)

with tab3:
    fig_light = px.area(st.session_state.data, y='light_level', title="Light Level (Lux)")
    st.plotly_chart(fig_light, use_container_width=True)

# Bottom Row: AI Insights
st.divider()
st.subheader("🧠 AI Insights & Predictions")

ac1, ac2 = st.columns(2)

with ac1:
    st.info("**Next Watering Prediction:**\n\nBased on current usage, your plant will need water in approximately **4 hours**. We will auto-dispense unless you override settings.")

with ac2:
    # Emotion Logic
    if current_data['soil_moisture'] < 40:
        emotion = "🥵 Thirsty"
        msg = "I'm feeling a bit dry! A sip of water would be nice."
    elif current_data['temperature'] > 30:
        emotion = "🌡️ Hot"
        msg = "It's getting a bit toasty in here. Can we open a window?"
    elif current_data['light_level'] < 100:
        emotion = "🌑 Sleepy"
        msg = "Is it night time already? I'm not getting much light."
    else:
        emotion = "😊 Happy"
        msg = "Everything is just perfect! I'm thriving!"
        
    st.success(f"**Plant Mood: {emotion}**\n\n\"{msg}\"")

# Developer Mock Mode
with st.expander("🛠️ Developer Mode"):
    st.write("Generating Antigravity...")
    if st.button("Run Antigravity Protocol"):
        import antigravity
    st.code(st.session_state.data.tail())
