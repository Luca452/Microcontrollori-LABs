#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab6/Lab6_2/Lab6_2.c"
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

int adc;
int adc_flag = 0;
char adc_char[7]= {0};

void main() {




 ANSELA.RA0 = 1;


 ADCON0 = 0b00000011;


 ADCON2 = 0b00100001;


 PIE1 =0b01000000;

 PIR1 = 0b00000000;


 INTCON = 0b11000000;



 TRISE.RE2 = 0;
 TRISD = 0b00000000;


 CCPTMRS1 = 0b00000100;


 PR2=255;


 CCP5CON = 0b00001100;


 T4CON = 0b00000111;


 CCPR5L = 0;
#line 103 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab6/Lab6_2/Lab6_2.c"
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"RA0[mV]:");

 while(1){

 if(adc_flag){
 adc_flag = 0;
 CCPR5L = adc>>2;
 IntToStr(5*adc, adc_char);
 Lcd_Out(1,11,adc_char);
 ADCON0.GO_NOT_DONE = 1;
 }

 }
}

void interrupt(){
 if(PIR1.ADIF){
 adc = (ADRESH<<2)+(ADRESL>>6);
 adc_flag = 1;
 PIR1.ADIF = 0;
 }
}
