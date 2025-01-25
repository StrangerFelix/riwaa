#ifndef WIFI_PROVISIONING_H
#define WIFI_PROVISIONING_H

#include <Arduino.h>
#include <WiFi.h>
#include <WiFiManager.h>  // https://github.com/tzapu/WiFiManager
#include <Preferences.h>  // To manually manage WiFi credentials if needed
#include <UniqueID.h>
#include <Display.h>

class WiFiProvisioning {
    private:
        const unsigned long WIFI_CONNECT_TIMEOUT = 10000; // 10 seconds timeout for WiFi connection
        const unsigned long AP_RESTART_DELAY = 10000;     // 10 seconds delay before restarting AP
        WiFiManager wifiManager;
    public:
        void init(Display display);
        void startCaptivePortal(Display display);
        bool connectToWiFi();
        bool hasStoredCredentials();
        void resetWiFiManager();
        void saveCredentials(String ssid, String password);
        String getAPName();
};

#endif