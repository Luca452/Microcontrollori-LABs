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

short int adc_tensione;
short int adc_sonar;
unsigned short int adc_flag=0;

void main() {

    unsigned short int conteggio=0;
    unsigned short int stato_pb;
    char conteggio_txt[7]={0};
    char adc_txt[7]={0};

    // Attivo/disattivo i buffer digitali in ingresso 
    ANSELA=0b11110001;

    // Imposto TRISA come input
    TRISA.RA1 = 1;
    TRISA.RA2 = 1;
    TRISA.RA3 = 1;

    // Imposto RE3 come output
    TRISE.RE2 = 0;


    //Selezione timer per PWM. Uso il TMR6
    CCPTMRS1 = 0b00001000;

    //seleziono step 1/256
    PR2=255;

    //Setto il modulo CCP in modalità PWM
    CCP5CON = 0b00001100;

    //Setto il prescaler del TMR6 a 16 e lo accendo
    T6CON = 0b00000111;

    //Inizializzo CCPR5L a 0
    CCPR5L = 0;

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

    // Inizializzo l'LCD
    Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
    Lcd_Cmd(_LCD_CLEAR);    	// Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
    Lcd_Out(1,1,"conteggio:");
    Lcd_Out(2,1,"tensione:");

    while(1){
        
        // RA3 premuto, conteggio ++
        if((PORTA & ~stato_pb) & 0b00001000){
            conteggio++;
            stato_pb = stato_pb | 0b00001000;
            IntToStr(conteggio,conteggio_txt);
            Lcd_Out(1,11,conteggio_txt);
        }

        // RA1 premuto, conteggio --
        if((PORTA & ~stato_pb) & 0b00000010){
            conteggio--;
            stato_pb = stato_pb | 0b00000010;
            IntToStr(conteggio,conteggio_txt);
            Lcd_Out(1,11,conteggio_txt);
        }

        // RA2 premuto, azzero
        if((PORTA & ~stato_pb) & 0b00000100){
            conteggio = 0;
            stato_pb = stato_pb | 0b00000100;
            IntToStr(conteggio,conteggio_txt);
            Lcd_Out(1,11,conteggio_txt);
        }
        stato_pb = PORTA & stato_pb;

        if(adc_flag){
            adc_flag = 0;
            IntToStr(adc_tensione*5,adc_txt);
            Lcd_Out(2,11,adc_txt);

            CCPR5L = adc_sonar;

            ADCON0.CHS0 = !ADCON0.CHS0;
            ADCON0.CHS1 = !ADCON0.CHS1;
            ADCON0.CHS2 = !ADCON0.CHS2;
            ADCON0.CHS3 = !ADCON0.CHS3;
        }

    }

}

void interrupt(){
    if(PIR1.ADIF){
        PIR1.ADIF = 0;
        
        if(ADCON0.CHS0)
        adc_sonar = ADRESL;
        else
        adc_tensione = (ADRESH<<2) | (ADRESL>>6);

        adc_flag = 1;
    }

}