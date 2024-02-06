
_delay_mio:

;Lab1_es3.c,4 :: 		void delay_mio(int divisore){
;Lab1_es3.c,5 :: 		for(i=0; i<1000/divisore; i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_delay_mio0:
	MOVF        FARG_delay_mio_divisore+0, 0 
	MOVWF       R4 
	MOVF        FARG_delay_mio_divisore+1, 0 
	MOVWF       R5 
	MOVLW       232
	MOVWF       R0 
	MOVLW       3
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__delay_mio19
	MOVF        R0, 0 
	SUBWF       _i+0, 0 
L__delay_mio19:
	BTFSC       STATUS+0, 0 
	GOTO        L_delay_mio1
;Lab1_es3.c,6 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_delay_mio3:
	DECFSZ      R13, 1, 1
	BRA         L_delay_mio3
	DECFSZ      R12, 1, 1
	BRA         L_delay_mio3
	NOP
	NOP
;Lab1_es3.c,5 :: 		for(i=0; i<1000/divisore; i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Lab1_es3.c,7 :: 		}
	GOTO        L_delay_mio0
L_delay_mio1:
;Lab1_es3.c,8 :: 		}
L_end_delay_mio:
	RETURN      0
; end of _delay_mio

_main:

;Lab1_es3.c,10 :: 		void main(){
;Lab1_es3.c,11 :: 		TRISA = 0xFE;
	MOVLW       254
	MOVWF       TRISA+0 
;Lab1_es3.c,12 :: 		LATA.RA0 = '1';
	BSF         LATA+0, 0 
;Lab1_es3.c,14 :: 		TRISD = 0xFF;
	MOVLW       255
	MOVWF       TRISD+0 
;Lab1_es3.c,15 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;Lab1_es3.c,17 :: 		while(1){
L_main4:
;Lab1_es3.c,18 :: 		while(PORTD.RD0 == '1'){
L_main6:
	BTFSS       PORTD+0, 0 
	GOTO        L_main7
;Lab1_es3.c,19 :: 		LATA.RA0 = '1';
	BSF         LATA+0, 0 
;Lab1_es3.c,20 :: 		}
	GOTO        L_main6
L_main7:
;Lab1_es3.c,21 :: 		if(PORTD.RD1 =='1'){
	BTFSS       PORTD+0, 1 
	GOTO        L_main8
;Lab1_es3.c,22 :: 		divisore = 4;
	MOVLW       4
	MOVWF       _divisore+0 
	MOVLW       0
	MOVWF       _divisore+1 
;Lab1_es3.c,23 :: 		} else{ LATA.RA0 = '0';}
	GOTO        L_main9
L_main8:
	BCF         LATA+0, 0 
L_main9:
;Lab1_es3.c,24 :: 		if(PORTD.RD2 =='1'){
	BTFSS       PORTD+0, 2 
	GOTO        L_main10
;Lab1_es3.c,25 :: 		divisore = 6;
	MOVLW       6
	MOVWF       _divisore+0 
	MOVLW       0
	MOVWF       _divisore+1 
;Lab1_es3.c,26 :: 		} else{ LATA.RA0 = '0';}
	GOTO        L_main11
L_main10:
	BCF         LATA+0, 0 
L_main11:
;Lab1_es3.c,27 :: 		if(PORTD.RD3 =='1'){
	BTFSS       PORTD+0, 3 
	GOTO        L_main12
;Lab1_es3.c,28 :: 		divisore = 8;
	MOVLW       8
	MOVWF       _divisore+0 
	MOVLW       0
	MOVWF       _divisore+1 
;Lab1_es3.c,29 :: 		} else{ LATA.RA0 = '0';}
	GOTO        L_main13
L_main12:
	BCF         LATA+0, 0 
L_main13:
;Lab1_es3.c,30 :: 		if(PORTD.RD4 =='1'){
	BTFSS       PORTD+0, 4 
	GOTO        L_main14
;Lab1_es3.c,31 :: 		divisore = 10;
	MOVLW       10
	MOVWF       _divisore+0 
	MOVLW       0
	MOVWF       _divisore+1 
;Lab1_es3.c,32 :: 		} else{ LATA.RA0 = '0';}
	GOTO        L_main15
L_main14:
	BCF         LATA+0, 0 
L_main15:
;Lab1_es3.c,33 :: 		if(PORTD.RD5 =='1'){
	BTFSS       PORTD+0, 5 
	GOTO        L_main16
;Lab1_es3.c,34 :: 		divisore = 12;
	MOVLW       12
	MOVWF       _divisore+0 
	MOVLW       0
	MOVWF       _divisore+1 
;Lab1_es3.c,35 :: 		} else{ LATA.RA0 = '0';}
	GOTO        L_main17
L_main16:
	BCF         LATA+0, 0 
L_main17:
;Lab1_es3.c,36 :: 		LATA.RA0 = ~ LATA.RA0;
	BTG         LATA+0, 0 
;Lab1_es3.c,37 :: 		delay_mio(divisore);
	MOVF        _divisore+0, 0 
	MOVWF       FARG_delay_mio_divisore+0 
	MOVF        _divisore+1, 0 
	MOVWF       FARG_delay_mio_divisore+1 
	CALL        _delay_mio+0, 0
;Lab1_es3.c,39 :: 		}
	GOTO        L_main4
;Lab1_es3.c,40 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
