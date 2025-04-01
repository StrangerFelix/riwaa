#ifndef SENSORS_H
#define SENSORS_H

#include "DHT.h"
#include "Constants.h"

class Sensors {
private:
    DHT* dht;
public:
    void init();
    float getTemperature();
    float getHumidity();
    float getMoisture();
};

#endif // SENSOR_H