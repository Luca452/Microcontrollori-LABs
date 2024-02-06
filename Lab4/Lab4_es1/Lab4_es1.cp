#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab4/Lab4_es1/Lab4_es1.c"


sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

int delay_ms_1=0;
int delay_ms_2=0;
int delay_us=0;

void main() {

short int sentinella = 0;
short int high = 0;
short int low = 0;
short int mask = 0b00001111;
unsigned short int count=0;
char count_txt[7];

TRISD = 0x00;
LATD = 0b10000001;

T0CON = 0b11000111;
INTCON = 0b10100000;

high = 0b00001000;
low = 0b00000001;


Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){

 if(delay_ms_1 >= 200){

 if( high == 0b1111 && low == 0b1111)
 sentinella = 1;
 else if ( high == 0b0000 && low == 0b0000)
 sentinella = 0;

 if(sentinella == 0){
 low <<= 1;
 high >>= 1;
 low += 0b00000001;
 high += 0b00001000;
 } else{
 high <<= 1;
 low >>= 1;
 high &= mask;
 low &= mask;
 }

 LATD = (high << 4) | low;
 delay_ms_1 -= 200;
 }

 if(delay_ms_2 >= 1000){
 count++;
 IntToStr(count,count_txt);
 Lcd_Out(1,11,count_txt);
 delay_ms_2 -= 1000;
 }

 }

}

void interrupt(){
if(INTCON.TMR0IF){
 INTCON.TMR0IF = 0;
 delay_ms_1 +=32;
 delay_ms_2 +=32;
 delay_us +=768;
 if (delay_us >= 1000)
 {
 delay_ms_1 +=1;
 delay_ms_2 +=1;
 delay_us = 0;
 }
}

}
