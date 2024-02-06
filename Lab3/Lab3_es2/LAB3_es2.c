// variabile globale, usarla solo se proprio necessario
int delay_ms = 0;
int delay_us = 0;
int delay_ms2 = 0;
int dly = 250;
int count = 0;
char count_txt[7];

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

void main() {
    short int sentinella=0;
    TRISB = 0b11000000;
    ANSELB = 0x3F;

    IOCB = 0b11000000;
    INTCON = 0b10101000;

    TRISD = 0x00;
    LATD = 0x01;
    // inizializzo timer
    T0CON = 0b11000111;

    // Inizializzo l'LCD
    Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
    Lcd_Cmd(_LCD_CLEAR);    	// Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF

    while(1){   
        // metto tutto dentro l'if in modo che anche la verifica della direzione venga valutata solo se delay è passato
        if(delay_ms >= dly){

            if(LATD == 0b10000000)
                sentinella = 1;
            else if(LATD == 0b00000001)
                sentinella = 0; 

            if(!sentinella)
              LATD <<= 1;
            else
              LATD >>= 1;
            delay_ms -= dly ;
        
        } 
        if (delay_ms2 >= 1000)
        {
            count++;
            IntToStr(count,count_txt);
            Lcd_Out(1,11,count_txt);
            delay_ms2 -= 1000;
        }
    }
}

void interrupt(){
    //nel IOCB devo prima leggere il PORTB prima di settare il flag a 0
    if(INTCON.TMR0IF){
        // meglio azzerare subito per non perdersi ulteriori flag che possono arrivare mentre sono nell'ISR
        INTCON.TMR0IF = 0;
        delay_ms +=32;
        delay_ms2 +=32;
        delay_us +=768;
        if (delay_us >= 1000)
        {
            delay_ms +=1;
            delay_ms2 +=1;
            delay_us = 0;
        }
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
