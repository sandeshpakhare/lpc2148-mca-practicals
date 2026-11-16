# MCA (LPC2148) and VLSI (Verilog) Practicals

## VLSI — Verilog design + testbench (`vlsi/`)

Each practical has a design file and a `_tb.v` testbench. All were simulated and verified with Icarus Verilog.

| Practical | Design | Testbench |
| --- | --- | --- |
| 1. 4:1 Multiplexer | `01_mux4to1.v` | `01_mux4to1_tb.v` |
| 2. Full adder using two half adders | `02_full_adder_using_ha.v` | `02_full_adder_using_ha_tb.v` |
| 3. 4-bit ALU | `03_alu_4bit.v` | `03_alu_4bit_tb.v` |
| 4. Binary to Gray converter | `04_binary_to_gray.v` | `04_binary_to_gray_tb.v` |
| 5. JK and T flip-flops | `05_jk_t_flipflop.v` | `05_jk_t_flipflop_tb.v` |
| 6. 3-bit sync up/down counter | `06_updown_counter_3bit.v` | `06_updown_counter_3bit_tb.v` |
| 7. SISO shift register | `07_siso_shift_register.v` | `07_siso_shift_register_tb.v` |

In Vivado / ISE / ModelSim: add the design file as a design source and the `_tb.v` file as a simulation source, set the testbench as top, then run behavioral simulation.

## MCA — LPC2148 Keil C (`mca/`)

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

Notes: 12 MHz crystal, CCLK 60 MHz, PCLK 15 MHz assumed; UART 9600 baud uses `U0DLL = 98`. Pin numbers are common lab-kit defaults — match them to your kit. Output prints to a PC terminal over UART0. Build with "Create HEX File" enabled and flash with Flash Magic.
