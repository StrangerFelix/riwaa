# Riwaa - Automated Plant Watering and Monitoring System

## Overview

**Riwaa** is an innovative final year project developed as part of the Computer Engineering course. It integrates a **Flutter mobile app** and an **ESP32-based system** to automate the process of plant watering and monitoring. The project leverages **Firebase** for data storage and communication between the mobile app and the ESP32 hardware.

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

### Flutter App:
1. Clone this repository:
   ```bash
   git clone https://github.com/YahyaAlDallal/riwaa.git
