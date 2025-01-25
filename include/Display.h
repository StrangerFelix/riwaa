#ifndef DISPLAY_H
#define DISPLAY_H

#include <U8g2lib.h>
#include <Icons.h>
#include <Constants.h>

class Display {
    private:
        U8G2_SH1106_128X64_NONAME_F_HW_I2C* display;
    public:
        void init();
        void drawIntro();
        void drawData(float temperature, float humidity);
        void drawWiFiState(int state,String apname);
};

#endif