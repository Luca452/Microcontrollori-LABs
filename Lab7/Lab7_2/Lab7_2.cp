#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab7/Lab7_2/Lab7_2.c"
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

int tmr=0;
int tmr_old=0;
int edge=1;
char tmr_char[7]={0};

void main(){

 TRISC.RC6 = 0;
 LATC.RC6 = 1;


 ANSELC.RC2 = 0;







 CCP1CON.CCP1M3 = 0;
 CCP1CON.CCP1M2 = 1;
 CCP1CON.CCP1M1 = 0;
 CCP1CON.CCP1M0 = 1;


 CCPTMRS0.C1TSEL1 = 0;
 CCPTMRS0.C1TSEL0 = 0;


 T1CON = 0b00010011;


 PIE1.CCP1IE = 1;
 PIR1.CCP1IF = 0;


 INTCON.PEIE = 1;

 INTCON.GIE = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"d[mm]:");

 while(1){
 if(!edge){
 IntToStr(tmr-tmr_old,tmr_char);
 Lcd_Out(1,11,tmr_char);

 }
 }
}

void interrupt(){
 if(PIR1.CCP1IF){
 LATD++;
 PIR1.CCP1IF = 0;

 if(CCP1CON.CCP1M0)
 edge = 1;
 else
 edge = 0;

 CCP1CON.CCP1M0 = !CCP1CON.CCP1M0;
 tmr_old = tmr;
 tmr = (CCPR1H<<8) | CCPR1L;
 }
}
