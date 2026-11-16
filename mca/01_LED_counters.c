/* Practical 1: LED interfacing - flashing, binary, hex and BCD counters
 * Board : LPC2148 (Keil uVision, #include <lpc214x.h>)
 * Pins  : 8 LEDs on P1.16 - P1.23, active high (if active low, swap SET/CLR)
 */
#include <lpc214x.h>
#define LED_MASK 0x00FF0000          // P1.16 - P1.23

void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }

void led_out(unsigned char val)      // put an 8-bit value on the LEDs
{
    IO1CLR = LED_MASK;
    IO1SET = ((unsigned int)val << 16);
}

int main(void)
{
    unsigned int n;
    PINSEL2 = 0x00000000;            // Port 1 as GPIO
    IO1DIR |= LED_MASK;              // LED pins as output

    while (1)
    {
        /* (a) Flashing: all ON / all OFF */
        for (n = 0; n < 5; n++) {
            IO1SET = LED_MASK; delay_ms(500);
            IO1CLR = LED_MASK; delay_ms(500);
        }

        /* (b) Binary counter 0 to 255 (00000000 to 11111111) */
        for (n = 0; n <= 255; n++) { led_out(n); delay_ms(200); }

        /* (c) Hex counter 0 to F (one hex digit on the lower 4 LEDs) */
        for (n = 0; n <= 0x0F; n++) { led_out(n); delay_ms(400); }

        /* (d) BCD counter 00 to 99: tens on upper nibble, units on lower */
        for (n = 0; n <= 99; n++) {
            led_out(((n / 10) << 4) | (n % 10));
            delay_ms(300);
        }
    }
}
