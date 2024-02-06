#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab1/Lab1.c"
void main() {
 TRISA = 0xFE;
 LATA.RA0 = '1';

 TRISD = 0x01;
 ANSELD = 0xFE;

 while(1){
 if(PORTD.RD0 == '0'){
 LATA.RA0 = '0';
 }
 else{
 LATA.RA0 = ~ LATA.RA0;
 delay_ms(250);
 }
 }
}
