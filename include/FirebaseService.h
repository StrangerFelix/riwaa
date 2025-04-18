#ifndef FIREBASE_SERVICE_H
#define FIREBASE_SERVICE_H

#include <Arduino.h>
#include <Firebase_ESP_Client.h>
#include <Display.h>
#include "Secrets.h"

class FirebaseService {
private:
    FirebaseData fbdo;
    FirebaseConfig config;
    FirebaseAuth auth;
    String deviceId;
    time_t now;
    bool isInitialized;
    bool pumpActive = false;
    bool firstLoop = true;
    unsigned long pumpStartTime = 0;
    const unsigned long PUMP_DURATION = 12000; // 12 seconds in milliseconds
    const unsigned long UPLOAD_INTERVAL = 600000; // 10 minutes in milliseconds
    const unsigned long HISTORY_INTERVAL = 3600000; // 1 hour in milliseconds
    unsigned long lastUploadTime = 0;
    unsigned long lastHistoryUpload = 0;
public:
    FirebaseService() {};

    bool init(String devId,Display display);
    void setPumpPin();
    // Write data
    bool writeData(const String& path, const String& jsonData);
    bool writeInt(const String& path, int value);
    bool writeFloat(const String& path, float value);
    
    // Read data methods
    bool readInt(const String& path, int& value);
    bool readFloat(const String& path, float& value);
    
    unsigned long getTimeStamp();
    // Listen for pump control
    bool beginPumpListener();
    void pumpControlListener();
    void sendToFirebase(float temp, float humidity, float moisture,Display display);
    bool checkAndRestoreFirebaseConnection();
    // Process events (call in loop)
    void loop(float temp,float humidity, float moisture,Display display);
};
#endif