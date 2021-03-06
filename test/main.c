#include "m_general.h"
#include "m_rf.h"
#include "m_bus.h"
#include "m_usb.h"
char buf[10];

int main() {
    m_red(ON);

    m_clockdivide(0);
    m_disableJTAG();
    m_bus_init();
    m_usb_init();
    while(!m_usb_isconnected()) {}

    m_rf_open(1, 0xDA, 10);

    m_red(OFF);

    while(1) {
        /*
        m_green(ON);
        m_rf_send(0xDA, buf, 10);
        buf[1] += 5;
        if(buf[1] >= 220) buf[1] = 10;
        m_green(OFF);

        m_wait(500);
        */
    }
    return 0;
}

ISR(INT2_vect) {
    m_green(TOGGLE);
    m_rf_read(buf, 10);

    m_usb_tx_int((int)buf[0]);
    m_usb_tx_string("\n");

    //m_green(OFF);
}
