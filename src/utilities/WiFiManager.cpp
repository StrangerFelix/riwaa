#include "WiFiManager.h"

void WiFiManager::initializeWiFi() {
    WiFi.mode(WIFI_STA); // Set Wi-Fi to Station mode
    delay(100);
    // WiFi.disconnect();   // Ensure no active connections
    Serial.println("Wi-Fi initialized in Station mode.");
}

String WiFiManager::getMACAddress() {
    return WiFi.macAddress();
}