#include "FirebaseService.h"
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>
#include "Constants.h"
#include <time.h>

bool FirebaseService::init(String devId,Display display) {
    display.drawFirebaseState(0);
    delay(600);
    deviceId = devId;
    config.api_key = FIREBASE_API_KEY;
    config.database_url = FIREBASE_HOST;
    bool init = Firebase.signUp(&config, &auth,"","");
    if (!init) {
        Serial.printf("FirebaseError: %s\n",config.signer.signupError.message.c_str());
        isInitialized = false;
        display.drawFirebaseState(-1);
        delay(1500);
        return false;
    } else {
        display.drawFirebaseState(1);
        // delay(1500);
    }
    config.token_status_callback = tokenStatusCallback;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);
    
    String devicePath = "/devices/";
    devicePath += deviceId;
    if (Firebase.RTDB.getJSON(&fbdo, devicePath.c_str())) {
        // Device exists, just update operational values
        Serial.println("Device already registered, updating operational values");
        
        // Only update operational values
        FirebaseJson json;
        json.add("pump_control", 0);  // Reset pump control on restart
        
        if (Firebase.RTDB.updateNode(&fbdo, devicePath.c_str(), &json)) {
            Serial.println("Device operational values updated");
        } else {
            Serial.print("Failed to update device values: ");
            Serial.println(fbdo.errorReason().c_str());
        }
    } else {
        display.drawFirebaseState(2);
        Serial.println("New device, creating full structure");
        unsigned long currentTimestamp = getTimeStamp();
        FirebaseJson json;
        json.add("pump_control", 0);
        json.add("moisture", -1);
        json.add("temperature", -49);
        json.add("humidity", -1);
        json.add("created_at", currentTimestamp);  // Initial creation timestamp
        json.add("isAddedToFirestore", false);
        json.add("last_updated", currentTimestamp);
        
        if (Firebase.RTDB.setJSON(&fbdo, devicePath.c_str(), &json)) {
            Serial.println("Device structure created successfully");
        } else {
            Serial.print("Failed to create device structure: ");
            Serial.println(fbdo.errorReason().c_str());
        }
    }
    
    // Start listening for pump control changes
    
    isInitialized = true;
    setPumpPin();
    beginPumpListener();
    Serial.println("Firebase initialized successfully");
    return isInitialized;
}

bool FirebaseService::writeData(const String& path, const String& jsonData) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    FirebaseJson json;
    json.setJsonData(jsonData);
    
    Serial.print("Sending data to: ");
    Serial.println(path);
    
    if (Firebase.RTDB.setJSON(&fbdo, path.c_str(), &json)) {
        Serial.println("Data sent successfully");
        return true;
    } else {
        Serial.print("Failed to send data: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

bool FirebaseService::writeInt(const String& path, int value) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    if (Firebase.RTDB.setInt(&fbdo, path.c_str(), value)) {
        Serial.print("Integer value set at: ");
        Serial.print(path);
        Serial.print(" = ");
        Serial.println(value);
        return true;
    } else {
        Serial.print("Failed to set integer: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

bool FirebaseService::writeFloat(const String& path, float value) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    if (Firebase.RTDB.setFloat(&fbdo, path.c_str(), value)) {
        Serial.print("Float value set at: ");
        Serial.print(path);
        Serial.print(" = ");
        Serial.println(value);
        return true;
    } else {
        Serial.print("Failed to set float: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

bool FirebaseService::readInt(const String& path, int& value) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    if (Firebase.RTDB.getInt(&fbdo, path.c_str())) {
        value = fbdo.to<int>();
        Serial.print("Integer value at ");
        Serial.print(path);
        Serial.print(": ");
        Serial.println(value);
        return true;
    } else {
        Serial.print("Failed to read integer: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

bool FirebaseService::readFloat(const String& path, float& value) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    if (Firebase.RTDB.getFloat(&fbdo, path.c_str())) {
        value = fbdo.to<float>();
        Serial.print("Float value at ");
        Serial.print(path);
        Serial.print(": ");
        Serial.println(value);
        return true;
    } else {
        Serial.print("Failed to read float: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

void FirebaseService::setPumpPin() {
    pinMode(PUMP_PIN, OUTPUT);
    digitalWrite(PUMP_PIN, LOW); // Ensure pump is off initially
}

bool FirebaseService::beginPumpListener() {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return false;
    }
    
    String pumpControlPath = "/devices/";
    pumpControlPath += deviceId;
    pumpControlPath += "/pump_control";
        
    if (Firebase.RTDB.beginStream(&fbdo, pumpControlPath.c_str())) {
        Serial.print("Listening for pump control changes at: ");
        Serial.println(pumpControlPath);
        return true;
    } else {
        Serial.print("Failed to begin stream: ");
        Serial.println(fbdo.errorReason().c_str());
        return false;
    }
}

void FirebaseService::pumpControlListener() {
    if (Firebase.RTDB.readStream(&fbdo)) {
        if (fbdo.streamAvailable()) {
            String path = fbdo.dataPath();
            String dataType = fbdo.dataType();
            
            Serial.println("=== Stream Data Available ===");
            Serial.print("Path: "); Serial.println(path);
            Serial.print("Type: "); Serial.println(dataType);
            Serial.print("Data: "); Serial.println(fbdo.stringData());
            
            // Try different path checks
            if (path == "/" || path.indexOf("/pump_control") >= 0) {
                Serial.println("Pump control path detected!");
                
                if (dataType == "int" || dataType == "boolean") {
                    int pumpValue = fbdo.to<int>();

                    // Debug: check pump activation condition
                    Serial.print("Pump should activate: ");
                    Serial.println((pumpValue == 1) ? "YES" : "NO");
                    
                    if (pumpValue == 1) {
                        // Turn on the pump
                        Serial.println("Turning pump ON for 10 seconds");
                        digitalWrite(PUMP_PIN, HIGH);
                        pumpActive = true;
                        pumpStartTime = millis();
                    }
                }
            }
        }
    }
    
    // Check if it's time to turn off the pump
    if (pumpActive && (millis() - pumpStartTime >= PUMP_DURATION)) {
        // Turn off the pump
        Serial.println("Turning pump OFF after 10 seconds");
        digitalWrite(PUMP_PIN, LOW);
        pumpActive = false;
        
        // Reset the pump_control value in Firebase back to 0
        String pumpControlPath = "/devices/";
        pumpControlPath += deviceId;
        pumpControlPath += "/pump_control";
        
        Serial.print("Resetting pump_control to 0 at path: ");
        Serial.println(pumpControlPath);
        
        if (Firebase.RTDB.setInt(&fbdo, pumpControlPath.c_str(), 0)) {
            Serial.println("Successfully reset pump_control to 0 in Firebase");
        } else {
            Serial.print("Failed to reset pump_control: ");
            Serial.println(fbdo.errorReason().c_str());
        }
    }
}

unsigned long FirebaseService::getTimeStamp() {
    configTime(0, 0, "pool.ntp.org");
    while (time(&now) < 1000000000) {
        delay(10);
    }
    return now;
}

void FirebaseService::sendToFirebase(float temp, float humidity, float moisture,Display display) {
    unsigned long currentMillis = millis();
    if (firstLoop || currentMillis - lastUploadTime >= UPLOAD_INTERVAL) {
        display.drawFirebaseState(2);
        lastUploadTime = currentMillis;
        firstLoop = false;
        unsigned long currentTimestamp = getTimeStamp();
        // Construct the device path
        String devicePath = "/devices/";
        devicePath += deviceId;
        
        // Update individual sensor values
        Serial.println("Sending sensor data to Firebase...");
        
        if (temp > -49 && temp < 100) { // Valid temperature value
            String path = devicePath;
            path += "/temperature";
            writeFloat(path, temp);
        }
        
        if (humidity >= 0 && humidity <= 100) { // Valid humidity value
            String path = devicePath;
            path += "/humidity";
            writeFloat(path, humidity);
        }
        
        if (moisture >= 0 && moisture <= 100) { // Valid moisture value
            String path = devicePath;
            path += "/moisture";
            writeFloat(path, moisture);
        }
        delay(10);
        if (!isnan(currentTimestamp)) {
            String path = devicePath;
            path += "/last_updated";
            writeInt(path, currentTimestamp);
        } else {
            Serial.println("Error: Invalid currentMillis value");
        }
        
        if (firstLoop || currentMillis - lastHistoryUpload >= HISTORY_INTERVAL) {
            lastHistoryUpload = currentMillis;
            
            String jsonData = "{\"temperature\":";
            jsonData += String(temp);
            jsonData += ",\"humidity\":";
            jsonData += String(humidity);
            jsonData += ",\"moisture\":";
            jsonData += String(moisture);
            jsonData += ",\"timestamp\":";
            jsonData += currentTimestamp;
            jsonData += "}";
            
            String historyPath = "/devices/";
            historyPath += deviceId;
            historyPath += "/history/";
            historyPath += String(getTimeStamp());
            writeData(historyPath, jsonData);
            
            Serial.println("History data recorded");
        }
        Serial.println("Sensor data uploaded to Firebase");
    }
}

bool FirebaseService::checkAndRestoreFirebaseConnection() {
    // If WiFi is connected but Firebase seems unresponsive, try to reinitialize
    if (WiFi.status() == WL_CONNECTED) {
        if (!fbdo.httpConnected()) {
            Serial.println("Firebase connection appears to be down. Reinitializing...");
            
            // Attempt to reestablish Firebase connection
            Firebase.begin(&config, &auth);
            Firebase.reconnectWiFi(true);
            
            // Restart the pump listener
            beginPumpListener();
            
            return true;
        }
    }
    return false;
}

void FirebaseService::loop(float temp, float humidity, float moisture,Display display) {
    if (!isInitialized) {
        Serial.println("Firebase not initialized");
        return;
    }
    static unsigned long lastConnectionCheck = 0;
    const unsigned long CONNECTION_CHECK_INTERVAL = 60000; // 1 minute
    unsigned long currentMillis = millis();
    
    // Periodically check connections
    if (currentMillis - lastConnectionCheck > CONNECTION_CHECK_INTERVAL) {
        lastConnectionCheck = currentMillis;
        
        // Check WiFi connection
        if (WiFi.status() != WL_CONNECTED) {
            display.drawFirebaseState(0);
            Serial.println("WiFi connection lost, reconnecting...");
            WiFi.reconnect();
            // Wait for reconnection
            unsigned long reconnectStart = millis();
            while (WiFi.status() != WL_CONNECTED && millis() - reconnectStart < 10000) {
                delay(100);
            }
        }
        
        // Check and restore Firebase connection if needed
        if (WiFi.status() == WL_CONNECTED) {
            checkAndRestoreFirebaseConnection();
        }
    }
    
    pumpControlListener();
    sendToFirebase(temp, humidity, moisture,display);
    
}