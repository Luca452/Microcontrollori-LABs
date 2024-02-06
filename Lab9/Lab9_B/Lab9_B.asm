
_main:

;Lab9_B.c,18 :: 		void main() {
;Lab9_B.c,20 :: 		unsigned short int conteggio=0;
	CLRF        main_conteggio_L0+0 
	CLRF        main_conteggio_txt_L0+0 
	CLRF        main_conteggio_txt_L0+1 
	CLRF        main_conteggio_txt_L0+2 
	CLRF        main_conteggio_txt_L0+3 
	CLRF        main_conteggio_txt_L0+4 
	CLRF        main_conteggio_txt_L0+5 
	CLRF        main_conteggio_txt_L0+6 
	CLRF        main_adc_txt_L0+0 
	CLRF        main_adc_txt_L0+1 
	CLRF        main_adc_txt_L0+2 
	CLRF        main_adc_txt_L0+3 
	CLRF        main_adc_txt_L0+4 
	CLRF        main_adc_txt_L0+5 
	CLRF        main_adc_txt_L0+6 
;Lab9_B.c,26 :: 		ANSELA=0b11110001;
	MOVLW       241
	MOVWF       ANSELA+0 
;Lab9_B.c,29 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;Lab9_B.c,30 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Lab9_B.c,31 :: 		TRISA.RA3 = 1;
	BSF         TRISA+0, 3 
;Lab9_B.c,33 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;Lab9_B.c,36 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;Lab9_B.c,37 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;Lab9_B.c,38 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;Lab9_B.c,39 :: 		ADCON0.CHS3 = 0;
	BCF         ADCON0+0, 5 
;Lab9_B.c,40 :: 		ADCON0.CHS4 = 0;
	BCF         ADCON0+0, 6 
;Lab9_B.c,43 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;Lab9_B.c,44 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;Lab9_B.c,45 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;Lab9_B.c,48 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;Lab9_B.c,49 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;Lab9_B.c,50 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;Lab9_B.c,52 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;Lab9_B.c,55 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;Lab9_B.c,58 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;Lab9_B.c,59 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab9_B.c,61 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Lab9_B.c,63 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Lab9_B.c,66 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab9_B.c,67 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_B.c,68 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_B.c,69 :: 		Lcd_Out(1,1,"conteggio:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab9_B+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab9_B+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,70 :: 		Lcd_Out(2,1,"tensione:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Lab9_B+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Lab9_B+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,72 :: 		while(1){
L_main0:
;Lab9_B.c,75 :: 		if((PORTA & ~stato_pb) & 0b00001000){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 3 
	GOTO        L_main2
;Lab9_B.c,76 :: 		conteggio++;
	INCF        main_conteggio_L0+0, 1 
;Lab9_B.c,77 :: 		stato_pb = stato_pb | 0b00001000;
	BSF         main_stato_pb_L0+0, 3 
;Lab9_B.c,78 :: 		IntToStr(conteggio,conteggio_txt);
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_B.c,79 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,80 :: 		}
L_main2:
;Lab9_B.c,83 :: 		if((PORTA & ~stato_pb) & 0b00000010){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 1 
	GOTO        L_main3
;Lab9_B.c,84 :: 		conteggio--;
	DECF        main_conteggio_L0+0, 1 
;Lab9_B.c,85 :: 		stato_pb = stato_pb | 0b00000010;
	BSF         main_stato_pb_L0+0, 1 
;Lab9_B.c,86 :: 		IntToStr(conteggio,conteggio_txt);
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_B.c,87 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,88 :: 		}
L_main3:
;Lab9_B.c,91 :: 		if((PORTA & ~stato_pb) & 0b00000100){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 2 
	GOTO        L_main4
;Lab9_B.c,92 :: 		conteggio = 0;
	CLRF        main_conteggio_L0+0 
;Lab9_B.c,93 :: 		stato_pb = stato_pb | 0b00000100;
	BSF         main_stato_pb_L0+0, 2 
;Lab9_B.c,94 :: 		IntToStr(conteggio,conteggio_txt);
	CLRF        FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_B.c,95 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,96 :: 		}
L_main4:
;Lab9_B.c,97 :: 		stato_pb = PORTA & stato_pb;
	MOVF        PORTA+0, 0 
	ANDWF       main_stato_pb_L0+0, 1 
;Lab9_B.c,99 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;Lab9_B.c,100 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
;Lab9_B.c,101 :: 		IntToStr(adc*5,adc_txt);
	MOVF        _adc+0, 0 
	MOVWF       R0 
	MOVLW       5
	MOVWF       R4 
	CALL        _Mul_8X8_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_B.c,102 :: 		Lcd_Out(2,11,adc_txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_B.c,103 :: 		}
L_main5:
;Lab9_B.c,105 :: 		}
	GOTO        L_main0
;Lab9_B.c,107 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab9_B.c,109 :: 		void interrupt(){
;Lab9_B.c,110 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt6
;Lab9_B.c,111 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab9_B.c,112 :: 		adc = (ADRESH<<2) | (ADRESL>>6);
	MOVF        ADRESH+0, 0 
	MOVWF       _adc+0 
	RLCF        _adc+0, 1 
	BCF         _adc+0, 0 
	RLCF        _adc+0, 1 
	BCF         _adc+0, 0 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt10:
	BZ          L__interrupt11
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt10
L__interrupt11:
	MOVF        R0, 0 
	IORWF       _adc+0, 1 
;Lab9_B.c,113 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
;Lab9_B.c,114 :: 		LATD++;
	MOVF        LATD+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Lab9_B.c,115 :: 		}
L_interrupt6:
;Lab9_B.c,117 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt
