#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab1/Lab1_es3.c"
int divisore = 1;
int i=0;

void delay_mio(int divisore){
 for(i=0; i<1000/divisore; i++){
 delay_ms(1);
 }
}

void main(){
 TRISA = 0xFE;
 LATA.RA0 = '1';

 TRISD = 0xFF;
 ANSELD = 0x00;

 while(1){
 while(PORTD.RD0 == '1'){
 LATA.RA0 = '1';
 }
 if(PORTD.RD1 =='1'){
 divisore = 4;
 } else{ LATA.RA0 = '0';}
 if(PORTD.RD2 =='1'){
 divisore = 6;
 } else{ LATA.RA0 = '0';}
 if(PORTD.RD3 =='1'){
 divisore = 8;
 } else{ LATA.RA0 = '0';}
 if(PORTD.RD4 =='1'){
 divisore = 10;
 } else{ LATA.RA0 = '0';}
 if(PORTD.RD5 =='1'){
 divisore = 12;
 } else{ LATA.RA0 = '0';}
 LATA.RA0 = ~ LATA.RA0;
 delay_mio(divisore);

 }
}
