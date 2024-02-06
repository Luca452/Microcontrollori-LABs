#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab6/Lab6_1/Lab6_1.c"






void main() {

 TRISE.RE2 = 0;
 TRISD = 0b00000000;


 CCPTMRS1.C5TSEL1 = 0;
 CCPTMRS1.C5TSEL0 = 0;


 PR2=255;


 CCP5CON = 0b00001100;


 T2CON = 0b00000111;


 CCPR5L = 0;

 while(1){
 CCPR5L++;
 LATD = CCPR5L;
 Delay_ms(10);
 }

}
