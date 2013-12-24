#include "m_general.h"
#include "m_usb.h"
#include "m_rf.h"
#include "m_bus.h"

//robots per team
#define N 4

//char pos[12] = {10, 10, 10, 40, 10, 80, 220, 15, 220, 45, 220, 85}; 
char pos[4*N] = {0}, buf[10];
unsigned char  addr[2*N];

int main() {
    m_red(ON);

    m_clockdivide(0);
    m_disableJTAG();
    m_bus_init();
    m_usb_init();
    while(!m_usb_isconnected()) {}

    while(!m_usb_rx_available()) {}
    char idx = m_usb_rx_char();
    int i;
    if(idx == 's') {
        m_green(ON);
        for(i=0; i < 2*N; i++) {
            while(!m_usb_rx_available()) {}
            addr[i] = m_usb_rx_char();
        }
        m_green(OFF);
    }

    m_rf_open(1, 0xDA, 10);

    cli();

    m_red(OFF);

    bool play = false;

    while(1) {
        if(!m_usb_rx_available()) continue;
        
        idx = m_usb_rx_char();

        if(idx == 'a') {
            m_green(ON);
            m_usb_tx_string("Addresses are: \n");
            for(i = 0; i < 2*N; i++) {
                m_usb_tx_int((int)(addr[i]));
                m_usb_tx_string("\n");
                m_wait(20);
            }
            m_green(OFF);
        }
        else if(idx == 's') {
            m_green(ON);
            for(i=0; i < 2*N; i++) {
                while(!m_usb_rx_available()) {}
                addr[i] = m_usb_rx_char();
            }
            m_green(OFF);
        }
        else if(idx == 'p') {
            sei();
            play = true;
            m_green(ON); m_wait(200); m_green(OFF);
            m_green(ON); m_wait(200); m_green(OFF);
        }
        else if(idx == 'x') {
            cli();
            play = false;
            m_red(ON); m_wait(200); m_red(OFF);
            m_red(ON); m_wait(200); m_red(OFF);
        }
        else if(idx < 1 || idx > 2*N) {
            m_red(ON); m_wait(500); m_red(OFF);
            continue;
        }
        else if(play == true) {
            //m_usb_rx_flush();

            m_green(ON);
            m_wait(2);
            m_usb_tx_char(pos[idx*2 - 2]);
            m_wait(2);
            m_usb_tx_char(pos[idx*2 - 1]);

            /*            
            //just for fun
            if(idx == 1) {
            pos[0]++; pos[2]++; pos[4]++;
            pos[6]--; pos[8]--; pos[10]--;
            }
            */

            m_green(OFF);
        }
    }
    return 0;
}

ISR(INT2_vect) {
    cli();
    m_green(ON);
    m_rf_read(buf, 10);

    int i;
    for(i = 0; i < 2*N; i++) {
        if(buf[0] == addr[i]) {
            pos[2*i] = buf[1];
            pos[2*i + 1] = buf[2];
        }
    }

    /*
    if(buf[0] == addr[0]) {
        pos[0] = buf[1]; pos[1] = buf[2];
    }
    else if(buf[0] == addr[1]) {
        pos[2] = buf[1]; pos[3] = buf[2];
    }
    else if(buf[0] == addr[2]) {
        pos[4] = buf[1]; pos[5] = buf[2];
    }
    else if(buf[0] == addr[3]) {
        pos[6] = buf[1]; pos[7] = buf[2];
    }
    else if(buf[0] == addr[4]) {
        pos[8] = buf[1]; pos[9] = buf[2];
    }
    else if(buf[0] == addr[5]) {
        pos[10] = buf[1]; pos[11] = buf[2];
    }
    else if(buf[0] == addr[]) {
        pos[8] = buf[1]; pos[9] = buf[2];
    }
    else if(buf[0] == addr[5]) {
        pos[10] = buf[1]; pos[11] = buf[2];
    }
    else {
        m_red(ON); m_wait(100); m_red(OFF);
    }
    m_usb_tx_int((int)buf[1]);
    m_usb_tx_string("\n");
    */

    sei();
    m_green(OFF);
}
