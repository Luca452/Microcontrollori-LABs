#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab3/Lab3_es2/LAB3_es2.c"

int delay_ms = 0;
int delay_us = 0;
int delay_ms2 = 0;
int dly = 250;
short int count = 0;
char count_txt[7];

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

void main() {
 short int sentinella=0;
 TRISB = 0b11000000;
 ANSELB = 0x3F;

 IOCB = 0b11000000;
 INTCON = 0b10101000;

 TRISD = 0x00;
 LATD = 0x01;

 T0CON = 0b11000111;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){

 if(delay_ms >= dly){

 if(LATD == 0b10000000)
 sentinella = 1;
 else if(LATD == 0b00000001)
 sentinella = 0;

 if(!sentinella)
 LATD <<= 1;
 else
 LATD >>= 1;
 delay_ms -= dly ;

 }
 if (delay_ms2 >= dly)
 {
 count++;
 IntToStr(count,count_txt);
 Lcd_Out(1,11,count_txt);
 delay_ms2 -= dly;
 }
 }
}

void interrupt(){

 if(INTCON.TMR0IF){

 INTCON.TMR0IF = 0;
 delay_ms +=32;
 delay_ms2 +=32;
 delay_us +=768;
 if (delay_us >= 1000)
 {
 delay_ms +=1;
 delay_ms2 +=1;
 delay_us = 0;
 }
 }


 else if(INTCON.RBIF){
 if(PORTB.RB7 && dly<1000)
 dly += 50;
 else if(PORTB.RB6 && dly>50)
 dly -= 50;
 INTCON.RBIF = 0;
 }
}
