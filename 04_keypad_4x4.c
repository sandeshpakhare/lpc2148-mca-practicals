/* Practical 4: 4x4 matrix keypad, pressed key sent to PC terminal (UART0, 9600)
 * Pins: rows R0-R3 on P1.16 - P1.19 (output)
 *       cols C0-C3 on P1.20 - P1.23 (input, pull-ups on board)
 * Swap uart0_tx() for your LCD / 7-seg routine if the lab uses one.
 */
#include <lpc214x.h>
#define ROWS (0x0F << 16)     // P1.16 - P1.19

char keymap[16] = {'1','2','3','A',
                   '4','5','6','B',
                   '7','8','9','C',
                   '*','0','#','D'};

void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }

void uart0_init(void)          // 9600 baud, 8N1, PCLK = 15 MHz
{
    PINSEL0 |= 0x00000005;     // P0.0 = TXD0, P0.1 = RXD0
    U0LCR = 0x83;              // 8 bits, DLAB = 1
    U0DLL = 98;                // 15 MHz / (16 x 9600) = 97.6
    U0DLM = 0;
    U0LCR = 0x03;              // DLAB = 0
}
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }

char get_key(void)
{
    unsigned int r, c, cols;
    while (1) {
        for (r = 0; r < 4; r++) {
            IO1SET = ROWS;                 // all rows high
            IO1CLR = (1 << (16 + r));      // one row low
            delay_ms(1);
            cols = (IO1PIN >> 20) & 0x0F;  // read C0-C3
            if (cols != 0x0F) {            // some key pressed
                for (c = 0; c < 4; c++)
                    if (!(cols & (1 << c))) break;
                delay_ms(20);                                  // debounce
                while (((IO1PIN >> 20) & 0x0F) != 0x0F);       // wait for release
                return keymap[r * 4 + c];
            }
        }
    }
}

int main(void)
{
    PINSEL2 = 0x00000000;
    IO1DIR |= ROWS;                        // rows out
    IO1DIR &= ~(0x0F << 20);               // columns in
    uart0_init();
    while (1) uart0_tx(get_key());
}
