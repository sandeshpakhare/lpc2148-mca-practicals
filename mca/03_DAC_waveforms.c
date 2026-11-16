/* Practical 3: Waveform generation using on-chip 10-bit DAC
 * Output: AOUT = P0.25 (view on CRO)
 * Vout = VALUE x VREF / 1024, VALUE in DACR bits 15:6
 * Keep only the waveform asked for inside while(1) during the exam.
 */
#include <lpc214x.h>

void delay_us(unsigned int us) { unsigned int i,j; for(i=0;i<us;i++) for(j=0;j<2;j++); }

int main(void)
{
    unsigned int v, k;
    PINSEL1 &= ~(3 << 18);
    PINSEL1 |=  (2 << 18);          // P0.25 = AOUT (DAC output)

    while (1)
    {
        /* (a) Square wave: high and low alternately */
        for (k = 0; k < 200; k++) {
            DACR = (1023 << 6);     // max, ~3.3 V
            delay_us(500);
            DACR = (0 << 6);        // min, 0 V
            delay_us(500);
        }

        /* (b) Triangular wave: ramp up then ramp down */
        for (k = 0; k < 50; k++) {
            for (v = 0; v < 1023; v++)  DACR = (v << 6);   // rising edge
            for (v = 1023; v > 0; v--)  DACR = (v << 6);   // falling edge
        }
    }
}
