#include "WiFiProvisioning.h"

void WiFiProvisioning :: init(Display display) {
    wifiManager.setConnectTimeout(10); // 10 seconds for connection
    // Check if WiFi credentials are stored
    if (hasStoredCredentials()) {
        Serial.println("Credentials found. Attempting to connect...");
        if (connectToWiFi()) {
        Serial.println("Connected to WiFi!");
        Serial.print("IP Address: ");
        Serial.println(WiFi.localIP());

        return;
        } else {
        Serial.println("Stored credentials are invalid. Starting AP...");
        resetWiFiManager(); // Clear invalid credentials
        }
    } else {
        Serial.println("No credentials found. Starting AP...");
    }

    // Start AP for configuration
    startCaptivePortal(display);
}

bool WiFiProvisioning :: hasStoredCredentials() {
    String ssid = WiFi.SSID();
    String password = WiFi.psk();
    return ssid.length() > 0;
}

bool WiFiProvisioning :: connectToWiFi() {
    Serial.println("Attempting to connect to WiFi...");
    WiFi.mode(WIFI_STA); // Set WiFi to station mode
    WiFi.begin();        // Use stored credentials

    unsigned long startAttemptTime = millis();

    // Wait for the connection to succeed or timeout
    while (WiFi.status() != WL_CONNECTED && millis() - startAttemptTime < WIFI_CONNECT_TIMEOUT) {
        Serial.print(".");
        delay(500);
    }

    // Check connection status
    if (WiFi.status() == WL_CONNECTED) {
        Serial.println("\nConnected to WiFi.");
        Serial.print("IP Address: ");
        Serial.println(WiFi.localIP());
        return true; // Connection successful
    } else {
        Serial.println("\nFailed to connect to WiFi. Reason:");
        switch (WiFi.status()) {
        case WL_NO_SSID_AVAIL:
            Serial.println("SSID not available.");
            break;
        case WL_CONNECT_FAILED:
            Serial.println("Incorrect password.");
            break;
        case WL_DISCONNECTED:
            Serial.println("WiFi disconnected.");
            break;
        default:
            Serial.println("Unknown error.");
            break;
        }
        return false; // Connection failed
    }
}


void WiFiProvisioning :: startCaptivePortal(Display display) {
    String mac = WiFi.macAddress();
    String hashedMAC = UniqueID::generateHashedMAC(mac);
    String espSSID =  "Riwaa-" + hashedMAC.substring(0, 6);
    while (true) {
        Serial.println("Starting Access Point for WiFi configuration...");
        wifiManager.setConfigPortalBlocking(false); // Non-blocking mode

        // wifiManager.setCustomHeadElement(customCSS.c_str());

        // Start the AP
        bool userConnected = wifiManager.autoConnect(espSSID.c_str()); // Captive portal

        if (hasStoredCredentials()) {
            display.drawWiFiState(0, espSSID);
        } else {
            display.drawWiFiState(2, espSSID);
        }
        
        bool userInputProvided = false;
        while (true) {
            wifiManager.process();

            // Check if user provided credentials
            if (WiFi.SSID().length() > 0) { // Detect if credentials are entered
                userInputProvided = true;
                display.drawWiFiState(0, espSSID);
                break;
            }

            delay(100); // Allow time for portal processing
        }
        
        if (userInputProvided) {

            // Disconnect any previous connection attempts
            WiFi.disconnect();
            delay(1000); // Small delay for stability
            if (connectToWiFi()) {
                display.drawWiFiState(1, espSSID);
                Serial.println("Connected to WiFi successfully!");
                saveCredentials(WiFi.SSID(), WiFi.psk()); // Save the credentials
                return;                                   // Exit the loop and function
            }else {
                Serial.println("Connection failed. Stopping AP and restarting after 10 seconds...");
                display.drawWiFiState(-1, espSSID);
                // Stop the AP
                WiFi.softAPdisconnect(true); // Turn off the AP
                delay(10000);                // Wait 10 seconds before restarting the AP

                // Clear invalid credentials and restart the AP
                wifiManager.resetSettings();
                Serial.println("Restarting Access Point...");
            }
        }
    }
}

void WiFiProvisioning :: resetWiFiManager() {
  Serial.println("Resetting WiFiManager and clearing saved credentials...");
  wifiManager.resetSettings();
  WiFi.disconnect(true, true); // Clear credentials from flash memory
}

/**
 * Saves WiFi credentials persistently.
 */
void WiFiProvisioning :: saveCredentials(String ssid, String password) {
    Preferences preferences;
    preferences.begin("wifi", false);
    preferences.putString("ssid", ssid);
    preferences.putString("password", password);
    preferences.end();
    Serial.println("Credentials saved successfully.");
}

String WiFiProvisioning :: getAPName() {
    String mac = WiFi.macAddress();
    String hashedMAC = UniqueID::generateHashedMAC(mac);
    return "Riwaa-" + hashedMAC.substring(0, 6);
}
