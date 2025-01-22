#ifndef SENSORS_H
#define SENSORS_H

#include "DHT.h"

class Sensors {
private:
    DHT* dht;
public:
    void initializeDHT(int pin);
    float getTemperature();
    float getHumidity();
    float getMoisture(int pin);
};

#endif // SENSOR_H