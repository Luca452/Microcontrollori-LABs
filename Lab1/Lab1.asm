
_main:

;Lab1.c,1 :: 		void main() {
;Lab1.c,2 :: 		TRISA = 0xFE;
	MOVLW       254
	MOVWF       TRISA+0 
;Lab1.c,3 :: 		LATA.RA0 = '1';
	BSF         LATA+0, 0 
;Lab1.c,5 :: 		TRISD = 0x01;
	MOVLW       1
	MOVWF       TRISD+0 
;Lab1.c,6 :: 		ANSELD = 0xFE;
	MOVLW       254
	MOVWF       ANSELD+0 
;Lab1.c,8 :: 		while(1){
L_main0:
;Lab1.c,9 :: 		if(PORTD.RD0 == '0'){
	BTFSC       PORTD+0, 0 
	GOTO        L_main2
;Lab1.c,10 :: 		LATA.RA0 = '0';
	BCF         LATA+0, 0 
;Lab1.c,11 :: 		}
	GOTO        L_main3
L_main2:
;Lab1.c,13 :: 		LATA.RA0 = ~ LATA.RA0;
	BTG         LATA+0, 0 
;Lab1.c,14 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;Lab1.c,15 :: 		}
L_main3:
;Lab1.c,16 :: 		}
	GOTO        L_main0
;Lab1.c,17 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
