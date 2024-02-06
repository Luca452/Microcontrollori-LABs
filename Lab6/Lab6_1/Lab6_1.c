void main() {
    // imposto RE2 come output
    TRISE.RE2 = 0;
    TRISD = 0b00000000;

    //Selezione timer per PWM
    CCPTMRS1.C5TSEL1 = 0;
    CCPTMRS1.C5TSEL0 = 0;

    //seleziono step 1/256
    PR2=255;

    //Setto il modulo CCP in modalità PWM
    CCP5CON = 0b00001100;

    //Setto il prescaler del TMR2 a 16 e lo accendo
    T2CON = 0b00000111;

    //Inizializzo CCPR5L a 0
    CCPR5L = 0;

    while(1){
        CCPR5L++;
        LATD = CCPR5L;
        Delay_ms(10);
    }

}