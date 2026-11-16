/* Practical 5(a): Built-in ADC WITHOUT interrupt (polling)
 * Pot on AD0.1 = P0.28, value 0-1023 printed on PC terminal (UART0, 9600)
 * Voltage = value x 3.3 / 1023
 */
#include <lpc214x.h>

void uart0_init(void) { PINSEL0 |= 0x05; U0LCR = 0x83; U0DLL = 98; U0DLM = 0; U0LCR = 0x03; }
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }
void print_num(unsigned int n)     // prints 0-9999 + new line
{
    uart0_tx('0' + (n/1000)%10); uart0_tx('0' + (n/100)%10);
    uart0_tx('0' + (n/10)%10);   uart0_tx('0' + n%10);
    uart0_tx('\r'); uart0_tx('\n');
}
void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }

int main(void)
{
    unsigned int val;
    uart0_init();
    PINSEL1 &= ~(3 << 24);
    PINSEL1 |=  (1 << 24);                          // P0.28 = AD0.1

    while (1) {
        AD0CR = (1 << 1) | (3 << 8) | (1 << 21) | (1 << 24);  // select CH1, CLKDIV=3, PDN=1, start
        while (!(AD0GDR & 0x80000000));             // wait for DONE
        val = (AD0GDR >> 6) & 0x3FF;                // 10-bit result
        print_num(val);                             // 0 to 1023
        delay_ms(300);
    }
}
