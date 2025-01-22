#include "Sensors.h"

void Sensors::initializeDHT(int pin) {
    dht = new DHT(pin, DHT11);
    dht->begin();
}

float Sensors::getTemperature() {
    float temperature = dht->readTemperature();
    if (isnan(temperature)) {
        return 0.0;
    }
    return temperature;
}

float Sensors::getHumidity() {
    float humidity = dht->readHumidity();
    if (isnan(humidity)) {
        return 0.0;
    }
    return humidity;
}

float Sensors::getMoisture(int pin) {
    return 0.0;
}
