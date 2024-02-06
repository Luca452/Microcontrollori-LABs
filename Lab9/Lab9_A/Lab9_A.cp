#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab9/Lab9_A/Lab9_A.c"
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

 unsigned short int conteggio=0;
 unsigned short int stato_pb;
 char conteggio_txt[7]={0};


 ANSELA=0b11110001;


 TRISA = 0b11111111;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,conteggio_txt);

 while(1){


 if((PORTA & ~stato_pb) & 0b00001000){
 conteggio++;
 stato_pb = stato_pb | 0b00001000;
 IntToStr(conteggio_txt,conteggio);
 Lcd_Out(1,1,conteggio_txt);
 }


 if((PORTA & ~stato_pb) & 0b00000010){
 conteggio--;
 stato_pb = stato_pb | 0b00000010;
 IntToStr(conteggio_txt,conteggio);
 Lcd_Out(1,1,conteggio_txt);
 }


 if((PORTA & ~stato_pb) & 0b00000100){
 conteggio = 0;
 stato_pb = stato_pb | 0b00000100;
 IntToStr(conteggio_txt,conteggio);
 Lcd_Out(1,1,conteggio_txt);
 }
 Lcd_Out(1,1, "ciao");
 stato_pb = PORTA & stato_pb;
 }

}
