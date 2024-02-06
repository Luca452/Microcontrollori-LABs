
_main:

;Lab7_1.c,19 :: 		void main() {
;Lab7_1.c,22 :: 		ANSELC.RC3 = 1;
	BSF         ANSELC+0, 3 
;Lab7_1.c,25 :: 		TRISC.RC6 = 0;
	BCF         TRISC+0, 6 
;Lab7_1.c,26 :: 		LATC.RC6 = 1;
	BSF         LATC+0, 6 
;Lab7_1.c,28 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab7_1.c,31 :: 		ADCON0.CHS0 = 1;
	BSF         ADCON0+0, 2 
;Lab7_1.c,32 :: 		ADCON0.CHS1 = 1;
	BSF         ADCON0+0, 3 
;Lab7_1.c,33 :: 		ADCON0.CHS2 = 1;
	BSF         ADCON0+0, 4 
;Lab7_1.c,34 :: 		ADCON0.CHS3 = 1;
	BSF         ADCON0+0, 5 
;Lab7_1.c,35 :: 		ADCON0.CHS4 = 0;
	BCF         ADCON0+0, 6 
;Lab7_1.c,38 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;Lab7_1.c,39 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;Lab7_1.c,40 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;Lab7_1.c,43 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;Lab7_1.c,44 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;Lab7_1.c,45 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;Lab7_1.c,47 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;Lab7_1.c,50 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;Lab7_1.c,53 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;Lab7_1.c,54 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab7_1.c,57 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Lab7_1.c,60 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Lab7_1.c,63 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab7_1.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab7_1.c,65 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab7_1.c,66 :: 		Lcd_Out(1,1,"d[mm]:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab7_1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab7_1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab7_1.c,69 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab7_1.c,71 :: 		while (1)
L_main0:
;Lab7_1.c,74 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 0 
	IORWF       _adc_flag+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;Lab7_1.c,75 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
	CLRF        _adc_flag+1 
;Lab7_1.c,76 :: 		IntToStr(5*adc,adc_char);
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
;Lab7_1.c,77 :: 		Lcd_Out(1,11,adc_char);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _adc_char+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_adc_char+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab7_1.c,80 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab7_1.c,81 :: 		}
L_main2:
;Lab7_1.c,82 :: 		}
	GOTO        L_main0
;Lab7_1.c,83 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab7_1.c,85 :: 		void interrupt(){
;Lab7_1.c,86 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;Lab7_1.c,87 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab7_1.c,88 :: 		adc = (ADRESH<<2)+(ADRESL>>6);
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
;Lab7_1.c,89 :: 		adc_flag=1;
	MOVLW       1
	MOVWF       _adc_flag+0 
	MOVLW       0
	MOVWF       _adc_flag+1 
;Lab7_1.c,90 :: 		}
L_interrupt3:
;Lab7_1.c,92 :: 		}
L_end_interrupt:
L__interrupt6:
	RETFIE      1
; end of _interrupt
