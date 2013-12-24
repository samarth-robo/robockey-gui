#include "m_general.h"
#include "m_rf.h"
#include "m_bus.h"

int main() {
    m_red(ON);

    m_clockdivide(0);
    m_disableJTAG();
    m_bus_init();

    m_rf_open(1, 0xD1, 10);

    m_red(OFF);

    char buf[10] = {0x08, 10, 10, 0, 0, 0, 0, 0, 0, 0};
    while(1) {
        m_green(ON);
        m_rf_send(0xDA, buf, 10);
        buf[1] += 5;
        if(buf[1] >= 220) buf[1] = 10;
        m_green(OFF);

        m_wait(500);
    }
    return 0;
}
