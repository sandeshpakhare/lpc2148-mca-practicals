/* Practical 5(b): Built-in ADC WITH interrupt (VIC channel 18 = ADC0)
 * Pot on AD0.1 = P0.28, value 0-1023 printed on PC terminal (UART0, 9600)
 */
#include <lpc214x.h>

void uart0_init(void) { PINSEL0 |= 0x05; U0LCR = 0x83; U0DLL = 98; U0DLM = 0; U0LCR = 0x03; }
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }
void print_num(unsigned int n)
{
    uart0_tx('0' + (n/1000)%10); uart0_tx('0' + (n/100)%10);
    uart0_tx('0' + (n/10)%10);   uart0_tx('0' + n%10);
    uart0_tx('\r'); uart0_tx('\n');
}
void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }

volatile unsigned int adc_val, adc_done = 0;

void ADC0_ISR(void) __irq
{
    adc_val = (AD0GDR >> 6) & 0x3FF;   // reading AD0GDR clears the interrupt
    adc_done = 1;
    VICVectAddr = 0x00;                // signal end of interrupt to VIC
}

int main(void)
{
    uart0_init();
    PINSEL1 &= ~(3 << 24);
    PINSEL1 |=  (1 << 24);                     // P0.28 = AD0.1

    VICIntSelect &= ~(1 << 18);                // ADC0 as IRQ (not FIQ)
    VICVectAddr0  = (unsigned int)ADC0_ISR;    // ISR address
    VICVectCntl0  = 0x20 | 18;                 // slot enabled, source 18
    VICIntEnable  = (1 << 18);                 // enable ADC0 interrupt
    AD0INTEN = (1 << 8);                       // global DONE flag raises interrupt

    while (1) {
        adc_done = 0;
        AD0CR = (1 << 1) | (3 << 8) | (1 << 21) | (1 << 24);  // start
        while (!adc_done);                     // CPU is free to do other work here
        print_num(adc_val);
        delay_ms(300);
    }
}
