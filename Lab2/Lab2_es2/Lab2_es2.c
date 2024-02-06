// variabile globale, usarla solo se proprio necessario
int mio = 250;

void main() {
    short int sentinella=0;
    TRISB = 0b11000000;
    //ansel 0 se uso i pin come ingresso digitale
    ANSELB = 0x3F;

    IOCB = 0b11000000;
    INTCON = 0b10001000;
    /* Oppure 
    INTCON.RBIE=1;
    INTCON.RBIF=0;
    INTCON.GIE=1
    */
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
    //nel IOCB devo prima leggere il PORTB prima di settare il flag a 0
    if(INTCON.RBIF){
        if(PORTB.RB7 && mio<1000){
            mio += 100;}
        else if(PORTB.RB6 && mio>50){
            mio -= 100;}

            INTCON.RBIF = 0;
    }
}

// usare una variabile da 0 a 10 e poi moltiplicarla non vale la pena perchè la moltiplicazione usa 16bit
