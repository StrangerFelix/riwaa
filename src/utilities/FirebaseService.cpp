#include "FirebaseService.h"

bool FirebaseService::init () {
    config.api_key = API_KEY;
    config.database_url = DATABASE_URL;
    deviceId = "YOUR_DEVICE_ID";
    
    
    // Initialize Firebase
    // Firebase.begin(&config);
    Firebase.reconnectWiFi(true);
    
    return Firebase.ready();
}