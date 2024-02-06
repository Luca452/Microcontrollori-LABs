
_main:

;Lab05_2.c,19 :: 		void main() {
;Lab05_2.c,20 :: 		char adc_char[7]={0};
	CLRF        main_adc_char_L0+0 
	CLRF        main_adc_char_L0+1 
	CLRF        main_adc_char_L0+2 
	CLRF        main_adc_char_L0+3 
	CLRF        main_adc_char_L0+4 
	CLRF        main_adc_char_L0+5 
	CLRF        main_adc_char_L0+6 
;Lab05_2.c,23 :: 		ANSELA.RA0 = 1;
	BSF         ANSELA+0, 0 
;Lab05_2.c,24 :: 		ANSELA.RA1 = 1;
	BSF         ANSELA+0, 1 
;Lab05_2.c,27 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;Lab05_2.c,28 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;Lab05_2.c,29 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;Lab05_2.c,30 :: 		ADCON0.CHS3 = 0;
	BCF         ADCON0+0, 5 
;Lab05_2.c,31 :: 		ADCON0.CHS4 = 0;
	BCF         ADCON0+0, 6 
;Lab05_2.c,34 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;Lab05_2.c,35 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;Lab05_2.c,36 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;Lab05_2.c,39 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;Lab05_2.c,40 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;Lab05_2.c,41 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;Lab05_2.c,43 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;Lab05_2.c,46 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;Lab05_2.c,49 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;Lab05_2.c,50 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab05_2.c,53 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Lab05_2.c,56 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Lab05_2.c,59 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab05_2.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab05_2.c,61 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab05_2.c,62 :: 		Lcd_Out(1,1,"RA0[mV]:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab05_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab05_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab05_2.c,63 :: 		Lcd_Out(2,1,"RA1[mV]:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Lab05_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Lab05_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab05_2.c,66 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab05_2.c,68 :: 		while (1)
L_main0:
;Lab05_2.c,71 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 0 
	IORWF       _adc_flag+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;Lab05_2.c,72 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
	CLRF        _adc_flag+1 
;Lab05_2.c,74 :: 		if(!ADCON0.CHS0){
	BTFSC       ADCON0+0, 2 
	GOTO        L_main3
;Lab05_2.c,75 :: 		IntToStr(5*adc1,adc_char);
	MOVLW       5
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _adc1+0, 0 
	MOVWF       R4 
	MOVF        _adc1+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_char_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_char_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab05_2.c,76 :: 		Lcd_Out(1,11,adc_char);}
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_char_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_char_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_main4
L_main3:
;Lab05_2.c,78 :: 		IntToStr(20*adc2,adc_char);
	MOVLW       20
	MULWF       _adc2+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_char_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_char_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab05_2.c,79 :: 		Lcd_Out(2,11,adc_char);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_char_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_char_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab05_2.c,80 :: 		}
L_main4:
;Lab05_2.c,82 :: 		ADCON0.CHS0 = !ADCON0.CHS0;
	BTG         ADCON0+0, 2 
;Lab05_2.c,85 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab05_2.c,87 :: 		}
L_main2:
;Lab05_2.c,88 :: 		}
	GOTO        L_main0
;Lab05_2.c,90 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab05_2.c,92 :: 		void interrupt(){
;Lab05_2.c,94 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt5
;Lab05_2.c,96 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab05_2.c,99 :: 		if(!ADCON0.CHS0)
	BTFSC       ADCON0+0, 2 
	GOTO        L_interrupt6
;Lab05_2.c,100 :: 		adc1 = (ADRESH<<2) | (ADRESL>>6);
	MOVF        ADRESH+0, 0 
	MOVWF       _adc1+0 
	MOVLW       0
	MOVWF       _adc1+1 
	RLCF        _adc1+0, 1 
	BCF         _adc1+0, 0 
	RLCF        _adc1+1, 1 
	RLCF        _adc1+0, 1 
	BCF         _adc1+0, 0 
	RLCF        _adc1+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt11:
	BZ          L__interrupt12
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt11
L__interrupt12:
	MOVF        R0, 0 
	IORWF       _adc1+0, 1 
	MOVLW       0
	IORWF       _adc1+1, 1 
	GOTO        L_interrupt7
L_interrupt6:
;Lab05_2.c,102 :: 		adc2 = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc2+0 
L_interrupt7:
;Lab05_2.c,106 :: 		adc_flag=1;
	MOVLW       1
	MOVWF       _adc_flag+0 
	MOVLW       0
	MOVWF       _adc_flag+1 
;Lab05_2.c,107 :: 		}
L_interrupt5:
;Lab05_2.c,110 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt
