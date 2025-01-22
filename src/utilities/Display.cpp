#include "Display.h"

void Display::initializeDisplay() {
    display = new U8G2_SH1106_128X64_NONAME_F_HW_I2C(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);
    display->begin();
}

void Display::drawIcon() {
    display->clearBuffer();

    int x = 64 - (IMAGE_WIDTH / 2);
    int y = 32 - (IMAGE_HEIGHT / 2);

    display->drawXBMP(x, y, IMAGE_WIDTH, IMAGE_HEIGHT, icon_bits);

    display->sendBuffer();

    delay(3000);

    display->clearBuffer();
    display->sendBuffer();
}

void Display::drawData(float temperature, float humidity) {
     display->clearBuffer(); // Clear buffer

    // Draw text for temperature and humidity
    display->setFont(u8g2_font_profont12_tf); // Set font
    // display->setFont(u8g2_font_unifont_t_arabic); // Set font

    display->setCursor(0, 20); // Set position for temperature
    display->print("Temp: ");
    display->print((int)temperature);
    display->print(" C");

    display->setCursor(0, 35); // Set position for humidity
    display->print("Humidity: ");
    display->print((int)humidity);
    display->print(" %");
    display->setCursor(0, 50); // Set position for humidity
    display->print("Moisture: ");
    display->print((int)humidity + 15);
    display->print(" %");

    // Send the buffer to the display
    display->sendBuffer();
}