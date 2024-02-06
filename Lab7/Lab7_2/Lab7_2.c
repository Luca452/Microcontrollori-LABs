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

int tmr=0;
int tmr_old=0;
int edge=1;
char tmr_char[7]={0};

void main(){

    TRISC.RC6 = 0;
    LATC.RC6 = 1;

    //Devo accendere il buffer digitale di ingresso!!
    ANSELC.RC2 = 0;

    //TRISD = 0x00;
    //LATD = 32;

    //Capture ogni rising edge
    CCP1CON.CCP1M3 = 0;
    CCP1CON.CCP1M2 = 1;
    CCP1CON.CCP1M1 = 0;
    CCP1CON.CCP1M0 = 1;

    //Selezione timer 
    CCPTMRS0.C1TSEL1 = 0;
    CCPTMRS0.C1TSEL0 = 0;

    //Imposto TMR1 prescaler a 8, Fosc/8, 16bit timer
    T1CON = 0b00010011;

    //Attivo interrupt del CCP
    PIE1.CCP1IE = 1;
    PIR1.CCP1IF = 0;

    // Attivo l'interrupt delle periferiche
    INTCON.PEIE = 1;
    // Attivo l'interrupt globale
    INTCON.GIE = 1;

    // Inizializzo l'LCD
    Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
    Lcd_Cmd(_LCD_CLEAR);    	// Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
    Lcd_Out(1,1,"d[mm]:");

    while(1){
        if(!edge){
            IntToStr(tmr-tmr_old,tmr_char);
            Lcd_Out(1,11,tmr_char);
            //LATD++;
        }
    }
}

void interrupt(){
    if(PIR1.CCP1IF){
        PIR1.CCP1IF = 0;

        if(CCP1CON.CCP1M0)
        edge = 1;
        else
        edge = 0;

        CCP1CON.CCP1M0 = !CCP1CON.CCP1M0;
        tmr_old = tmr;
        tmr = (CCPR1H<<8) | CCPR1L; 
    }
}