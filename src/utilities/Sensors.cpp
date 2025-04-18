#include "Sensors.h"

void Sensors::init() {
    // Soil moisture sensor initializing
    // analogReadResolution(12); // ESP32 has 12-bit ADC resolution (0-4095)
    analogSetWidth(12);  // 12-bit resolution
    analogSetAttenuation(ADC_11db);  // Set attenuation for wider voltage range
    // DHT initializing
    dht = new DHT(DHT_PIN, DHT11);
    dht->begin();
}

float Sensors::getTemperature() {
    float temperature = dht->readTemperature();
    if (isnan(temperature)) {
        return -49.0;
    }
    return temperature;
}

float Sensors::getHumidity() {
    float humidity = dht->readHumidity();
    if (isnan(humidity)) {
        return -1.0;
    }
    return humidity;
}

float Sensors::getMoisture() {
    int sum = 0;
    const int numReadings = 15;
    
    for (int i = 0; i < numReadings; i++) {
      sum += analogRead(SOIL_SENSOR_PIN);
      delay(50);
    }
    
    float averageReading = sum / (numReadings * 1.0);
    // Serial.printf("AVG: %f\n",averageReading);
    float moisturePercentage = map(averageReading, AIR_VALUE, WATER_VALUE, 0, 100);
    
    moisturePercentage = constrain(moisturePercentage, 0, 100);

    // return moisturePercentage;

    // بما انه قيمة المي اقل من قيمة الهواء ف اذا ماكو قرائة حيقرة دائما مية بالمية
    // فإحنة راح نكله اذا جتي قراية اقل من قيمة المي بمرتين و هذا الشي مستحيل يصير الا اذا جان
    // الحساس عطلان او ما مركب اصلا فالقرائة تصير من الصفر لحد ارقام صغيرة
    // فاحنة راح نرجع قيمة سالب واحد و هي راح تنطي ايعاز انه اكو ايرور دا يصير بالحساس
    return averageReading < (WATER_VALUE / 2) ? -1 : moisturePercentage;
}