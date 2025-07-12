# 🏷️ Smart Automated Product Labeling and Traceability System

This project, developed under the **Intel® Unnati Program**, is a hybrid solution combining **hardware simulation**, **AI-based label inspection**, and a **software dashboard** to automate product labeling, verify label integrity, and ensure traceability throughout the product lifecycle.

---

## 🚀 Project Overview

The system automates the process of labeling and verifying products on a simulated assembly line. It supports:
- Label generation with QR/barcode
- OCR-based label text verification
- Fault detection using AI
- Hardware simulation for sensor-actuator control
- Data logging and traceability through a mobile/web app

---

## 🔧 Project Structure

├── frontend/ # Flutter or React app UI
├── ai_model/ # AI & OCR scripts (YOLO, EasyOCR)
├── hardware_sim/ # Arduino code, circuit diagrams
├── dataset/ # Custom dataset for label verification
├── screenshots/ # UI mockups and final output
├── README.md # Project documentation

yaml
Copy
Edit

---

## 📱 Software + UI/UX (Team Member 1)

- Built using **Flutter** / **React**
- Features login, register, forgot password
- Product labelling dashboard with QR/barcode integration
- Firebase/SQLite database for traceability
- Export logs and simulate label preview

---

## 🧠 AI/ML (Team Member 2)

- **OCR & Verification** using **EasyOCR**
- **Defect Detection** using **YOLOv5**
- Label text accuracy measurement
- Preprocessing with OpenCV
- Dataset from **Kaggle** / custom samples

---

## 🔌 Hardware Simulation (Team Member 3)

- Simulated using **Tinkercad Circuits** / **Proteus**
- Arduino-based sensors and actuators
- Logic for conveyor belt detection and rejection
- Real-time label validation decision-making

---

## 📦 Tech Stack

| Category     | Tools / Technologies               |
|--------------|------------------------------------|
| Frontend     | Flutter / React                    |
| Backend      | Firebase, SQLite                   |
| AI/ML        | Python, OpenCV, EasyOCR, YOLOv5    |
| Hardware     | Arduino, Tinkercad, IR Sensor, Servo |
| Others       | Figma, GitHub, Google Colab        |

---

## 📊 Features

- ✅ Secure login & register
- ✅ QR/Barcode scanning & generation
- ✅ AI-based label verification
- ✅ Label fault detection
- ✅ Traceability dashboard
- ✅ Hardware simulation with sensors and control logic

---

## 🖼️ Screenshots

> See `/screenshots` folder for:
- App UI
- Label scanner output
- Defect detection results
- Tinkercad hardware setup

---

## 📄 How to Run

### 🔹 Frontend
```bash
cd frontend/
flutter run
🔹 AI Model

cd ai_model/
python run_ocr.py
python detect_fault.py
🔹 Hardware Simulation
Open /hardware_sim Arduino code in Tinkercad

Simulate using IR sensor & servo logic

📽️ Demo Video
📎 Link to recorded demo: [Add your Google Drive/YouTube link here]

📘 License
This project is for educational purposes under the Intel Unnati program.
Licensed under the MIT License.

🤝 Acknowledgements
Intel® Unnati Program

Faculty Mentors and Department

Open-source communities

✉️ Contact
For any queries, reach out to us via GitHub Issues or email: [youremail@example.

Let me know if you want help creating a `LICENSE` file or uploading this to
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
