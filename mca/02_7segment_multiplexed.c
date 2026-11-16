/* Practical 2: Multiplexed 7-segment display - count 0-9 and 00-99
 * Pins : segments a-g, dp on P0.16 - P0.23
 *        digit enable: units = P0.28, tens = P0.29 (active high via transistors)
 * Display: common cathode (for common anode use the complemented codes)
 *   CC: 3F 06 5B 4F 66 6D 7D 07 7F 6F
 *   CA: C0 F9 A4 B0 99 92 82 F8 80 90
 */
#include <lpc214x.h>
#define SEG_MASK  0x00FF0000      // P0.16 - P0.23
#define DIG_UNITS (1 << 28)
#define DIG_TENS  (1 << 29)

unsigned char seg[10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};

void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }

void show_digit(unsigned char d, unsigned int digit_pin)
{
    IO0CLR = SEG_MASK | DIG_UNITS | DIG_TENS;   // blank everything first
    IO0SET = ((unsigned int)seg[d] << 16);      // put segment pattern
    IO0SET = digit_pin;                         // enable one digit
    delay_ms(5);
}

int main(void)
{
    unsigned int n, t;
    PINSEL1 = 0x00000000;                        // P0.16-P0.31 as GPIO
    IO0DIR |= SEG_MASK | DIG_UNITS | DIG_TENS;

    /* (a) Single digit 0 to 9 */
    for (n = 0; n <= 9; n++)
        for (t = 0; t < 100; t++) show_digit(n, DIG_UNITS);   // ~0.5 s each

    /* (b) Two digits 00 to 99 */
    while (1)
        for (n = 0; n <= 99; n++)
            for (t = 0; t < 50; t++) {          // 50 x 10 ms = ~0.5 s per count
                show_digit(n / 10, DIG_TENS);
                show_digit(n % 10, DIG_UNITS);
            }
}
