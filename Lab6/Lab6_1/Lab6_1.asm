
_main:

;Lab6_1.c,7 :: 		void main() {
;Lab6_1.c,9 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;Lab6_1.c,10 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;Lab6_1.c,13 :: 		CCPTMRS1.C5TSEL1 = 0;
	BCF         CCPTMRS1+0, 3 
;Lab6_1.c,14 :: 		CCPTMRS1.C5TSEL0 = 0;
	BCF         CCPTMRS1+0, 2 
;Lab6_1.c,17 :: 		PR2=255;
	MOVLW       255
	MOVWF       PR2+0 
;Lab6_1.c,20 :: 		CCP5CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP5CON+0 
;Lab6_1.c,23 :: 		T2CON = 0b00000111;
	MOVLW       7
	MOVWF       T2CON+0 
;Lab6_1.c,26 :: 		CCPR5L = 0;
	CLRF        CCPR5L+0 
;Lab6_1.c,28 :: 		while(1){
L_main0:
;Lab6_1.c,29 :: 		CCPR5L++;
	MOVF        CCPR5L+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       CCPR5L+0 
;Lab6_1.c,30 :: 		LATD = CCPR5L;
	MOVF        CCPR5L+0, 0 
	MOVWF       LATD+0 
;Lab6_1.c,31 :: 		Delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;Lab6_1.c,32 :: 		}
	GOTO        L_main0
;Lab6_1.c,34 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
