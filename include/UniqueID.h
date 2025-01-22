#ifndef UNIQUE_ID_H
#define UNIQUE_ID_H

#include <Arduino.h>
#include <mbedtls/sha256.h>

class UniqueID {
public:
    static String generateHashedMAC(const String& macAddress);
};

#endif // UNIQUE_ID_H