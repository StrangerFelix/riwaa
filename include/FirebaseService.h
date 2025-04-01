#ifndef FIREBASE_H
#define FIREBASE_H

#include <Arduino.h>
#include <Firebase_ESP_Client.h>
#include "addons/RTDBHelper.h"
#include "addons/TokenHelper.h"
#include "Constants.h"

class FirebaseService {
private:
    FirebaseData fbdo;
    FirebaseConfig config;
    String deviceId;
public:
    
    bool init();

    // Write data
    bool writeData(const String& path, const String& jsonData);
    bool writeBool(const String& path, bool value);

    // Read data
    bool readBool(const String& path, bool& value);

    // Listen for pump control
    bool beginPumpListener();

    // Process events (call in loop)
    void loop();
};

#endif