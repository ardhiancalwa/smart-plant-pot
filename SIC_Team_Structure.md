# SMART PERSONALIZED PLANT POT - TEAM STRUCTURE REPORT
## SIC Stage 4 Project

**Project Code:** SIC-2026-PLANT-POT-001  
**Document Version:** 2.0  
**Date:** January 10, 2026  
**Status:** FINAL - READY FOR IMPLEMENTATION  

---

## EXECUTIVE SUMMARY

This document outlines the complete team structure, role definitions, task breakdown, and timeline for the Smart Personalized Plant Pot project. The project will be executed by **4 team members**, each with clearly defined responsibilities across a **10-week development cycle**.

### Key Information
- **Team Size:** 4 members
- **Project Duration:** 10 weeks
- **Budget:** Rp 1,000,000 (hardware)
- **Target Completion:** Week 10
- **Delivery Format:** Prototype + Documentation + Video + Code Repository

---

## TABLE OF CONTENTS

1. [Team Structure](#team-structure)
2. [Role Definitions](#role-definitions)
3. [Phase Timeline](#phase-timeline)
4. [Detailed Task Breakdown](#detailed-task-breakdown)
5. [Deliverables](#deliverables)
6. [Collaboration Matrix](#collaboration-matrix)
7. [Communication Plan](#communication-plan)
8. [Success Metrics](#success-metrics)
9. [Risk Management](#risk-management)
10. [Appendix](#appendix)

---

## TEAM STRUCTURE

### Organizational Chart

```
PROJECT COORDINATOR
        |
        ├── ANGGOTA A (ML & AI Lead)
        ├── ANGGOTA B (Software/Backend Lead)
        ├── ANGGOTA C (Hardware Lead)
        └── ANGGOTA D (UI/UX Lead)
```

### Team Composition

| Position | Name | Role | Expertise | Status |
|----------|------|------|-----------|--------|
| ML & AI Lead | Anggota A | Model Development | Data Science, Python, ML | ✓ |
| Software Lead | Anggota B | Backend Development | Python, APIs, Databases | ✓ |
| Hardware Lead | Anggota C | Electronics & Firmware | Arduino, Electronics, Embedded Systems | ✓ |
| UI/UX Lead | Anggota D | Frontend & User Experience | Python, UI/UX, Web Apps | ✓ |

---

## ROLE DEFINITIONS

### ANGGOTA A: ML & AI LEAD

**Primary Responsibility:** Machine Learning model development, data science, and AI implementation

**Key Responsibilities:**
- Design and train 3 machine learning models
- Manage data collection and preprocessing pipeline
- Conduct model evaluation and optimization
- Create model documentation and integration guides
- Support backend integration of ML models

**Required Skills:**
- Python 3.9+ programming
- Pandas, NumPy, Scikit-learn libraries
- Data analysis and visualization
- Machine learning concepts
- Statistics and evaluation metrics

**Key Deliverables:**
1. Watering prediction model (accuracy >85%)
2. Anomaly detection model
3. Disease detection model (optional Phase 2)
4. ML documentation (3-4 pages)
5. Model files (.pkl format)
6. Evaluation metrics report
7. Code in GitHub repository

**Success Criteria:**
- Model accuracy ≥85%
- Proper confusion matrices and F1-scores
- Clear model documentation
- Seamless backend integration
- All metrics documented

**Time Commitment:** 20-25 hours/week

**Risk Factors:**
- Insufficient training data
- Model accuracy below 80%
- Models too slow for real-time inference
- Integration issues with backend

---

### ANGGOTA B: SOFTWARE/BACKEND LEAD

**Primary Responsibility:** Backend API development, database management, and cloud infrastructure

**Key Responsibilities:**
- Design and implement REST API with Flask/FastAPI
- Setup and manage PostgreSQL database
- Configure cloud deployment (Railway.app)
- Integrate MQTT for hardware communication
- Implement caching and optimization
- Create backend documentation

**Required Skills:**
- Python 3.9+ programming
- Flask or FastAPI framework
- PostgreSQL/SQL database
- Cloud deployment knowledge
- MQTT protocol basics
- REST API design

**Key Deliverables:**
1. Flask API server (6+ endpoints)
2. PostgreSQL database (Railway cloud)
3. MQTT integration (HiveMQ broker)
4. Redis caching implementation
5. Public API URL (https://...)
6. API documentation
7. Deployment guide
8. Code in GitHub repository

**Success Criteria:**
- API response latency <500ms
- 99% uptime during testing
- All 6+ endpoints functional
- Database properly optimized
- Complete API documentation
- Successful deployment on Railway

**Time Commitment:** 20-25 hours/week

**Risk Factors:**
- Database schema design issues
- MQTT connection failures
- ML model loading problems
- API latency too high
- Deployment failures on Railway

---

### ANGGOTA C: HARDWARE LEAD

**Primary Responsibility:** Hardware assembly, ESP32 firmware development, and sensor integration

**Key Responsibilities:**
- Assemble and test all hardware components
- Develop and optimize ESP32 firmware
- Calibrate sensors and verify functionality
- Implement MQTT bidirectional communication
- Design and optimize power management
- Create hardware documentation

**Required Skills:**
- Arduino/ESP32 C++ programming
- Electronics fundamentals
- Sensor integration knowledge
- MQTT protocol basics
- Hardware testing and troubleshooting
- Circuit design basics

**Key Deliverables:**
1. Fully assembled and tested prototype
2. ESP32 firmware (all features)
3. Sensor calibration data
4. MQTT bidirectional communication
5. OLED emotion display implementation
6. 24+ hour stability test results
7. Hardware documentation (2-3 pages)
8. Firmware code in GitHub repository

**Success Criteria:**
- All sensors working and calibrated
- MQTT bidirectional communication confirmed
- 24+ hour stability test passed
- Reliable pump activation
- OLED emotions displaying correctly
- Clean and documented firmware code
- No crashes or memory leaks

**Time Commitment:** 20-25 hours/week

**Risk Factors:**
- Defective components upon delivery
- WiFi connectivity issues
- MQTT connection failures
- Sensor calibration problems
- Firmware crashes or instability

---

### ANGGOTA D: UI/UX LEAD

**Primary Responsibility:** Telegram bot development, web dashboard creation, and user experience design

**Key Responsibilities:**
- Develop and deploy Telegram bot with multiple commands
- Create interactive Streamlit web dashboard
- Design user-friendly interfaces
- Implement real-time data visualization
- Ensure mobile responsiveness
- Conduct user experience testing
- Create UI/UX documentation

**Required Skills:**
- Python 3.9+ programming
- python-telegram-bot library
- Streamlit framework
- UI/UX design principles
- Responsive web design
- Basic HTML/CSS (if needed)

**Key Deliverables:**
1. Telegram bot deployed (@username)
2. 6+ functional bot commands
3. Streamlit web dashboard (public URL)
4. Real-time sensor visualization
5. Historical data charts
6. Prediction visualization
7. Mobile-responsive design
8. User documentation and manual
9. UI/UX documentation (2-3 pages)
10. Code in GitHub repository

**Success Criteria:**
- Bot responsive and user-friendly
- All 6+ commands fully functional
- Dashboard real-time and interactive
- Mobile-responsive design confirmed
- Dashboard deployed with public URL
- Bot deployed and live (@username)
- Complete documentation and user manual

**Time Commitment:** 15-20 hours/week

**Risk Factors:**
- API endpoint communication issues
- Bot deployment problems
- Dashboard not updating in real-time
- Mobile responsiveness issues
- User confusion with interface

---

## PHASE TIMELINE

### Project Duration: 10 Weeks

```
WEEK 1-3: MVP PHASE (Build Foundations)
├─ Anggota A: Data collection + Model 1 training
├─ Anggota B: API setup + Database creation
├─ Anggota C: Hardware assembly + Firmware basics
└─ Anggota D: Telegram bot setup + Basic commands

WEEK 4-5: FEATURES PHASE (Add Intelligence)
├─ Anggota A: Model 2 + Model 3 (anomaly, disease)
├─ Anggota B: Cloud deployment + ML integration
├─ Anggota C: MQTT integration + Performance tuning
└─ Anggota D: Dashboard MVP + Advanced commands

WEEK 6-7: OPTIMIZATION PHASE (Polish & Test)
├─ Anggota A: Model optimization + Documentation
├─ Anggota B: Performance tuning + Load testing
├─ Anggota C: OLED emotions + 3D design planning
└─ Anggota D: UX refinement + Mobile testing

WEEK 8-10: FINAL PHASE (Documentation & Submission)
├─ All: Report writing + Integration testing
├─ All: Bug fixes + Code cleanup
├─ Anggota D: Video production
└─ All: Final submission + Presentation
```

### Critical Milestones

| Week | Milestone | Deliverable | Status |
|------|-----------|-------------|--------|
| 3 | MVP Complete | Working prototype with basic features | GO/NO-GO |
| 5 | Features Complete | All features implemented and integrated | Ready? |
| 7 | Production Ready | Optimized and thoroughly tested | Freeze? |
| 8 | Report Draft | First complete draft of final report | Review |
| 9 | Video Complete | Demo video produced and edited | Final |
| 10 | SUBMIT | All deliverables ready for submission | ✅ LAUNCH |

---

## DETAILED TASK BREAKDOWN

### ANGGOTA A: ML & AI - DETAILED TASKS

#### WEEK 1-2: DATA COLLECTION & MODEL 1 TRAINING

**Week 1:**
- [ ] Setup Python environment (3.9+, virtual env)
- [ ] Install libraries: pandas, numpy, scikit-learn, jupyter, matplotlib
- [ ] Create project folder structure
- [ ] Design data collection schema
  - Timestamp, soil moisture, temperature, humidity, plant type, action
- [ ] Coordinate with Anggota C for sensor data format
- [ ] Begin collecting baseline data
- [ ] Create README for ML project

**Week 2:**
- [ ] Conduct exploratory data analysis (EDA)
  - Data quality checks
  - Statistical analysis (mean, std, min, max)
  - Correlation matrices
  - Distribution plots
- [ ] Feature engineering and preprocessing
  - Create meaningful features (trends, moving averages)
  - Handle missing data
  - Normalize/scale features
  - Train-test split (80-20)
- [ ] Train Watering Predictor Model
  - Algorithm: RandomForest Classifier
  - Target accuracy: >85%
  - Calculate: Accuracy, Precision, Recall, F1-score
  - Create confusion matrix
- [ ] Save model files (.pkl format)
- [ ] Document results

**Deliverable:** Trained watering model (>85% accuracy), EDA report, preprocessed data

---

#### WEEK 4-5: ADVANCED MODELS

**Week 4:**
- [ ] Train Anomaly Detection Model
  - Algorithm: Isolation Forest (unsupervised)
  - Purpose: Detect abnormal sensor readings
  - Test on synthetic anomalies
  - Create decision function visualization
- [ ] Prepare disease detection dataset (optional)
  - Gather plant images (PlantVillage dataset)
  - Organize by disease class
  - Minimum 500-1000 images per class

**Week 5:**
- [ ] Train Disease Detection Model (if time allows)
  - Transfer learning with MobileNetV2
  - 20-50 epochs training
  - Target accuracy: >90%
  - Convert to TensorFlow Lite (.tflite)
  - Optimize for edge deployment
- [ ] Performance optimization
  - Quantization for edge devices
  - Latency testing (<500ms target)
  - Accuracy-speed tradeoff analysis
- [ ] Create inference wrappers
  - Load model function
  - Preprocessing pipeline
  - Prediction function

**Deliverable:** All models optimized, inference ready, quantized for deployment

---

#### WEEK 6-7: OPTIMIZATION & DOCUMENTATION

- [ ] Model performance optimization
  - Fine-tune hyperparameters
  - Reduce inference time
  - Maintain accuracy >85%
- [ ] Integration preparation
  - Create inference API
  - Document input/output format
  - Prepare for Anggota B integration
- [ ] Complete ML documentation
  - Problem statement
  - Models developed (3 models)
  - Training methodology
  - Evaluation metrics
  - Confusion matrices and plots
  - Feature importance analysis
  - Model limitations and future improvements
- [ ] Create model cards for each model
  - Model name and version
  - Performance metrics
  - Input/output specifications
  - Known issues

**Deliverable:** Complete ML documentation, optimized models, integration guide

---

#### WEEK 8-10: REPORT & SUPPORT

- [ ] Write ML section of final report (3-4 pages)
- [ ] Support integration testing
- [ ] Verify models working in full system
- [ ] Performance validation in production
- [ ] Code cleanup and documentation
- [ ] Final code commit to GitHub

**Deliverable:** Report section, tested integration, documented code

---

### ANGGOTA B: SOFTWARE/BACKEND - DETAILED TASKS

#### WEEK 1-3: API & DATABASE SETUP

**Week 1-2:**
- [ ] Setup Python Flask environment
- [ ] Design database schema
  - Tables: users, pots, sensor_readings, predictions, actions, alerts
  - Relationships and foreign keys
  - Indexes for performance
- [ ] Setup PostgreSQL (local or Railway.app)
- [ ] Create database utility functions
  - Connection management
  - CRUD operations
  - Query optimization
- [ ] Create REST API endpoints (6+)
  - POST /api/pot/{pot_id}/readings (receive sensor data)
  - GET /api/pot/{pot_id}/status (current status)
  - POST /api/pot/{pot_id}/control (pump control)
  - GET /api/pot/{pot_id}/history (historical data)
  - GET /api/pot/{pot_id}/predictions (predictions)
  - POST /api/pot/{pot_id}/settings (update settings)
  - POST /api/pot/{pot_id}/diagnose (disease detection - optional)
- [ ] API error handling and validation
- [ ] Create API documentation

**Week 3:**
- [ ] MQTT integration setup
  - Connect to MQTT broker (HiveMQ Cloud)
  - Subscribe to sensor topics
  - Implement callbacks for message receipt
  - Publish pump control commands
- [ ] ML model loading in Flask
  - Load trained models from Anggota A
  - Test inference in API endpoints
  - Verify prediction accuracy
- [ ] Database optimization
  - Create indexes on frequently queried columns
  - Optimize queries
  - Test performance
- [ ] API testing
  - Test all endpoints
  - Verify data flow
  - Error handling tests

**Deliverable:** Flask API with 6+ endpoints, PostgreSQL database, MQTT integration

---

#### WEEK 4-5: DEPLOYMENT & OPTIMIZATION

**Week 4:**
- [ ] Deploy to Railway.app
  - Create Railway account
  - Connect GitHub repository
  - Setup environment variables
  - Create Procfile and requirements.txt
  - Deploy application
  - Obtain public URL (https://...)
- [ ] Setup MQTT broker (HiveMQ Cloud)
  - Create account and cluster
  - Get connection credentials
  - Update Flask configuration
  - Test MQTT connection

**Week 5:**
- [ ] Performance optimization
  - Setup Redis caching
  - Cache frequently accessed data
  - Implement cache invalidation
- [ ] Database optimization
  - Add indexes for slow queries
  - Optimize query patterns
  - Use connection pooling
- [ ] Load testing
  - Simulate concurrent users (10+)
  - Measure response times
  - Target: <500ms per request
- [ ] Monitoring and logging
  - Setup error logging
  - API uptime monitoring
  - Performance metrics tracking

**Deliverable:** Deployed API (public URL), optimized database, production-ready backend

---

#### WEEK 6-7: DOCUMENTATION & TESTING

- [ ] Complete backend documentation
  - Architecture overview
  - Database schema diagrams
  - API reference (all endpoints)
  - MQTT message format documentation
  - Deployment guide
  - Troubleshooting guide
- [ ] Integration testing
  - Test with Anggota A (ML integration)
  - Test with Anggota C (Hardware MQTT)
  - Test with Anggota D (API consumption)
- [ ] Final optimization
  - Performance tuning
  - Security review
  - Code cleanup

**Deliverable:** Complete backend documentation, tested integration, optimized code

---

#### WEEK 8-10: REPORT & FINAL

- [ ] Write backend section of final report (3-4 pages)
- [ ] Support system integration testing
- [ ] Performance validation
- [ ] Code cleanup and comments
- [ ] Final code commit to GitHub

**Deliverable:** Report section, integrated backend, documented code

---

### ANGGOTA C: HARDWARE - DETAILED TASKS

#### WEEK 1-2: ASSEMBLY & FIRMWARE

**Week 1:**
- [ ] Verify all components received
  - ESP32 WROOM-32
  - Soil moisture sensor
  - DHT22 temperature/humidity sensor
  - 5V water pump
  - 5V relay module
  - 0.96" OLED display
  - Breadboard, cables, jumpers
  - Power supply and passive components
- [ ] Setup Arduino IDE 2.0+
  - Install ESP32 board support
  - Configure settings
  - Test with Blink sketch
- [ ] Individual component testing
  - Soil moisture sensor (calibration: air ~1000, water ~300)
  - DHT22 (temperature and humidity reading)
  - OLED display (I2C communication)
  - Relay and water pump (on/off control)
  - Power supply (voltage stability test)
- [ ] Create component test report
- [ ] Document pin assignments

**Week 2:**
- [ ] Develop ESP32 firmware
  - Create project structure with header files
  - Implement sensor reading functions
  - Implement OLED display functions
  - Implement pump control functions
  - Setup WiFi connection
- [ ] Integrate all components
  - Read all sensors
  - Display data on OLED
  - Send to serial monitor (for testing)
- [ ] Local storage (EEPROM)
  - Store last watering timestamp
  - Store action log
- [ ] Stress test
  - Run 24+ hours continuous operation
  - Monitor for crashes or memory leaks
  - Check WiFi stability

**Deliverable:** Assembled hardware, firmware reading sensors, WiFi connectivity verified

---

#### WEEK 3-5: MQTT & OPTIMIZATION

**Week 3:**
- [ ] Implement MQTT communication
  - Install PubSubClient library
  - Connect to MQTT broker
  - Publish sensor data (topic: pot/{id}/sensor)
  - Subscribe to pump commands (topic: pot/{id}/command)
- [ ] Bidirectional communication testing
  - Verify data publishing
  - Verify command reception
  - Test with backend (Anggota B)
- [ ] Error handling
  - Graceful WiFi reconnection
  - MQTT reconnection logic
  - Local buffering when offline
  - Catch-up when back online

**Week 4-5:**
- [ ] Performance optimization
  - Measure current consumption
  - Optimize power usage
  - Improve memory efficiency
  - Optimize sensor reading frequency
- [ ] Long-term stability testing
  - Run for 1 week continuous
  - Monitor for stability issues
  - Test WiFi reconnection events
  - Verify sensor accuracy over time
- [ ] Bug fixes and optimization
  - Fix any identified issues
  - Optimize code
  - Add comments

**Deliverable:** MQTT working, bidirectional communication verified, stability tested

---

#### WEEK 6-7: OLED & FINAL POLISH

**Week 6:**
- [ ] Design OLED emotion faces
  - Create pixel art for emotions (8x8 or 16x16)
  - Happy, sad, thirsty, sick, neutral, hot, cold
  - Code as byte arrays
- [ ] Implement emotion logic
  - Map sensor readings to emotions
  - Update emotion based on plant status
  - Add optional animations
- [ ] Test emotion display
  - Verify all emotions display correctly
  - Test transitions
  - Ensure visual clarity

**Week 7:**
- [ ] Hardware finalization
  - Clean wiring and cable management
  - Secure components
  - Take documentation photos
  - Document final configuration
- [ ] Prepare for 3D enclosure
  - Measure component dimensions
  - Sketch enclosure design
  - Coordinate with Anggota D for design
- [ ] Complete hardware documentation
  - Schematic diagram
  - Pin assignment table
  - Component list with part numbers
  - Assembly instructions
  - Troubleshooting guide

**Deliverable:** OLED emotions working, 24+ hour test passed, hardware documentation complete

---

#### WEEK 8-10: DOCUMENTATION & FINAL

- [ ] Write hardware section of final report (2-3 pages)
- [ ] Complete hardware documentation
- [ ] Integration testing with full system
- [ ] Support and troubleshooting
- [ ] Final code commit to GitHub

**Deliverable:** Report section, tested hardware, documented firmware

---

### ANGGOTA D: UI/UX - DETAILED TASKS

#### WEEK 2-3: TELEGRAM BOT MVP

**Week 2:**
- [ ] Create Telegram bot
  - Find @BotFather
  - Register new bot
  - Get BOT_TOKEN
  - Store token securely
- [ ] Setup Python environment
  - Install python-telegram-bot library
  - Create project structure
  - Implement basic bot structure
- [ ] Implement basic commands
  - /start (welcome message)
  - /help (list all commands)
  - /status (plant health status)
  - /water (manual pump activation)
- [ ] Test locally
  - Verify command responses
  - Test with actual Telegram app

**Week 3:**
- [ ] API integration
  - Call backend endpoints from bot
  - Parse responses
  - Format messages for user
- [ ] Deploy Telegram bot
  - Choose hosting (Railway.app or PythonAnywhere)
  - Setup deployment
  - Verify bot runs 24/7
  - Test all commands
- [ ] Add more commands
  - /schedule (next watering prediction)
  - /advice (care tips)
  - /history (plant history)
  - /settings (user preferences)

**Deliverable:** Deployed Telegram bot with 6+ commands, API integration working

---

#### WEEK 4-5: DASHBOARD & ADVANCED FEATURES

**Week 4:**
- [ ] Setup Streamlit
  - Install Streamlit
  - Create dashboard file
  - Basic layout and structure
- [ ] Implement dashboard features
  - Real-time sensor display (metrics)
  - Historical charts (moisture, temperature, humidity)
  - Watering history timeline
  - Health score visualization
  - Manual water button (pump control)
- [ ] Deploy dashboard
  - Deploy to Streamlit Cloud (free!)
  - Obtain public URL
  - Test all features

**Week 5:**
- [ ] Add advanced features
  - Settings panel (plant type, thresholds)
  - Prediction charts (next 7 days)
  - Anomaly detection timeline
  - Disease detection results (if available)
- [ ] Dashboard enhancements
  - Improve visual design
  - Add color schemes
  - Optimize layout
  - Add loading states
- [ ] Advanced bot commands
  - Natural language processing (optional)
  - Context-aware responses
  - Gemini API integration (optional for Q&A)

**Deliverable:** Streamlit dashboard deployed, advanced features working, bot enhanced

---

#### WEEK 6-7: UX POLISH & DOCUMENTATION

**Week 6:**
- [ ] User experience refinement
  - Improve bot message formatting
  - Better emoji usage
  - Inline buttons for quick actions
  - Improve dashboard layout
- [ ] Accessibility testing
  - Color contrast verification
  - Font size readability
  - Mobile testing on actual phone
  - Responsive design verification
- [ ] User testing
  - Test with team members
  - Gather feedback
  - Identify confusing elements
  - Document issues

**Week 7:**
- [ ] Final UI/UX improvements
  - Fix identified issues
  - Language consistency (Bahasa Indonesia)
  - Polish visual design
  - Final mobile testing
- [ ] Documentation
  - User manual creation
  - Bot command reference
  - Dashboard feature guide
  - Troubleshooting FAQ
  - Design decision rationale

**Deliverable:** Polished bot and dashboard, user testing complete, documentation done

---

#### WEEK 8-10: REPORT & FINAL

- [ ] Write UI/UX section of final report (2-3 pages)
- [ ] Integration testing with full system
- [ ] End-to-end user flow testing
- [ ] Final improvements
- [ ] Code cleanup and documentation
- [ ] Final code commit to GitHub

**Deliverable:** Report section, tested UI/UX, documented code

---

## DELIVERABLES

### Final Project Deliverables

#### 1. **Hardware Prototype**
- Fully assembled and tested smart plant pot
- 3D-printed enclosure
- All sensors integrated and calibrated
- Pump mechanism working reliably
- OLED display with emotion faces
- WiFi and MQTT connectivity
- Stable 24+ hour operation

#### 2. **Machine Learning Models**
- Watering prediction model (>85% accuracy)
- Anomaly detection model
- Disease detection model (optional)
- Model files (.pkl and/or .tflite format)
- Evaluation metrics documentation
- Model cards with specifications

#### 3. **Backend API & Infrastructure**
- Flask REST API (6+ endpoints)
- PostgreSQL database (Railway cloud)
- MQTT integration (HiveMQ broker)
- Redis caching system
- Public API URL (https://...)
- Deployed on Railway.app

#### 4. **User Interface**
- Telegram bot (@username) deployed and live
- 6+ functional bot commands
- Streamlit web dashboard (public URL)
- Real-time data visualization
- Mobile-responsive design
- User-friendly interface

#### 5. **Documentation**
- Complete final report (15-20 pages, .docx)
  - Project overview
  - System architecture
  - Hardware documentation
  - ML/AI implementation
  - Backend API documentation
  - UI/UX design documentation
  - Deployment guides
  - Troubleshooting guides
  - Results and metrics
- Technical documentation
  - API reference
  - Database schema diagrams
  - Hardware schematic and wiring diagrams
  - Setup and installation guides
  - Code comments and docstrings

#### 6. **Software Code**
- Hardware firmware (Arduino/C++)
- Backend server (Python Flask)
- Machine learning models (Python)
- Telegram bot (Python)
- Dashboard (Python Streamlit)
- All code in GitHub repository with proper documentation

#### 7. **Demo Video**
- Professional quality (3-7 minutes)
- System overview
- Feature demonstrations
- Hardware assembly
- Live testing
- Results and achievements

#### 8. **Code Repository**
- GitHub repository with all source code
- Proper folder structure
- README files for each component
- Installation and setup guides
- Contribution guidelines
- License information

---

## COLLABORATION MATRIX

### Team Interdependencies

| From | To | Dependency | When | What | Risk |
|------|----|------------|------|------|------|
| A | B | ML models | W3 | .pkl files | Model too large/slow |
| B | C | MQTT topics | W1-3 | Protocol spec | Format mismatch |
| B | D | API endpoints | W3 | URL & data format | Format change |
| C | D | OLED specs | W6 | Display size/capability | Layout doesn't fit |
| A | D | Predictions | W5-6 | Alert data format | Missing features |
| C | B | Sensor data | W3 | MQTT message format | Parsing issues |

### Weekly Synchronization Points

**Monday 10:00 AM (30 min) - Status Standup**
- What did each member accomplish?
- What are the blockers?
- What's the priority for this week?
- Any escalations needed?

**Wednesday 3:00 PM (1 hour) - Technical Discussion**
- Deep dive into technical challenges
- Code review and feedback
- Architecture discussions
- Problem-solving sessions

**Friday 5:00 PM (1 hour) - Demo & Feedback**
- Demonstration of completed features
- Team feedback and suggestions
- Upcoming week planning
- Celebration of wins

---

## COMMUNICATION PLAN

### Daily Communication (Asynchronous)
- **Platform:** WhatsApp/Discord group chat
- **Frequency:** Daily updates
- **Content:** Progress summary, blockers, questions
- **Response Time:** Within 4 hours maximum

### Weekly Communication (Synchronous)
- **Monday 10:00 AM:** Status standup (30 min)
- **Wednesday 3:00 PM:** Technical discussion (1 hour)
- **Friday 5:00 PM:** Demo & feedback (1 hour)

### Documentation & Code
- **Docs Platform:** Google Drive (shared folder)
- **Code Repository:** GitHub with frequent commits
- **Issues/Tasks:** GitHub Issues or Trello board
- **Meeting Notes:** Google Docs (shared)

### Escalation Procedure
1. Identify blocker in team chat
2. If not resolved in 4 hours, escalate to project lead
3. If critical, immediate meeting required
4. Document resolution in GitHub Issues

---

## SUCCESS METRICS

### ANGGOTA A: ML & AI

**Performance Metrics:**
- [ ] Watering model accuracy ≥85%
- [ ] Anomaly model detecting 80%+ of anomalies
- [ ] Disease model accuracy ≥90% (if implemented)
- [ ] Inference time <500ms per request
- [ ] F1-score ≥0.80 on test set

**Deliverable Metrics:**
- [ ] 3 models trained and saved
- [ ] Confusion matrices generated
- [ ] ML section of report (3-4 pages)
- [ ] Model cards created
- [ ] Code well-documented

---

### ANGGOTA B: SOFTWARE/BACKEND

**Performance Metrics:**
- [ ] API latency <500ms (p95)
- [ ] 99%+ uptime during testing
- [ ] Database queries <100ms
- [ ] Handle 10+ concurrent requests

**Functionality Metrics:**
- [ ] All 6+ endpoints working
- [ ] MQTT bidirectional communication
- [ ] ML models loading successfully
- [ ] Error handling implemented

**Deliverable Metrics:**
- [ ] Public API URL working
- [ ] Backend section of report (3-4 pages)
- [ ] Complete API documentation
- [ ] Deployment guide created

---

### ANGGOTA C: HARDWARE

**Hardware Metrics:**
- [ ] All sensors calibrated and working
- [ ] MQTT communication bidirectional
- [ ] 24+ hour stability test passed
- [ ] Pump activation reliable
- [ ] OLED display functioning

**Software Metrics:**
- [ ] Firmware compiles without errors
- [ ] No memory leaks detected
- [ ] Proper error handling
- [ ] Code well-commented

**Deliverable Metrics:**
- [ ] Working prototype
- [ ] Hardware section of report (2-3 pages)
- [ ] Wiring and schematic diagrams
- [ ] Assembly instructions

---

### ANGGOTA D: UI/UX

**Functionality Metrics:**
- [ ] All 6+ bot commands working
- [ ] Dashboard displaying real-time data
- [ ] Manual controls functional
- [ ] Settings panel working

**Design Metrics:**
- [ ] Mobile-responsive design confirmed
- [ ] Color contrast sufficient (4.5:1)
- [ ] Font sizes readable
- [ ] Load times acceptable

**User Metrics:**
- [ ] User testing feedback positive
- [ ] Interface intuitive and clear
- [ ] No user confusion reported
- [ ] High user satisfaction

**Deliverable Metrics:**
- [ ] Bot deployed and live
- [ ] Dashboard deployed with public URL
- [ ] UI/UX section of report (2-3 pages)
- [ ] User manual created

---

## RISK MANAGEMENT

### Identified Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|-----------|
| Hardware components defective | Medium | High | Order 20% extra, test immediately |
| Insufficient training data | Medium | High | Start data collection immediately |
| ML model accuracy <80% | Medium | High | Plan for more data/different algorithm |
| MQTT connection issues | Medium | Medium | Test early, have fallback plan |
| Timeline delays | High | High | Use Agile approach, adjust scope if needed |
| Team member unavailability | Low | High | Proper documentation, backup support |
| API latency too high | Medium | Medium | Early performance testing, optimization |
| Deployment failures | Low | Medium | Test deployment frequently |

### Contingency Plans

**If ML accuracy <80%:**
- Option 1: Collect more training data (2+ weeks)
- Option 2: Try different algorithm (XGBoost, Neural Network)
- Option 3: Reduce model complexity, accept lower accuracy
- Option 4: Reduce feature set

**If hardware unstable:**
- Switch to alternative components if available
- Simplify firmware (remove non-essential features)
- Extend timeline for debugging

**If timeline delayed:**
- Reduce scope (remove optional features)
- Extend timeline (if possible)
- Parallel work streams
- Reduce documentation detail

---

## APPENDIX

### A. File Structure for GitHub Repository

```
smart-plant-pot/
├── README.md
├── .gitignore
├── LICENSE
│
├── backend/
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   ├── models/
│   │   ├── watering_model.pkl
│   │   ├── anomaly_model.pkl
│   │   └── disease_model.tflite
│   ├── api/
│   │   ├── routes.py
│   │   ├── middleware.py
│   │   └── schemas.py
│   ├── database/
│   │   ├── models.py
│   │   ├── connection.py
│   │   └── schema.sql
│   ├── docs/
│   │   └── API_REFERENCE.md
│   └── tests/
│       └── test_api.py
│
├── ml/
│   ├── README.md
│   ├── requirements.txt
│   ├── notebooks/
│   │   ├── 01_eda.ipynb
│   │   ├── 02_model_training.ipynb
│   │   └── 03_evaluation.ipynb
│   ├── data/
│   │   ├── raw/
│   │   ├── processed/
│   │   └── README.md
│   ├── models/
│   │   ├── watering_model.pkl
│   │   └── scaler.pkl
│   └── scripts/
│       ├── preprocess.py
│       ├── train.py
│       └── evaluate.py
│
├── firmware/
│   ├── smart_pot_firmware.ino
│   ├── sensors.h
│   ├── display.h
│   ├── pump.h
│   ├── wifi.h
│   ├── README.md
│   └── diagrams/
│       ├── wiring_diagram.png
│       └── schematic.png
│
├── ui/
│   ├── telegram_bot.py
│   ├── dashboard.py
│   ├── requirements.txt
│   ├── README.md
│   └── screenshots/
│
└── docs/
    ├── PROJECT_OVERVIEW.md
    ├── ARCHITECTURE.md
    ├── DEPLOYMENT_GUIDE.md
    ├── USER_MANUAL.md
    └── FINAL_REPORT.docx
```

### B. Technology Stack

**Frontend:**
- Telegram Bot: python-telegram-bot library
- Web Dashboard: Streamlit framework
- Visualization: Plotly, Matplotlib

**Backend:**
- Framework: Flask or FastAPI
- Database: PostgreSQL
- Caching: Redis
- Message Broker: MQTT (HiveMQ)
- Hosting: Railway.app

**Machine Learning:**
- Data Processing: Pandas, NumPy
- Modeling: Scikit-learn
- Deep Learning: TensorFlow/Keras (optional)
- Visualization: Matplotlib, Seaborn

**Hardware:**
- Microcontroller: ESP32 WROOM-32
- IDE: Arduino IDE 2.0+
- Programming Language: C++
- Libraries: DHT, Wire (I2C), Relay control

**Development & Deployment:**
- Version Control: Git & GitHub
- Documentation: Markdown
- Communication: WhatsApp/Discord, Google Meet
- Project Management: Trello or GitHub Issues

### C. Budget Allocation

| Category | Amount | Percentage |
|----------|--------|-----------|
| Core Hardware | Rp 700K | 70% |
| 3D Printing (Enclosure) | Rp 150K | 15% |
| Contingency Buffer | Rp 150K | 15% |
| **TOTAL** | **Rp 1,000K** | **100%** |

### D. Key Dates

- **Week 0 (Jan 10-14):** Team setup, environment setup
- **Week 1 (Jan 15-21):** MVP Sprint 1 (Components, APIs, Bot basics)
- **Week 2 (Jan 22-28):** MVP Sprint 2 (Firmware, Models, Bot commands)
- **Week 3 (Jan 29-Feb 4):** MVP Complete, Integration
- **Week 5 (Feb 12-18):** Features Complete, Ready for optimization
- **Week 7 (Feb 26-Mar 4):** Production Ready, Documentation starts
- **Week 8 (Mar 5-11):** Report Writing
- **Week 9 (Mar 12-18):** Video Production
- **Week 10 (Mar 19-25):** Final Submission!

---

## CONCLUSION

This document provides a comprehensive framework for the Smart Personalized Plant Pot project execution. Each team member has clear, defined responsibilities with specific deliverables and success criteria. The 10-week timeline is achievable with proper execution, communication, and collaboration.

**Success depends on:**
1. Clear understanding of roles and responsibilities
2. Regular communication and synchronization
3. Early identification and resolution of blockers
4. Commitment to timeline and deliverables
5. Strong teamwork and mutual support

**The team is ready to proceed with implementation!**

---

**Document Prepared By:** Project Lead  
**Date Prepared:** January 10, 2026  
**Last Updated:** January 10, 2026  
**Status:** APPROVED FOR IMPLEMENTATION  
**Version:** 2.0 - FINAL

---

**Signature & Approval:**

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Anggota A (ML & AI) | __________ | __________ | __/__/__ |
| Anggota B (Software) | __________ | __________ | __/__/__ |
| Anggota C (Hardware) | __________ | __________ | __/__/__ |
| Anggota D (UI/UX) | __________ | __________ | __/__/__ |
| Project Lead | __________ | __________ | __/__/__ |

---

**END OF DOCUMENT**