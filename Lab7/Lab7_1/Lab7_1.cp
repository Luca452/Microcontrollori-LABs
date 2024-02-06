#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab7/Lab7_1/Lab7_1.c"
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

int adc_flag;
int adc;
char adc_char[7]={0};

void main() {


 ANSELC.RC3 = 1;


 TRISC.RC6 = 0;
 LATC.RC6 = 1;

 TRISD = 0x00;


 ADCON0.CHS0 = 1;
 ADCON0.CHS1 = 1;
 ADCON0.CHS2 = 1;
 ADCON0.CHS3 = 1;
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
 Lcd_Out(1,1,"d[mm]:");


 ADCON0.GO_NOT_DONE = 1;

 while (1)
 {

 if(adc_flag){
 adc_flag = 0;
 IntToStr(5*adc,adc_char);
 Lcd_Out(1,11,adc_char);


 ADCON0.GO_NOT_DONE = 1;
 }
 }
}

void interrupt(){
 if(PIR1.ADIF){
 PIR1.ADIF = 0;
 adc = (ADRESH<<2)+(ADRESL>>6);
 adc_flag=1;
 }

}
