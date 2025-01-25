// Libraries
#include <Arduino.h>
#include <UniqueID.h>
#include <Sensors.h>
#include <Constants.h>
#include <Display.h>
#include <WiFiProvisioning.h>


// Globals
Sensors mySensors;
WiFiProvisioning wifiProvisioning;
Display display;


void setup() {  
  // Initializing
  Serial.begin(115200);
  delay(50);
  
  // Initializing
  display.init();
  mySensors.initializeDHT(DHT_PIN);
  display.drawIntro();
  wifiProvisioning.init(display);

//   hashing MAC Address
//   String hashedMAC = UniqueID::generateHashedMAC(wifiManager.getMACAddress());
//   String MAC = wifiManager.getMACAddress();
//   Serial.println("MAC Address: " + MAC);
//   Serial.println("hashedMAC: " + hashedMAC);
  delay(2000);
  
}


void loop() {
  // Getting data
  float temperature = mySensors.getTemperature();
  float humidity = mySensors.getHumidity();

  display.drawData(temperature, humidity);
    
  delay(100);
  
}

/********************************* */

