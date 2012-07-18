/*
TV REMOTE CONTROLLED HIGH QUALITY MMC WAV PLAYER USING ATMEGA32
 
By Vinod S <vinodstanur@gmail.com> <http://blog.vinu.co.in>

Direct blog link:   http://blog.vinu.co.in/2012/02/tv-remote-controller-high-quality.html
First release Date: 25/02/2012
Last update Date:   02/03/2012 
       [improved maximum bitrate support to 1600kbps for stereo and 1300 for mono]
 
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
*/
 
#include<avr/io.h>
#define F_CPU 12000000
#include <util/delay.h>
#include <avr/interrupt.h>
#include <string.h>
 
#define SECONDS_TO_FORWARD 15
#define RS PD6
#define EN PD5
#define LCD_NIBBLE PORTC
#define LINE1 cmd(0x80)
#define LINE2 cmd(0xc0)
#define LEFT_SWITCH  PIND&(1<<2)
#define RIGHT_SWITCH PIND&(1<<3)
#define SWITCH_EVENT PIND&((1<<3)|(1<<2))
#define CS 4
#define RC5_LED PB0
 
unsigned char readdata;
unsigned int count;
unsigned long int arg = 0;
unsigned char mmc_buf[512];
unsigned char mmc_buf0[512];
unsigned char mmc_buf1[512];
unsigned int fat_start, dir_start, data_start;
unsigned char sect_per_clust;
volatile unsigned char BUF1_EMPTY, BUF0_EMPTY = 0;
unsigned long int OCR1A_BACKUP;
register int ISR_i asm("r2");
register char STEREO asm("r4");
register char TOGGLE_BUFFER asm("r5");
unsigned long int bitrate;
unsigned int RC5_DATA;
char RC5_FLAG;
unsigned int OCR1A_ADJUST;
unsigned int STARTING_CLUSTER;
 
void LCD_STROBE(void);
void data(unsigned char);
void cmd(unsigned char);
void clear(void);
void lcd_init();
void string(char *, char);
void spi_init();
void spi_write(char);
unsigned char spi_read();
void command(unsigned char, unsigned long int, unsigned char);
char mmc_init();
void mmc_read_sector(unsigned long int);
void fat16_init();
void print_num(unsigned long int, char);
unsigned int scan_root_dir(unsigned char *,char [], char);
void play_cluster(unsigned int);
unsigned int find_next_cluster(unsigned int);
void pwm_init();
void mmc_read_double_buffer(unsigned long int, unsigned char []);
void timer1_init();
char check_bitrate_and_stereo(unsigned int);
void INT2_init();
unsigned int forward_seconds(unsigned int);
void pull_up_enable();
void init_RC5_valid_indicator_LED();
int main()
{
    unsigned char fname[12];
    unsigned int cluster;
    char NEXT_OR_PREVIOUS = 1;
     
    _delay_ms(50);
    spi_init();
    lcd_init();
    pull_up_enable();
    while(mmc_init());
    pwm_init();
    fat16_init();
    timer1_init();
    INT2_init();
    init_RC5_valid_indicator_LED();
    while(1) {
        while((cluster = scan_root_dir("WAV", fname, NEXT_OR_PREVIOUS)) == 0) {
            NEXT_OR_PREVIOUS = 1;
        }
        NEXT_OR_PREVIOUS = 1;
        LINE1;
        clear();
        string(fname,1);
        if(!check_bitrate_and_stereo(cluster)) {
            TOGGLE_BUFFER = 0;
            BUF0_EMPTY = 1;
            ISR_i = 0;
            sei();
            while(cluster != 0xffff) {
                play_cluster(cluster);
                cluster = find_next_cluster(cluster);
                if(SWITCH_EVENT) {
                    if(RIGHT_SWITCH) {NEXT_OR_PREVIOUS = 1;break;};
                    if(LEFT_SWITCH) {NEXT_OR_PREVIOUS = 0; break;};
                }
                if(RC5_FLAG) {
                    RC5_FLAG = 0;
                    if(RC5_DATA == 32) {NEXT_OR_PREVIOUS = 1;break;};
                    if(RC5_DATA == 33) {NEXT_OR_PREVIOUS = 0;break;};
                    if(RC5_DATA == 1) {OCR1A = (OCR1A_ADJUST += OCR1A_BACKUP/20);};
                    if(RC5_DATA == 3) {OCR1A = (OCR1A_ADJUST -= OCR1A_BACKUP/20);};
                    if(RC5_DATA == 2) {OCR1A = (OCR1A_ADJUST = OCR1A_BACKUP);};
                    if(RC5_DATA == 6) {cluster = forward_seconds(cluster);}
                    if(RC5_DATA == 5) {cluster = STARTING_CLUSTER;}
                }
            }
            cli();
            clear();
            _delay_ms(100);
        }
    }
    return 0;
}
 
unsigned int forward_seconds(unsigned int cluster)
{
    cli();
    unsigned long int clusters_to_forward;
    clusters_to_forward = ((bitrate / 512) * SECONDS_TO_FORWARD) / sect_per_clust;
    while(clusters_to_forward) {
        cluster = find_next_cluster(cluster);
        if(cluster == 0xffff) break;
        clusters_to_forward--;
    }
    sei();
    return cluster;
}
void INT2_init()
{
    DDRB &= ~(1<<PB2);
    GICR   |=(1<<INT2);
    sei();
}
 
ISR (INT2_vect)
{
    char i = 0;
    //TIMSK &= ~(1 << OCIE1A);
    RC5_DATA = 0;
    OCR1A = ((double)F_CPU/1000000)*1778;
    _delay_us(350);
    TCNT1 = 0;
    for(i = 0; i < 13; i++) {
        while(!(TIFR & (1 << OCF1A)));
        TIFR |= 1<<OCF1A;
        RC5_DATA <<= 1;
        if(PINB & (1<<PB2)) {
            _delay_us(10);
            if(PINB & (1<<PB2)) {
                _delay_us(10);
                if(PINB & (1<<PB2)) {
                    RC5_DATA++;
                }
            }
        }
    }
    if((RC5_DATA & 0b1111101100000000) != 0b0000001100000000) {
        OCR1A = OCR1A_ADJUST;
        return;
    }
    PORTB |= (1<<RC5_LED);
    RC5_DATA &= 0b111111;
    RC5_FLAG = 1;
    OCR1A = OCR1A_ADJUST;
    TIMSK |= (1 << OCIE1A);
    _delay_ms(500);
    PORTB &= ~(1<<RC5_LED);
    GIFR |= (1<<INTF2);
}
 
char check_bitrate_and_stereo(unsigned int cluster)
{
    int i;
    mmc_read_sector(((unsigned long int)(cluster -2) * sect_per_clust) + data_start);
    if(mmc_buf[34] != 8) return 1;
    for (i = 31; i > 27; i--) {
        bitrate <<= 8;
        bitrate |= mmc_buf[i];
    }
    STEREO = mmc_buf[22] - 1;
    print_num(bitrate,2);
    OCR1A_BACKUP = ((F_CPU *(STEREO + 1))/bitrate);
    OCR1A = OCR1A_ADJUST = OCR1A_BACKUP;
    return 0;
}
 
unsigned int find_next_cluster(unsigned int cluster)
{
    static unsigned int cluster_index_in_buff;
    static unsigned int return_cluster;
    if((return_cluster + 1) == cluster) {
        if(cluster_index_in_buff+=2 < 512) {
            return_cluster += 1;
            return return_cluster;
            } else {
            cluster_index_in_buff-=2;
        }
    }
    cluster_index_in_buff = (2 * (cluster % 256));
    mmc_read_sector(fat_start + cluster/256);
    return_cluster = ((mmc_buf[cluster_index_in_buff + 1] << 8) + mmc_buf[cluster_index_in_buff]);
}
 
 
 
void mmc_read_double_buffer(unsigned long int sector, unsigned char a[])
{
    int i;
    sector *= 512;
    command(17, sector, 0xff);
    while (spi_read() != 0);
    while (spi_read() != 0xfe);
    for(i = 0; i < 512; i++)
    a[i] = spi_read();
    spi_write(0xff);
    spi_write(0xff);
}
 
void play_cluster(unsigned int cluster)
{
    unsigned long int sector;
    int i, j;
    sector = ((unsigned long int)(cluster -2) * sect_per_clust);
    sector += data_start;
    for(i = 0; i < sect_per_clust; i++) {
        while((!BUF1_EMPTY) && (!BUF0_EMPTY));
        if(BUF0_EMPTY) {
            mmc_read_double_buffer(sector, mmc_buf0);
            BUF0_EMPTY = 0;
            } else if(BUF1_EMPTY) {
        mmc_read_double_buffer(sector, mmc_buf1); BUF1_EMPTY = 0;}
        sector += 1;
    }
}
 
ISR (TIMER1_COMPA_vect)
{
    if(STEREO) {
        if(TOGGLE_BUFFER == 1) {
            OCR0 =  mmc_buf0[ISR_i++];
            OCR2 =  mmc_buf0[ISR_i++];
            }else{
            OCR0 =  mmc_buf1[ISR_i++];
            OCR2 = mmc_buf1[ISR_i++];
        }
        if(ISR_i == 512) {
            if(TOGGLE_BUFFER)
            BUF0_EMPTY = 1;
            else
            BUF1_EMPTY = 1;
            TOGGLE_BUFFER ^= 1;
            ISR_i = 0;
        }
        } else {
        if(TOGGLE_BUFFER == 1)
        OCR0 = OCR2 = mmc_buf0[ISR_i++];
        else
        OCR0 = OCR2 = mmc_buf1[ISR_i++];
        if(ISR_i == 512) {
            if(TOGGLE_BUFFER)
            BUF0_EMPTY = 1;
            else
            BUF1_EMPTY = 1;
            TOGGLE_BUFFER ^= 1;
            ISR_i = 0;
        }
    }
}
 
void timer1_init()
{
    TCCR1B |= (1 << WGM12)|(1 << CS10);
    TCNT1 = 0;
    OCR1A = 10000;
    TIMSK |= (1 << OCIE1A);
}
 
unsigned int scan_root_dir(unsigned char *FILE_EXTENSION, char FNAME[], char UP_DOWN)
{
    while(1) {
        unsigned int i;
        static unsigned char read_end = 0;
        static int base_count = -32, sect_plus = 0;
        if(UP_DOWN == 1) {
            base_count += 32;
            if(base_count == 512) {base_count = 0; sect_plus += 1;};
            } else {
            base_count -= 32;
            if(base_count == -32) {base_count = (512 - 32); sect_plus -= 1;}
            if(sect_plus < 0) {sect_plus = 0; base_count = 0;}
        }
        while(1) {
            mmc_read_sector(dir_start + sect_plus);
            while(base_count < 512) {
                if(mmc_buf[base_count] == 0) { read_end = 1; break;}
                if ((mmc_buf[1] != 0) && (mmc_buf[base_count + 2] != 0) && (mmc_buf[base_count] != 0xe5) && (mmc_buf[base_count] != 0x00) && ((mmc_buf[base_count + 11] & 0b00011110) == 0) && (strncmp(mmc_buf + base_count + 8, FILE_EXTENSION, 3) == 0)) {
                    for(i = 0; i < 11; i++)
                    FNAME[i] = mmc_buf[base_count + i];
                    FNAME[11] = 0;
                    return (STARTING_CLUSTER = (unsigned int)((mmc_buf[27 + base_count] << 8) + mmc_buf[26 + base_count]));
                }
                if(UP_DOWN) base_count += 32;
                else base_count -= 32;
            }
            base_count = 0;
            sect_plus++;
            if(read_end) { base_count = -32; sect_plus = 0; read_end = 0; return 0;}
        }
    }
}
 
void print_num(unsigned long int i, char line)
{
    char u = 0;
    unsigned char lcd_buf[16];
    if(line == 1) cmd(0x80);
    else cmd(0xc0);
    while(i) {
        lcd_buf[u++] = (i % 10 + '0');
        i /= 10;
    }
    while(u) data(lcd_buf[--u]);
}
 
void fat16_init()            //BOOT SECTOR SCANNING//
{
    mmc_read_sector(0);
    clear();
    LINE1;
    if((mmc_buf[0x36] == 'F') && (mmc_buf[0x39] == '1') && (mmc_buf[0x3a] == '6'))
    string("FAT16 DETECTED",1);
    else {
        string("NOT A FAT16",1);
        while(1);
    }
    _delay_ms(500);
    fat_start = mmc_buf[0x0e];
    dir_start = (fat_start + (((mmc_buf[0x17] << 8) + mmc_buf[0x16]) * 2));
    data_start = (dir_start + ((((mmc_buf[0x12] << 8) + (mmc_buf[0x11])) * 32) / 512));
    sect_per_clust = mmc_buf[0x0d];
}
 
void mmc_read_sector(unsigned long int sector)
{
    int i;
     
    sector *= 512;
    command(17, sector, 0xff);
    while (spi_read() != 0);
    while (spi_read() != 0xfe);
    for(i = 0; i < 512; i++)
    mmc_buf[i] = spi_read();
    spi_write(0xff);
    spi_write(0xff);
}
 
char mmc_init()
{
    int u = 0;
     
    PORTB |= 1<<CS;
    for (u = 0; u < 50; u++) {
        spi_write(0xff);
    }
    PORTB &= ~(1<<CS);
    _delay_ms(1);
    command(0, 0, 0x95);
    count = 0;
    while ((spi_read() != 1) && (count < 1000))
    count++;
    if (count >= 1000) {
        string("CARD ERROR-CMD0 ",1);
        _delay_ms(500);
        return 1;
    }
    command(1, 0, 0xff);
    count = 0;
    while ((spi_read() != 0) && (count < 1000)) {
        command(1, 0, 0xff);
        count++;
    }
    if (count >= 1000) {
        string("CARD ERROR-CMD1 ",1);
        _delay_ms(500);
        return 1;
    }
    command(16, 512, 0xff);
    count = 0;
    while ((spi_read() != 0) && (count < 1000))
    count++;
    if (count >= 1000) {
        string("CARD ERROR-CMD16",1);
        _delay_ms(500);
        return 1;
    }
    string("MMC INITIALIZED!",1);
    _delay_ms(500);
    SPCR &= ~(1<<SPR1); //increase SPI clock from f/32 to f/2
    return 0;
}
 
 
void command(unsigned char command, unsigned long int fourbyte_arg, unsigned char CRCbits)
{
    spi_write(0xff);
    spi_write(0b01000000 | command);
    spi_write((unsigned char) (fourbyte_arg >> 24));
    spi_write((unsigned char) (fourbyte_arg >> 16));
    spi_write((unsigned char) (fourbyte_arg >> 8));
    spi_write((unsigned char) fourbyte_arg);
    spi_write(CRCbits);
    spi_read();
}
 
unsigned char spi_read()
{
    SPDR = 0xff;
    while(!(SPSR & (1<<SPIF)));
    return SPDR;
}
 
void spi_write(char cData)
{
    SPDR = cData;
    while(!(SPSR & (1<<SPIF)));
}
 
void spi_init()
{
    DDRB |= (1<<5)|(1<<7)|(1<<4);
    SPCR = (1<<SPE)|(1<<MSTR)|(1<<CPOL)|(1<<CPHA)|(1<<SPR1);
    SPSR = 1;
}
 
void LCD_STROBE(void)
{
    PORTD |= (1 << EN);
    _delay_us(1);
    PORTD &= ~(1 << EN);
}
 
void data(unsigned char c)
{
    PORTD |= (1 << RS);
    _delay_us(50);
    LCD_NIBBLE = (c >> 4);
    LCD_STROBE();
    LCD_NIBBLE = (c);
    LCD_STROBE();
}
 
void cmd(unsigned char c)
{
    PORTD &= ~(1 << RS);
    _delay_us(50);
    LCD_NIBBLE = (c >> 4);
    LCD_STROBE();
    LCD_NIBBLE = (c);
    LCD_STROBE();
}
 
void clear(void)
{
    cmd(0x01);
    _delay_ms(5);
}
 
void lcd_init()
{
    DDRC = 0x0f;
    DDRD |= (1 << RS)|(1 << EN);
    _delay_ms(15);
    cmd(0x30);
    _delay_ms(1);
    cmd(0x30);
    _delay_us(100);
    cmd(0x30);
    cmd(0x28);
    cmd(0x28);
    cmd(0x0c);
    clear();
    cmd(0x6);
}
 
void string(char *p, char line)
{
    if(line == 1) LINE1;
    else LINE2;
    while(*p) data(*p++);
}
 
void pwm_init()
{
    TCCR0|=(1<<WGM00)|(1<<WGM01)|(1<<COM01)|(1<<CS00);
    TCCR2|=(1<<WGM20)|(1<<WGM21)|(1<<COM21)|(1<<CS20);
    DDRB|=(1<<PB3);
    DDRD|=(1<<PD7);
}
 
void pull_up_enable()
{
    PORTB |= (1<<PB2);
}
void init_RC5_valid_indicator_LED()
{
    DDRB |= (1<<RC5_LED);
}
