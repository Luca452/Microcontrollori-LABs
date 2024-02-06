short int sentinella=0;

void main() {
    TRISD = 0x00;
    //ANSELD = 0xFF;
    LATD = 0x01;
    while(1){
        if(LATD == 0b10000000){ 
            sentinella = 1;
            }
        else if(LATD == 0b00000001){
            sentinella = 0;
            }
        if(sentinella == 0){
            LATD = LATD << 1;
        }
        else if(sentinella == 1){
            LATD = LATD >> 1;
         }
         delay_ms(250);
    }
}