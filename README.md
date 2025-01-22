# Riwaa - Automated Plant Watering and Monitoring System

## Overview

**Riwaa** is an innovative final year project developed as part of a Computer Engineering degree. It integrates a **Flutter mobile app** and an **ESP32-based system** to automate the process of plant watering and monitoring. The project leverages **Firebase** for data storage and communication between the mobile app and the ESP32 hardware.

The **Flutter app** allows users to monitor soil moisture levels, control watering, and receive real-time updates about their plants' health. The **ESP32 system** uses a relay to control the water pump based on soil moisture data, ensuring the plants are watered when needed.

## Features

### Flutter App Features:
- **Real-time Monitoring**: Displays live data on the plant's soil moisture levels.
- **Automatic Watering Control**: Interface for manually triggering the watering process.
- **Firebase Integration**: Synchronizes data between the mobile app and the ESP32 hardware.

### ESP32 System Features:
- **Automatic Watering**: Activates the water pump when the soil moisture drops below a threshold.
- **Soil Moisture Sensor**: Monitors soil moisture levels in real time.
- **Data Syncing**: Updates Firebase with the current moisture data for remote monitoring.

## Project Structure

This repository contains two main components:
1. **Flutter App (app branch)**: The mobile app written in Flutter for controlling and monitoring the plant watering system.
2. **ESP32 Code (esp-code branch)**: The firmware written for the ESP32 to handle the plant watering mechanism and data syncing with Firebase.

### Folder Structure:

- **/app**: Contains the Flutter app code.
- **/esp32-code**: Contains the ESP32 firmware code.

## Prerequisites

### Flutter App:
- **Flutter SDK** installed on your machine.
- **Firebase Project**: Set up Firebase for Flutter integration (authentication, Firestore, etc.).
- **Android/iOS Device/Emulator**: To test the app on a physical or virtual device.

### ESP32 System:
- **ESP32 Board**: You need an ESP32 microcontroller.
- **Arduino IDE**: Installed with ESP32 support for programming.
- **Soil Moisture Sensor**: A sensor to detect the soil moisture levels.
- **Relay Module**: Used to control the water pump.
- **Water Pump**: A small submersible pump to water the plant.

## Installation
#### Clone this repository 
##### App branch:
   ```bash
   git clone https://github.com/YahyaAlDallal/riwaa.git
   ```
##### ESP-code branch:
   ```bash
   git clone -b esp-code https://github.com/StrangerFelix/riwaa.git riwaaIOT
   ```
### Flutter App:
1.	Navigate to the Flutter app folder and run:
   ```bash
   cd riwaa/
   flutter pub get
   flutter run
   ```
### ESP32 Code (PlatformIO):
1.	Navigate to the ESP32 Code folder:
   ```bash
   cd riwaaIOT/
   ```
2.	Open the PlatformIO IDE (VS Code with PlatformIO extension recommended).
3.	In PlatformIO, open the project folder (esp32-code).
4.	Make sure to configure your Firebase settings in the secrets.h or config.h file (depending on how you’ve structured your project) to link it with your Firebase project.
•	You’ll need your Firebase API Key, Database URL, and other Firebase credentials.
5.	Select the correct ESP32 board from the PlatformIO toolbar (e.g., ESP32 Dev Module).
6.	Build and upload the code to your ESP32:
•	Click on the PlatformIO “Upload” button or use the terminal:
 ```bash
   pio run --target upload
 ```
7.	Ensure that your soil moisture sensor and relay module are connected correctly to the ESP32 as per the wiring diagram in **riwaa/esp-code/include/Constants.h**.


### Note:
	•	Firebase Integration: For Firebase setup, make sure you have created a Firebase project and enabled the necessary services (Firestore, Realtime Database, etc.).
	•	The Firebase credentials will need to be updated in the code to ensure proper communication between the ESP32 and Firebase.

### How It Works
	1.	The ESP32 continuously monitors the soil moisture level using a soil moisture sensor.
	2.	If the moisture level falls below a defined threshold, the ESP32 triggers the relay to activate the water pump.
	3.	The Flutter app connects to Firebase, displaying real-time data and allowing users to monitor and control the watering process remotely.

### Future Enhancements
	•	Machine Learning Integration: Implementing machine learning algorithms to predict optimal watering times based on environmental conditions.
	•	Multi-Plant Support: Expanding the system to monitor and water multiple plants.
	•	Voice Control: Integrating with a voice assistant for hands-free control of the watering system.

### Contributing

If you wish to contribute to the development of this project, feel free to fork the repository and create a pull request. Please ensure that your code follows the coding standards and is well-documented.

### License

This project is licensed under the MIT License - see the LICENSE file for details.



## Made with ❤️ by Yahya Al-Dallal (Bachelor of Computer Engineering Graduation Project).