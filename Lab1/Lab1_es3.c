int divisore = 1;
int i=0;

void delay_mio(int divisore){
    for(i=0; i<1000/divisore; i++){
        delay_ms(1);
    }
}

void main(){
    TRISA = 0xFE;
    LATA.RA0 = '1'; 

    TRISD = 0x1F;
    ANSELD = 0xE0;
    
    while(1){
        if(PORTD.RD0 == '1'){
            LATA.RA0 = '1';
        }  
        else { divisore = 1;}
        if(PORTD.RD0 == '1'){
            divisore = 2;
            LATA.RA0 = '1';
        } 
        else if(PORTD.RD1 == '1'){
            divisore = 4;
            LATA.RA0 = '1';
        } 
        else if(PORTD.RD2 == '1'){
            divisore = 6;
            LATA.RA0 = '1';
        } 
        else if(PORTD.RD3 == '1'){
            divisore = 8;
            LATA.RA0 = '1';
        } 
        else if(PORTD.RD4 == '1'){
            divisore = 10;
            LATA.RA0 = '1';
        } 
        else if(PORTD.RD5 == '1'){
            divisore = 12;
            LATA.RA0 = '1';
        }  

        if(divisore != 0){
            LATA.RA0 = '0'; 
        }
         
    }
}