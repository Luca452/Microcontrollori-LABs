
_main:

;Lab6_2.c,19 :: 		void main() {
;Lab6_2.c,24 :: 		ANSELA.RA0 = 1;
	BSF         ANSELA+0, 0 
;Lab6_2.c,27 :: 		ADCON0 = 0b00000011;
	MOVLW       3
	MOVWF       ADCON0+0 
;Lab6_2.c,30 :: 		ADCON2 = 0b00100001;
	MOVLW       33
	MOVWF       ADCON2+0 
;Lab6_2.c,33 :: 		PIE1 =0b01000000;
	MOVLW       64
	MOVWF       PIE1+0 
;Lab6_2.c,35 :: 		PIR1 = 0b00000000;
	CLRF        PIR1+0 
;Lab6_2.c,38 :: 		INTCON = 0b11000000;
	MOVLW       192
	MOVWF       INTCON+0 
;Lab6_2.c,42 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;Lab6_2.c,43 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;Lab6_2.c,46 :: 		CCPTMRS1 = 0b00000100;
	MOVLW       4
	MOVWF       CCPTMRS1+0 
;Lab6_2.c,49 :: 		PR2=255;
	MOVLW       255
	MOVWF       PR2+0 
;Lab6_2.c,52 :: 		CCP5CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP5CON+0 
;Lab6_2.c,55 :: 		T4CON = 0b00000111;
	MOVLW       7
	MOVWF       T4CON+0 
;Lab6_2.c,58 :: 		CCPR5L = 0;
	CLRF        CCPR5L+0 
;Lab6_2.c,103 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab6_2.c,104 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab6_2.c,105 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab6_2.c,106 :: 		Lcd_Out(1,1,"RA0[mV]:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab6_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab6_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab6_2.c,108 :: 		while(1){
L_main0:
;Lab6_2.c,110 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 0 
	IORWF       _adc_flag+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;Lab6_2.c,111 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
	CLRF        _adc_flag+1 
;Lab6_2.c,112 :: 		CCPR5L = adc>>2;
	MOVF        _adc+0, 0 
	MOVWF       R0 
	MOVF        _adc+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       CCPR5L+0 
;Lab6_2.c,113 :: 		IntToStr(5*adc, adc_char);
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _adc+0, 0 
	MOVWF       R4 
	MOVF        _adc+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _adc_char+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_adc_char+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab6_2.c,114 :: 		Lcd_Out(1,11,adc_char);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _adc_char+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_adc_char+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab6_2.c,115 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab6_2.c,116 :: 		}
L_main2:
;Lab6_2.c,118 :: 		}
	GOTO        L_main0
;Lab6_2.c,119 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab6_2.c,121 :: 		void interrupt(){
;Lab6_2.c,122 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;Lab6_2.c,123 :: 		adc = (ADRESH<<2)+(ADRESL>>6);
	MOVF        ADRESH+0, 0 
	MOVWF       _adc+0 
	MOVLW       0
	MOVWF       _adc+1 
	RLCF        _adc+0, 1 
	BCF         _adc+0, 0 
	RLCF        _adc+1, 1 
	RLCF        _adc+0, 1 
	BCF         _adc+0, 0 
	RLCF        _adc+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt7:
	BZ          L__interrupt8
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt7
L__interrupt8:
	MOVF        R0, 0 
	ADDWF       _adc+0, 1 
	MOVLW       0
	ADDWFC      _adc+1, 1 
;Lab6_2.c,124 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
	MOVLW       0
	MOVWF       _adc_flag+1 
;Lab6_2.c,125 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab6_2.c,126 :: 		}
L_interrupt3:
;Lab6_2.c,127 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt
