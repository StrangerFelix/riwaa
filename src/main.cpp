// Libraries
#include <Arduino.h>
#include <UniqueID.h>
#include <Sensors.h>
#include <Constants.h>
#include <Display.h>
#include <WiFiProvisioning.h>
#include <FirebaseService.h>

// Globals
Sensors mySensors;
WiFiProvisioning wifiProvisioning;
Display display;
FirebaseService firebase;

unsigned long previousMillis = 0;
const unsigned long UPLOAD_INTERVAL = 600000; // 10 minutes in milliseconds

void setup() {  
  // Initializing
  Serial.begin(115200);
  delay(50);
  
  // Initializing
  display.init();
  mySensors.init();
  display.drawIntro();
  wifiProvisioning.init(display);
  
  String hashedMAC = UniqueID::generateHashedMAC(wifiProvisioning.getMACAddress());
  firebase.init(hashedMAC,display);
  delay(2000);
  
}


void loop() {
  unsigned long currentMillis = millis();
  // Getting data
  float temperature = mySensors.getTemperature();
  float moisture = mySensors.getMoisture();
  float humidity = mySensors.getHumidity();

  firebase.loop(temperature, humidity, moisture,display);
  display.drawData(temperature, moisture);
  
  delay(100);
  
}

/********************************* */

