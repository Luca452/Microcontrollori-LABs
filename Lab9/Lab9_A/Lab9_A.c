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

    unsigned short int conteggio=0;
    unsigned short int stato_pb;
    char conteggio_txt[7]={0};

    // Attivo i buffer digitali in ingresso
    ANSELA=0b11110001;

    // Imposto TRISA come input
    TRISA = 0b11111111;

    // Inizializzo l'LCD
    Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
    Lcd_Cmd(_LCD_CLEAR);    	// Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
    Lcd_Out(1,1,conteggio_txt);

    while(1){
        
        // RA3 premuto, conteggio ++
        if((PORTA & ~stato_pb) & 0b00001000){
            conteggio++;
            stato_pb = stato_pb | 0b00001000;
            IntToStr(conteggio_txt,conteggio);
            Lcd_Out(1,1,conteggio_txt);
        }

        // RA1 premuto, conteggio --
        if((PORTA & ~stato_pb) & 0b00000010){
            conteggio--;
            stato_pb = stato_pb | 0b00000010;
            IntToStr(conteggio_txt,conteggio);
            Lcd_Out(1,1,conteggio_txt);
        }

        // RA2 premuto, azzero
        if((PORTA & ~stato_pb) & 0b00000100){
            conteggio = 0;
            stato_pb = stato_pb | 0b00000100;
            IntToStr(conteggio_txt,conteggio);
            Lcd_Out(1,1,conteggio_txt);
        }
        Lcd_Out(1,1, "prova");
        stato_pb = PORTA & stato_pb;
    }

}