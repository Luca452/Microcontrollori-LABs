
_main:

;Lab3_es1.c,5 :: 		void main() {
;Lab3_es1.c,6 :: 		short int sentinella=0;
	CLRF        main_sentinella_L0+0 
;Lab3_es1.c,7 :: 		TRISB = 0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;Lab3_es1.c,9 :: 		ANSELB = 0x3F;
	MOVLW       63
	MOVWF       ANSELB+0 
;Lab3_es1.c,11 :: 		IOCB = 0b11000000;
	MOVLW       192
	MOVWF       IOCB+0 
;Lab3_es1.c,12 :: 		INTCON = 0b10101000;
	MOVLW       168
	MOVWF       INTCON+0 
;Lab3_es1.c,18 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab3_es1.c,19 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;Lab3_es1.c,21 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;Lab3_es1.c,22 :: 		TMR0L = 0b00000110;
	MOVLW       6
	MOVWF       TMR0L+0 
;Lab3_es1.c,25 :: 		while(1){
L_main0:
;Lab3_es1.c,26 :: 		if(LATD == 0b10000000)
	MOVF        LATD+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;Lab3_es1.c,27 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main3
L_main2:
;Lab3_es1.c,28 :: 		else if(LATD == 0b00000001)
	MOVF        LATD+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;Lab3_es1.c,29 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main4:
L_main3:
;Lab3_es1.c,30 :: 		if(mio > dly){
	MOVLW       128
	XORWF       _dly+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _mio+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVF        _mio+0, 0 
	SUBWF       _dly+0, 0 
L__main20:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;Lab3_es1.c,31 :: 		if(!sentinella)
	MOVF        main_sentinella_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;Lab3_es1.c,32 :: 		LATD <<= 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
	GOTO        L_main7
L_main6:
;Lab3_es1.c,34 :: 		LATD >>= 1;}
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
L_main7:
;Lab3_es1.c,35 :: 		mio = 0;
	CLRF        _mio+0 
	CLRF        _mio+1 
;Lab3_es1.c,36 :: 		}
L_main5:
;Lab3_es1.c,37 :: 		}
	GOTO        L_main0
;Lab3_es1.c,38 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab3_es1.c,40 :: 		void interrupt(){
;Lab3_es1.c,42 :: 		if(INTCON.RBIF){
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt8
;Lab3_es1.c,43 :: 		if(PORTB.RB7 && dly<1000){
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt11
	MOVLW       128
	XORWF       _dly+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt23
	MOVLW       232
	SUBWF       _dly+0, 0 
L__interrupt23:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt11
L__interrupt18:
;Lab3_es1.c,44 :: 		dly += 100;}
	MOVLW       100
	ADDWF       _dly+0, 1 
	MOVLW       0
	ADDWFC      _dly+1, 1 
	GOTO        L_interrupt12
L_interrupt11:
;Lab3_es1.c,45 :: 		else if(PORTB.RB6 && dly>50){
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt15
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _dly+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt24
	MOVF        _dly+0, 0 
	SUBLW       50
L__interrupt24:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt15
L__interrupt17:
;Lab3_es1.c,46 :: 		dly -= 100;}
	MOVLW       100
	SUBWF       _dly+0, 1 
	MOVLW       0
	SUBWFB      _dly+1, 1 
L_interrupt15:
L_interrupt12:
;Lab3_es1.c,48 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;Lab3_es1.c,49 :: 		}
L_interrupt8:
;Lab3_es1.c,51 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt16
;Lab3_es1.c,52 :: 		mio +=32;
	MOVLW       32
	ADDWF       _mio+0, 1 
	MOVLW       0
	ADDWFC      _mio+1, 1 
;Lab3_es1.c,53 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Lab3_es1.c,54 :: 		}
L_interrupt16:
;Lab3_es1.c,55 :: 		}
L_end_interrupt:
L__interrupt22:
	RETFIE      1
; end of _interrupt
