#include "Display.h"

void Display::init() {
    display = new U8G2_SH1106_128X64_NONAME_F_HW_I2C(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);
    display->begin();
}

void Display::drawIntro() {
    display->clearBuffer();

    int x = 64 - (IMAGE_WIDTH / 2);
    int y = 32 - (IMAGE_HEIGHT / 2);

    display->drawXBMP(x, y, IMAGE_WIDTH, IMAGE_HEIGHT, main_icon);

    display->sendBuffer();

    delay(3000);

    display->clearBuffer();
    display->sendBuffer();
}

void Display::drawData(float temperature, float humidity) {
    char tempval[10];
    char humval[10];

    temperature > 99.5 ? sprintf(tempval, "HI") : temperature >= 0 ? temperature < 10 ? sprintf(tempval, " %d",(int) temperature) : sprintf(tempval, "%d", (int)temperature) : sprintf(tempval, "LO");
    humidity > 99.5 ? sprintf(humval, "HI") : humidity >= 0 ? humidity < 10 ? sprintf(humval, " %d",(int) humidity) : sprintf(humval, "%d", (int)humidity) : sprintf(humval, "LO");
    
    display->clearBuffer();
    display->setFontMode(1);
    display->setBitmapMode(1);

    display->drawXBMP(101, 45, 24, 16, half_battery);

    display->drawXBMP(104, 26, 19, 16, wifi_icon);

    display->setFont(u8g2_font_6x13_tr);
    display->drawStr(49, 21, humval);

    display->drawStr(49, 52, tempval);

    display->drawXBMP(104, 3, 19, 20, icon);

    display->drawRFrame(44, 37, 21, 21, 4);

    display->drawRFrame(44, 6, 21, 21, 4);
    display->drawRFrame(44, 7, 21, 19, 2.5);
    display->drawRFrame(44, 38, 21, 19, 2.5);

    display->drawXBMP(4, 3, 25, 27, moisture_icon);

    display->drawXBMP(4, 34, 25, 27, temperature_icon);

    display->drawStr(73, 54, "C");

    display->setFont(u8g2_font_t0_18_tr);
    display->drawStr(70, 22, "%");

    display->drawEllipse(71, 42, 1, 2);


    display->drawXBMP(33, 45, 7, 5, arrow);

    display->drawXBMP(33, 14, 7, 5, arrow);

    display->sendBuffer();
}