#line 1 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab2/Lab2_es2/Lab2_es2.c"

int mio = 250;

void main() {
 short int sentinella=0;
 TRISB = 0b11000000;

 ANSELB = 0x3F;

 IOCB = 0b11000000;
 INTCON = 0b10001000;
#line 17 "C:/Users/daido/Desktop/Polimi/Anno3/Microcontrollori/Lab2/Lab2_es2/Lab2_es2.c"
 TRISD = 0x00;
 LATD = 0x01;


 while(1){
 if(LATD == 0b10000000)
 sentinella = 1;
 else if(LATD == 0b00000001)
 sentinella = 0;

 if(!sentinella)
 LATD = LATD << 1;
 else
 LATD = LATD >> 1;
 Vdelay_ms(mio);
 }
}

void interrupt(){

 if(INTCON.RBIF){
 if(PORTB.RB7 && mio<1000){
 mio += 100;}
 else if(PORTB.RB6 && mio>50){
 mio -= 100;}

 INTCON.RBIF = 0;
 }
}
