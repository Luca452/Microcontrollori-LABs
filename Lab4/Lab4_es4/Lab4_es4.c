// ~

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

int delay_ms_1=0;
int delay_ms_2=0;
int delay_us=0;
int delay_kitt = 200;
short int stop = 0;
short int reset = 0;


void main() {

short int sentinella = 0;
short int high = 0;
short int low = 0;
short int mask = 0b00001111;

char count_txt[7]={0};
char count_txt_prec[17]={0};
char reset_string[7]={'0',':','0',':','0',':','0'};
int i = 0;
int ora[4] = {0,0,0,0};


TRISD = 0x00;
LATD = 0b10000001;

TRISA = 0b00011111;
ANSELA = 0b11100000;

T0CON = 0b11000110;
INTCON = 0b10100000;

high = 0b00001000;
low  = 0b00000001;

// Inizializzo l'LCD
Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
Lcd_Cmd(_LCD_CLEAR);    	// Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF

    while(1){

        if(delay_ms_1 >= delay_kitt){
            if( high == 0b1111 && low == 0b1111)
                sentinella = 1; 
            else if ( high == 0b0000 &&  low == 0b0000)
                sentinella = 0;

            if(sentinella == 0){
                low  <<= 1;
                high >>= 1;
                low  += 0b00000001;
                high += 0b00001000;
            } else{
                high <<= 1;
                low  >>= 1;
                high &= mask;
                low &= mask;
            }
            LATD = (high << 4) | low;
            delay_ms_1 -= delay_kitt;
        }


        if(delay_ms_2 >= 8){

            if(!reset && !stop){
                ora[0] += delay_ms_2;
                if(ora[0] >= 1000){
                    ora[0] = 0;
                    ora[1] += 1;
                    if(ora[1] >= 60){
                        ora[1] = 0;
                        ora[2] += 1;
                        if(ora[2] >= 60){
                            ora[2] = 0;
                            ora[3] +=1;}
                        }
                }

                for (i = 3; i >= 0; i--){
                    IntToStr(ora[i],count_txt);
                    strcat(count_txt_prec,Ltrim(count_txt));
                    if(i!=0)
                    strcat(count_txt_prec,":");
                }
                Lcd_Out(1,9,count_txt_prec);
                for (i = 0; i < 17; i++)
                count_txt_prec[i]=0;
            }
            
            if(reset){
                for (i = 0; i < 4; i++)
                    ora[i] = 0;
                Lcd_Out(1,9,reset_string);
            }
            
            delay_ms_2 -= 8;
        }

    }

}

void interrupt(){

    if (PORTA.RA3 && delay_kitt<1000)
        delay_kitt +=20;
    else if (PORTA.RA4 && delay_kitt>20)
        delay_kitt -=20;

    if (PORTA.RA2){ //precedenza al reset
        stop = 0;
        reset = 1;}
    else if (PORTA.RA1){ //poi stop
        stop = 1;
        reset = 0;}
    else if (PORTA.RA0){ //infine start
        stop = 0;
        reset = 0;}
    

    if(INTCON.TMR0IF){
        INTCON.TMR0IF = 0;
        delay_ms_1 +=8;
        delay_ms_2 +=8;
        delay_us +=192;
            if (delay_us >= 1000)
            {
             delay_ms_1 +=1;
             delay_ms_2 +=1;
             delay_us = 0;
            }
    }

}