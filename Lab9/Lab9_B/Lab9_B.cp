#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab9/Lab9_B/Lab9_B.c"
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

short int adc;
unsigned short int adc_flag=0;

void main() {

 unsigned short int conteggio=0;
 unsigned short int stato_pb;
 char conteggio_txt[7]={0};
 char adc_txt[7]={0};


 ANSELA=0b11110001;


 TRISA.RA1 = 1;
 TRISA.RA2 = 1;
 TRISA.RA3 = 1;

 TRISD = 0b00000000;


 ADCON0.CHS0 = 0;
 ADCON0.CHS1 = 0;
 ADCON0.CHS2 = 0;
 ADCON0.CHS3 = 0;
 ADCON0.CHS4 = 0;


 ADCON2.ADCS0 = 1;
 ADCON2.ADCS1 = 0;
 ADCON2.ADCS2 = 0;


 ADCON2.ACQT0 = 0;
 ADCON2.ACQT1 = 0;
 ADCON2.ACQT2 = 1;

 ADCON2.ADFM = 0;


 ADCON0.ADON = 1;


 PIE1.ADIE = 1;
 PIR1.ADIF = 0;

 INTCON.PEIE = 1;

 INTCON.GIE = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"conteggio:");
 Lcd_Out(2,1,"tensione:");

 while(1){


 if((PORTA & ~stato_pb) & 0b00001000){
 conteggio++;
 stato_pb = stato_pb | 0b00001000;
 IntToStr(conteggio,conteggio_txt);
 Lcd_Out(1,11,conteggio_txt);
 }


 if((PORTA & ~stato_pb) & 0b00000010){
 conteggio--;
 stato_pb = stato_pb | 0b00000010;
 IntToStr(conteggio,conteggio_txt);
 Lcd_Out(1,11,conteggio_txt);
 }


 if((PORTA & ~stato_pb) & 0b00000100){
 conteggio = 0;
 stato_pb = stato_pb | 0b00000100;
 IntToStr(conteggio,conteggio_txt);
 Lcd_Out(1,11,conteggio_txt);
 }
 stato_pb = PORTA & stato_pb;

 if(adc_flag){
 adc_flag = 0;
 IntToStr(adc*5,adc_txt);
 Lcd_Out(2,11,adc_txt);
 }

 }

}

void interrupt(){
 if(PIR1.ADIF){
 PIR1.ADIF = 0;
 adc = (ADRESH<<2) | (ADRESL>>6);
 adc_flag = 1;
 LATD++;
 }

}
