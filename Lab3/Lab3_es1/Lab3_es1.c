// variabile globale, usarla solo se proprio necessario
int mio = 0;
int dly = 250;

// Per avere delay corretto, posso inizializzare TMR0L a 6 così da avere timer che conta 32ms esatti
// Il problema è che inizializzare il 6 fa perdere un colpo di clock

// Un'altra solzione è avere due variabili una che conta i ms una i us.
// nell'ISR faccio
/*
    delay_ms += 32;
    delay_us += 768;
    if(delay_us >= 1000){
        delay_ms += 1;
        delay_us = 0
    }
*/
void main() {
    short int sentinella=0;
    TRISB = 0b11000000;
    //ansel 0 se uso i pin come ingresso digitale
    ANSELB = 0x3F;

    IOCB = 0b11000000;
    INTCON = 0b10101000;
    /* Oppure 
    INTCON.RBIE=1;
    INTCON.RBIF=0;
    INTCON.GIE=1
    */
    TRISD = 0x00;
    LATD = 0x01;
    // inizializzo timer
    T0CON = 0b11000111;
    TMR0L = 0b00000110;

    while(1){   
        // metto tutto dentro l'if in modo che anche la verifica della direzione venga valutata solo se delay è passato
        if(mio > dly){
            if(LATD == 0b10000000)
                sentinella = 1;
            else if(LATD == 0b00000001)
                sentinella = 0; 

            if(!sentinella)
              LATD <<= 1;
            else
              LATD >>= 1;
            mio = 0;
        } 
    }
}

void interrupt(){
    //nel IOCB devo prima leggere il PORTB prima di settare il flag a 0
    if(INTCON.TMR0IF){
        // meglio azzerare subito per non perdersi ulteriori flag che possono arrivare mentre sono nell'ISR
        INTCON.TMR0IF = 0;
        mio +=32;
    } 
    //nel IOCB devo prima leggere il PORTB prima di settare il flag a 0
    //metto questa condizione nell'else if per efficienza. RBIF è meno frequente quindi 
    else if(INTCON.RBIF){
        if(PORTB.RB7 && dly<1000)
            dly += 50;
        else if(PORTB.RB6 && dly>50)
            dly -= 50;
        INTCON.RBIF = 0;
    }
}

// usare una variabile da 0 a 10 e poi moltiplicarla non vale la pena perchè la moltiplicazione usa 16bit


