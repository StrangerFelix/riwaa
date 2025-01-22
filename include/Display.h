#ifndef DISPLAY_H
#define DISPLAY_H

#include <U8g2lib.h>
#include <Icon.h>
#include <Constants.h>

class Display {
    private:
        U8G2_SH1106_128X64_NONAME_F_HW_I2C* display;
    public:
        void initializeDisplay();
        void drawIcon();
        void drawData(float temperature, float humidity);
};

#endif