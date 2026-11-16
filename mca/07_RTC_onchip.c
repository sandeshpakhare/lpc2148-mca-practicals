/* Practical 7: On-chip RTC - set time/date and display every second (UART0, 9600)
 * Clock source: 32.768 kHz crystal (CCR = 0x11).
 * If time does not advance (no 32 kHz crystal on kit), use PCLK instead:
 *   PREINT = 456; PREFRAC = 25024;  (for PCLK = 15 MHz)  and CCR = 0x01;
 */
#include <lpc214x.h>

void uart0_init(void) { PINSEL0 |= 0x05; U0LCR = 0x83; U0DLL = 98; U0DLM = 0; U0LCR = 0x03; }
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }
void print2(unsigned int n) { uart0_tx('0' + n/10); uart0_tx('0' + n%10); }

int main(void)
{
    unsigned int last = 60;
    uart0_init();

    CCR   = 0x02;            // reset clock tick counter, RTC stopped
    HOUR  = 10;  MIN = 30;  SEC = 0;      // set time 10:30:00
    DOM   = 17;  MONTH = 11; YEAR = 2026; // set date 17/11/2026
    DOW   = 2;                            // Tuesday (0 = Sunday)
    CCR   = 0x11;            // CLKSRC = 32.768 kHz crystal, CLKEN = 1 (start)

    while (1) {
        if (SEC != last) {   // print once per second
            last = SEC;
            print2(HOUR); uart0_tx(':'); print2(MIN); uart0_tx(':'); print2(SEC);
            uart0_tx(' ');
            print2(DOM); uart0_tx('/'); print2(MONTH); uart0_tx('/');
            print2(YEAR / 100); print2(YEAR % 100);
            uart0_tx('\r'); uart0_tx('\n');
        }
    }
}
