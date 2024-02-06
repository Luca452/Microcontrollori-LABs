
_main:

;Lab2_es2.c,4 :: 		void main() {
;Lab2_es2.c,5 :: 		short int sentinella=0;
	CLRF        main_sentinella_L0+0 
;Lab2_es2.c,6 :: 		TRISB = 0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;Lab2_es2.c,8 :: 		ANSELB = 0x3F;
	MOVLW       63
	MOVWF       ANSELB+0 
;Lab2_es2.c,10 :: 		IOCB = 0b11000000;
	MOVLW       192
	MOVWF       IOCB+0 
;Lab2_es2.c,11 :: 		INTCON = 0b10001000;
	MOVLW       136
	MOVWF       INTCON+0 
;Lab2_es2.c,17 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab2_es2.c,18 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;Lab2_es2.c,21 :: 		while(1){
L_main0:
;Lab2_es2.c,22 :: 		if(LATD == 0b10000000)
	MOVF        LATD+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;Lab2_es2.c,23 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main3
L_main2:
;Lab2_es2.c,24 :: 		else if(LATD == 0b00000001)
	MOVF        LATD+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;Lab2_es2.c,25 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main4:
L_main3:
;Lab2_es2.c,27 :: 		if(!sentinella)
	MOVF        main_sentinella_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;Lab2_es2.c,28 :: 		LATD = LATD << 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
	GOTO        L_main6
L_main5:
;Lab2_es2.c,30 :: 		LATD = LATD >> 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
L_main6:
;Lab2_es2.c,31 :: 		Vdelay_ms(mio);
	MOVF        _mio+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _mio+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Lab2_es2.c,32 :: 		}
	GOTO        L_main0
;Lab2_es2.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab2_es2.c,35 :: 		void interrupt(){
;Lab2_es2.c,37 :: 		if(INTCON.RBIF){
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt7
;Lab2_es2.c,38 :: 		if(PORTB.RB7 && mio<1000){
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt10
	MOVLW       128
	XORWF       _mio+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt20
	MOVLW       232
	SUBWF       _mio+0, 0 
L__interrupt20:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt10
L__interrupt16:
;Lab2_es2.c,39 :: 		mio += 100;}
	MOVLW       100
	ADDWF       _mio+0, 1 
	MOVLW       0
	ADDWFC      _mio+1, 1 
	GOTO        L_interrupt11
L_interrupt10:
;Lab2_es2.c,40 :: 		else if(PORTB.RB6 && mio>50){
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt14
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _mio+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt21
	MOVF        _mio+0, 0 
	SUBLW       50
L__interrupt21:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt14
L__interrupt15:
;Lab2_es2.c,41 :: 		mio -= 100;}
	MOVLW       100
	SUBWF       _mio+0, 1 
	MOVLW       0
	SUBWFB      _mio+1, 1 
L_interrupt14:
L_interrupt11:
;Lab2_es2.c,43 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;Lab2_es2.c,44 :: 		}
L_interrupt7:
;Lab2_es2.c,45 :: 		}
L_end_interrupt:
L__interrupt19:
	RETFIE      1
; end of _interrupt
