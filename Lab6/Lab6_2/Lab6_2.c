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

   
//------------------------ADC-------------------------------------------------
    // Imposto RA0 come output
    ANSELA.RA0 = 1;

    // Accendo il modulo ADC, seleziono in canale 0 e avvio la conversione
    ADCON0 = 0b00000011;

    // Seleziono il clk di conversione Fosc/8 e il tempo di conversione 8TAD e la giustificazione
    ADCON2 = 0b00100001;

    // Attivo l'interrupt delle periferiche
    PIE1 =0b01000000;
    //Abbasso i flag degli interrupt periferici
    PIR1 = 0b00000000;

    //Attivo gli interrupt
    INTCON = 0b11000000;

//------------------------PWM-------------------------------------------------
    // Imposto RE2 come output
    TRISE.RE2 = 0;
    TRISD = 0b00000000;

    //Selezione timer per PWM. Uso il TMR4
    CCPTMRS1 = 0b00000100;

    //seleziono step 1/256
    PR2=255;

    //Setto il modulo CCP in modalità PWM
    CCP5CON = 0b00001100;

    //Setto il prescaler del TMR2 a 16 e lo accendo
    T4CON = 0b00000111;

    //Inizializzo CCPR5L a 0
    CCPR5L = 0;



/*
// Imposto RA0 come input analogico, disattivo buffer digitale
    ANSELA.RA0 = 1;
    ANSELA.RA1 = 1;
    
    //seleziono il canale RA0
    ADCON0.CHS0 = 0;
    ADCON0.CHS1 = 0;
    ADCON0.CHS2 = 0;
    ADCON0.CHS3 = 0;
    ADCON0.CHS4 = 0;
    
    // Seleziono il clock dell'ADC, Fosc/8
    ADCON2.ADCS0 = 1;
    ADCON2.ADCS1 = 0;
    ADCON2.ADCS2 = 0;

    // Seleziono la velocità di acquisizione 8Tad
    ADCON2.ACQT0 = 0;
    ADCON2.ACQT1 = 0;
    ADCON2.ACQT2 = 1;
    //Giustificazione a sinistra
    ADCON2.ADFM = 0;
    
    //Accendo il modulo ADC
    ADCON0.ADON = 1;
    
    // Attivo l'interrupt e pongo a 0 il flag
    PIE1.ADIE = 1;
    PIR1.ADIF = 0;

    // Attivo l'interrupt delle periferiche (ADC è periferica)
    INTCON.PEIE = 1;

    // Attivo l'interrupt globale
    INTCON.GIE = 1;
*/


    
//------------------------LCD-------------------------------------------------
    Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
    Lcd_Cmd(_LCD_CLEAR);    	// Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
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