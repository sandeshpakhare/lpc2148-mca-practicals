/* Practical 6: GPS interfacing - current latitude and longitude
 * GPS TX -> RXD1 (P0.9), GPS RX -> TXD1 (P0.8), 9600 baud NMEA
 * Output on PC terminal via UART0 (9600)
 * Parses $GPGGA / $GNGGA: field 2 = lat (ddmm.mmmm), 3 = N/S, 4 = lon (dddmm.mmmm), 5 = E/W
 * Decimal degrees = degrees + minutes/60
 */
#include <lpc214x.h>

void uart0_init(void) { PINSEL0 |= 0x05; U0LCR = 0x83; U0DLL = 98; U0DLM = 0; U0LCR = 0x03; }
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }
void uart0_str(char *s) { while (*s) uart0_tx(*s++); }

void uart1_init(void)             // GPS: 9600 baud, 8N1
{
    PINSEL0 |= 0x00050000;        // P0.8 = TXD1, P0.9 = RXD1
    U1LCR = 0x83; U1DLL = 98; U1DLM = 0; U1LCR = 0x03;
}
char uart1_rx(void) { while (!(U1LSR & 0x01)); return U1RBR; }

int main(void)
{
    char buf[80], lat[15], lon[15], ns = ' ', ew = ' ', c;
    int i, field, k;
    lat[0] = lon[0] = '\0';
    uart0_init();
    uart1_init();

    while (1)
    {
        while (uart1_rx() != '$');                 // wait for sentence start
        for (i = 0; i < 5; i++) buf[i] = uart1_rx();
        if (buf[2]!='G' || buf[3]!='G' || buf[4]!='A') continue;  // keep only xxGGA

        i = 0;                                     // read rest of line
        while ((c = uart1_rx()) != '\n' && i < 79) buf[i++] = c;
        buf[i] = '\0';

        field = 0; k = 0;                          // split on commas
        for (i = 0; buf[i] != '\0'; i++) {
            if (buf[i] == ',') { field++; k = 0; continue; }
            if (field == 2 && k < 14) { lat[k++] = buf[i]; lat[k] = '\0'; }
            if (field == 3) ns = buf[i];
            if (field == 4 && k < 14) { lon[k++] = buf[i]; lon[k] = '\0'; }
            if (field == 5) ew = buf[i];
        }
        if (field < 5 || lat[0] == '\0') { uart0_str("No fix yet\r\n"); continue; }

        uart0_str("Latitude : "); uart0_str(lat); uart0_tx(' '); uart0_tx(ns); uart0_str("\r\n");
        uart0_str("Longitude: "); uart0_str(lon); uart0_tx(' '); uart0_tx(ew); uart0_str("\r\n");
        lat[0] = lon[0] = '\0';
    }
}
