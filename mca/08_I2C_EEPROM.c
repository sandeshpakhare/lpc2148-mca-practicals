/* Practical 8: EEPROM (24C02/24C04) using I2C0
 * Pins: SCL0 = P0.2, SDA0 = P0.3 (4.7k pull-ups), EEPROM A0-A2 = GND
 * Address: 0xA0 write, 0xA1 read. 100 kHz: PCLK 15 MHz / (75 + 75)
 * Writes "LPC2148" at 0x00.. then reads it back to PC terminal (UART0, 9600)
 */
#include <lpc214x.h>

void delay_ms(unsigned int ms) { unsigned int i,j; for(i=0;i<ms;i++) for(j=0;j<2000;j++); }
void uart0_init(void) { PINSEL0 |= 0x05; U0LCR = 0x83; U0DLL = 98; U0DLM = 0; U0LCR = 0x03; }
void uart0_tx(char c) { while (!(U0LSR & 0x20)); U0THR = c; }

void i2c_init(void)
{
    PINSEL0 |= 0x00000050;      // P0.2 = SCL0, P0.3 = SDA0
    I2C0SCLH = 75;
    I2C0SCLL = 75;              // 100 kHz
    I2C0CONCLR = 0x6C;          // clear all flags
    I2C0CONSET = 0x40;          // I2EN: enable I2C
}
void i2c_start(void)            // START or repeated START
{
    I2C0CONSET = 0x20;          // STA
    I2C0CONCLR = 0x08;          // clear SI
    while (!(I2C0CONSET & 0x08));
}
void i2c_write(unsigned char d)
{
    I2C0DAT = d;
    I2C0CONCLR = 0x28;          // clear STA and SI -> send byte
    while (!(I2C0CONSET & 0x08));
}
unsigned char i2c_read_nack(void)
{
    I2C0CONCLR = 0x0C;          // AA = 0 (NACK last byte), clear SI
    while (!(I2C0CONSET & 0x08));
    return I2C0DAT;
}
void i2c_stop(void)
{
    I2C0CONSET = 0x10;          // STO
    I2C0CONCLR = 0x08;          // clear SI
}

void eeprom_write(unsigned char addr, unsigned char data)
{
    i2c_start();
    i2c_write(0xA0);            // device address + write
    i2c_write(addr);            // memory location
    i2c_write(data);
    i2c_stop();
    delay_ms(10);               // internal write cycle
}
unsigned char eeprom_read(unsigned char addr)
{
    unsigned char d;
    i2c_start();
    i2c_write(0xA0);
    i2c_write(addr);
    i2c_start();                // repeated START
    i2c_write(0xA1);            // device address + read
    d = i2c_read_nack();
    i2c_stop();
    return d;
}

int main(void)
{
    char msg[] = "LPC2148";
    unsigned char i;
    uart0_init();
    i2c_init();

    for (i = 0; msg[i] != '\0'; i++) eeprom_write(i, msg[i]);   // write at 0x00...
    for (i = 0; i < 7; i++) uart0_tx(eeprom_read(i));             // read back
    uart0_tx('\r'); uart0_tx('\n');
    while (1);
}
