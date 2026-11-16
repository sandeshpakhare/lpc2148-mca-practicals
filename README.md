# LPC2148 MCA Practicals

Keil uVision C programs for the Microcontrollers and Applications (MCA) lab on the LPC2148 (ARM7TDMI-S).

| File | Practical |
| --- | --- |
| `01_LED_counters.c` | LED flashing, binary / hex / BCD counters |
| `02_7segment_multiplexed.c` | Multiplexed 7-segment display, 0-9 and 00-99 |
| `03_DAC_waveforms.c` | Square and triangular waves using the DAC |
| `04_keypad_4x4.c` | 4x4 matrix keypad |
| `05a_ADC_polling.c` | Built-in ADC without interrupt |
| `05b_ADC_interrupt.c` | Built-in ADC with interrupt (VIC) |
| `06_GPS_UART.c` | GPS latitude and longitude via UART |
| `07_RTC_onchip.c` | On-chip RTC |
| `08_I2C_EEPROM.c` | EEPROM over I2C |

## Notes

- Clock assumed: 12 MHz crystal, CCLK 60 MHz, PCLK 15 MHz (Keil startup default). UART at 9600 baud uses `U0DLL = 98`.
- Pin numbers are common lab-kit defaults. Check the kit manual and change the `#define`s / PINSEL lines to match.
- Output is printed to a PC terminal over UART0. Swap in an LCD routine if the lab needs one.
- Build in Keil with "Create HEX File" enabled, then flash with Flash Magic (COM port, 9600 baud, 12000 kHz oscillator).
