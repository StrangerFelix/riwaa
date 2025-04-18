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

void Display::drawData(float temperature, float moisture) {
    char tempval[10];
    char moival[10];

    temperature > 99.5 ? sprintf(tempval, "HI") : temperature >= 0 ? temperature < 10 ? sprintf(tempval, " %d",(int) temperature) : sprintf(tempval, "%d", (int)temperature) : temperature <= -49 ? sprintf(tempval, "ER") :  sprintf(tempval, "LO");
    moisture > 99.5 ? sprintf(moival, "HI") : moisture >= 0 ? moisture < 10 ? sprintf(moival, " %d",(int) moisture) : sprintf(moival, "%d", (int)moisture) : moisture <= -1 ? sprintf(moival, "ER") : sprintf(moival, "LO");
    
    display->clearBuffer();
    display->setFontMode(1);
    display->setBitmapMode(1);

    display->drawXBMP(101, 45, 24, 16, half_battery);

    display->drawXBMP(104, 26, 19, 16, wifi_icon);

    display->setFont(u8g2_font_6x13_tr);
    display->drawStr(49, 21, moival);

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

void Display::drawWiFiState(int state,String apname) {
    switch (state) {
        case 0:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(23, 27, "Connecting to");
            display->drawStr(38, 42, "WiFi ...");
            display->sendBuffer();
            break;
        case 1:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(35, 27, "Connected");
            display->drawStr(26, 43, "Successfully!");


            // display->drawXBMP(106, 23, 14, 16, checkicon);

            // display->drawXBMP(7, 23, 14, 16, checkicon);
            display->sendBuffer();
            break;
        case -1:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(12, 20, "Connection failed!");
            display->drawStr(12, 34, "restarting");
            display->drawStr(12, 48, "connection process");
            display->sendBuffer();
            break;
        case 2:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(9, 14, "Connect to");
            display->drawStr(9, 27, apname.c_str());
            display->drawStr(8, 40, "WiFi network and ");
            display->drawStr(8, 54, "visit 192.168.4.1");
            display->sendBuffer();
            break;
    }
    
}

void Display::drawFirebaseState(int state) {
    switch (state) {
        case 0:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(25, 27, "Initializing");
            display->drawStr(25, 43, "services...");
            display->sendBuffer();
            break;
        case 1:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(26, 27, "Services are");
            display->drawStr(29, 43, "now active!");
            display->sendBuffer();
            break;
        case 2:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(19, 32, "Sending data...");
            display->sendBuffer();
            break;
        case -1:
            display->clearBuffer();
            display->setFont(u8g2_font_6x12_tr);
            display->drawStr(32, 27, "Connection");
            display->drawStr(40, 43, "failed!");
            display->sendBuffer();
            break;
    }
}