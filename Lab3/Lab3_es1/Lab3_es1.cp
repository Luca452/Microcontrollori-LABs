#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab3/Lab3_es1/Lab3_es1.c"

int mio = 0;
int dly = 100;

void main() {
 short int sentinella=0;
 TRISB = 0b11000000;

 ANSELB = 0x3F;

 IOCB = 0b11000000;
 INTCON = 0b10101000;
#line 18 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab3/Lab3_es1/Lab3_es1.c"
 TRISD = 0x00;
 LATD = 0x01;

 T0CON = 0b11000111;
 TMR0L = 0b00000110;


 while(1){
 if(LATD == 0b10000000)
 sentinella = 1;
 else if(LATD == 0b00000001)
 sentinella = 0;
 if(mio > dly){
 if(!sentinella)
 LATD <<= 1;
 else{
 LATD >>= 1;}
 mio = 0;
 }
 }
}

void interrupt(){

 if(INTCON.RBIF){
 if(PORTB.RB7 && dly<1000){
 dly += 100;}
 else if(PORTB.RB6 && dly>50){
 dly -= 100;}

 INTCON.RBIF = 0;
 }

 if(INTCON.TMR0IF){
 mio +=32;
 INTCON.TMR0IF = 0;
 }
}
