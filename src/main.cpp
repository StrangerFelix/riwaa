// Libraries
#include <Arduino.h>
#include <WiFiManager.h>
#include <UniqueID.h>
#include <Sensors.h>
#include <Constants.h>
#include <Display.h>


// Globals
Sensors mySensors;
WiFiManager wifiManager;
Display display;

void setup() {  
  // Initializing
  Serial.begin(115200);
  delay(50);

  // Initializing
  display.init();
  wifiManager.init();
  mySensors.initializeDHT(DHT_PIN);


  
  // hashing MAC Address
  String hashedMAC = UniqueID::generateHashedMAC(wifiManager.getMACAddress());
  String MAC = wifiManager.getMACAddress();
  Serial.println("MAC Address: " + MAC);
  Serial.println("hashedMAC: " + hashedMAC);
  display.drawIntro();
}

void loop() {
  // Getting data
  float temperature = mySensors.getTemperature();
  float humidity = mySensors.getHumidity();
  display.drawData(temperature, humidity);
  delay(1000);
  
}
