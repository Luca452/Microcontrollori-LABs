
_main:

;Lab2.c,3 :: 		void main() {
;Lab2.c,4 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab2.c,6 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;Lab2.c,7 :: 		while(1){
L_main0:
;Lab2.c,8 :: 		if(LATD == 0b10000000){
	MOVF        LATD+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;Lab2.c,9 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       _sentinella+0 
;Lab2.c,10 :: 		}
	GOTO        L_main3
L_main2:
;Lab2.c,11 :: 		else if(LATD == 0b00000001){
	MOVF        LATD+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;Lab2.c,12 :: 		sentinella = 0;
	CLRF        _sentinella+0 
;Lab2.c,13 :: 		}
L_main4:
L_main3:
;Lab2.c,14 :: 		if(sentinella == 0){
	MOVF        _sentinella+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;Lab2.c,15 :: 		LATD = LATD << 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Lab2.c,16 :: 		}
	GOTO        L_main6
L_main5:
;Lab2.c,17 :: 		else if(sentinella == 1){
	MOVF        _sentinella+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;Lab2.c,18 :: 		LATD = LATD >> 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Lab2.c,19 :: 		}
L_main7:
L_main6:
;Lab2.c,20 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;Lab2.c,21 :: 		}
	GOTO        L_main0
;Lab2.c,22 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
