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

int adc_flag;
int adc;
char adc_char[7]={0};

void main() {
    
    // Imposto RC3 come input analogico, disattivo buffer digitale. AN15
    ANSELC.RC3 = 1;

    // Imposto RC6 a 1 per attivare il modulo a ultrasuoni
    TRISC.RC6 = 0;
    LATC.RC6 = 1;

    TRISD = 0x00;

    //seleziono il canale RC3
    ADCON0.CHS0 = 1;
    ADCON0.CHS1 = 1;
    ADCON0.CHS2 = 1;
    ADCON0.CHS3 = 1;
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
    Lcd_Out(1,1,"d[mm]:");

    // Faccio partire la conversione
    ADCON0.GO_NOT_DONE = 1;

    while (1)
    {

        if(adc_flag){
            adc_flag = 0;
            IntToStr(5*adc,adc_char);
            Lcd_Out(1,11,adc_char);

            // Avvio una nuova acquisizione
            ADCON0.GO_NOT_DONE = 1;  
        }
    }
}

void interrupt(){
    if(PIR1.ADIF){
        PIR1.ADIF = 0;
        adc = (ADRESH<<2)+(ADRESL>>6);
        adc_flag=1;
    }

}