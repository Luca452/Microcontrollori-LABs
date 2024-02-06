
_binaryToThermo:

;Lab9_C.c,19 :: 		unsigned short int binaryToThermo(unsigned short int binary){
;Lab9_C.c,20 :: 		unsigned short int thermo=0;
	CLRF        binaryToThermo_thermo_L0+0 
;Lab9_C.c,21 :: 		if(binary<32)
	MOVLW       32
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo0
;Lab9_C.c,22 :: 		thermo = 0b00000001;
	MOVLW       1
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo1
L_binaryToThermo0:
;Lab9_C.c,23 :: 		else if(binary<64)
	MOVLW       64
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo2
;Lab9_C.c,24 :: 		thermo = 0b00000011;
	MOVLW       3
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo3
L_binaryToThermo2:
;Lab9_C.c,25 :: 		else if(binary<96)
	MOVLW       96
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo4
;Lab9_C.c,26 :: 		thermo = 0b00000111;
	MOVLW       7
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo5
L_binaryToThermo4:
;Lab9_C.c,27 :: 		else if(binary<128)
	MOVLW       128
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo6
;Lab9_C.c,28 :: 		thermo = 0b00001111;
	MOVLW       15
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo7
L_binaryToThermo6:
;Lab9_C.c,29 :: 		else if(binary<160)
	MOVLW       160
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo8
;Lab9_C.c,30 :: 		thermo = 0b00011111;
	MOVLW       31
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo9
L_binaryToThermo8:
;Lab9_C.c,31 :: 		else if(binary<192)
	MOVLW       192
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo10
;Lab9_C.c,32 :: 		thermo = 0b00111111;
	MOVLW       63
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo11
L_binaryToThermo10:
;Lab9_C.c,33 :: 		else if(binary<224)
	MOVLW       224
	SUBWF       FARG_binaryToThermo_binary+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo12
;Lab9_C.c,34 :: 		thermo = 0b01111111;
	MOVLW       127
	MOVWF       binaryToThermo_thermo_L0+0 
	GOTO        L_binaryToThermo13
L_binaryToThermo12:
;Lab9_C.c,35 :: 		else if(binary<256)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__binaryToThermo25
	MOVLW       0
	SUBWF       FARG_binaryToThermo_binary+0, 0 
L__binaryToThermo25:
	BTFSC       STATUS+0, 0 
	GOTO        L_binaryToThermo14
;Lab9_C.c,36 :: 		thermo = 0b11111111;
	MOVLW       255
	MOVWF       binaryToThermo_thermo_L0+0 
L_binaryToThermo14:
L_binaryToThermo13:
L_binaryToThermo11:
L_binaryToThermo9:
L_binaryToThermo7:
L_binaryToThermo5:
L_binaryToThermo3:
L_binaryToThermo1:
;Lab9_C.c,38 :: 		return thermo;
	MOVF        binaryToThermo_thermo_L0+0, 0 
	MOVWF       R0 
;Lab9_C.c,39 :: 		}
L_end_binaryToThermo:
	RETURN      0
; end of _binaryToThermo

_main:

;Lab9_C.c,41 :: 		void main() {
;Lab9_C.c,43 :: 		unsigned short int conteggio=0;
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
;Lab9_C.c,49 :: 		ANSELA=0b11110001;
	MOVLW       241
	MOVWF       ANSELA+0 
;Lab9_C.c,50 :: 		TRISE.RE2 = 1;
	BSF         TRISE+0, 2 
;Lab9_C.c,53 :: 		TRISA.RA1 = 1;
	BSF         TRISA+0, 1 
;Lab9_C.c,54 :: 		TRISA.RA2 = 1;
	BSF         TRISA+0, 2 
;Lab9_C.c,55 :: 		TRISA.RA3 = 1;
	BSF         TRISA+0, 3 
;Lab9_C.c,56 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Lab9_C.c,60 :: 		CCPTMRS1 = 0b00001000;
	MOVLW       8
	MOVWF       CCPTMRS1+0 
;Lab9_C.c,63 :: 		PR2=255;
	MOVLW       255
	MOVWF       PR2+0 
;Lab9_C.c,66 :: 		CCP5CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP5CON+0 
;Lab9_C.c,69 :: 		T6CON = 0b00000111;
	MOVLW       7
	MOVWF       T6CON+0 
;Lab9_C.c,72 :: 		CCPR5L = 0;
	CLRF        CCPR5L+0 
;Lab9_C.c,75 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;Lab9_C.c,78 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;Lab9_C.c,79 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;Lab9_C.c,80 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;Lab9_C.c,81 :: 		ADCON0.CHS3 = 0;
	BCF         ADCON0+0, 5 
;Lab9_C.c,82 :: 		ADCON0.CHS4 = 0;
	BCF         ADCON0+0, 6 
;Lab9_C.c,85 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;Lab9_C.c,86 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;Lab9_C.c,87 :: 		ADCON2.ADCS2 = 1;
	BSF         ADCON2+0, 2 
;Lab9_C.c,90 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;Lab9_C.c,91 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;Lab9_C.c,92 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;Lab9_C.c,94 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;Lab9_C.c,97 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;Lab9_C.c,100 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;Lab9_C.c,101 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab9_C.c,103 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Lab9_C.c,105 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Lab9_C.c,108 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab9_C.c,109 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_C.c,110 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_C.c,111 :: 		Lcd_Out(1,1,"conteggio:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab9_C+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab9_C+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,112 :: 		Lcd_Out(2,1,"tensione:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Lab9_C+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Lab9_C+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,114 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab9_C.c,116 :: 		while(1){
L_main15:
;Lab9_C.c,119 :: 		if((PORTA & ~stato_pb) & 0b00001000){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 3 
	GOTO        L_main17
;Lab9_C.c,120 :: 		conteggio++;
	INCF        main_conteggio_L0+0, 1 
;Lab9_C.c,121 :: 		stato_pb = stato_pb | 0b00001000;
	BSF         main_stato_pb_L0+0, 3 
;Lab9_C.c,122 :: 		IntToStr(conteggio,conteggio_txt);
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_C.c,123 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,124 :: 		}
L_main17:
;Lab9_C.c,127 :: 		if((PORTA & ~stato_pb) & 0b00000010){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 1 
	GOTO        L_main18
;Lab9_C.c,128 :: 		conteggio--;
	DECF        main_conteggio_L0+0, 1 
;Lab9_C.c,129 :: 		stato_pb = stato_pb | 0b00000010;
	BSF         main_stato_pb_L0+0, 1 
;Lab9_C.c,130 :: 		IntToStr(conteggio,conteggio_txt);
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_C.c,131 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,132 :: 		}
L_main18:
;Lab9_C.c,135 :: 		if((PORTA & ~stato_pb) & 0b00000100){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 2 
	GOTO        L_main19
;Lab9_C.c,136 :: 		conteggio = 0;
	CLRF        main_conteggio_L0+0 
;Lab9_C.c,137 :: 		stato_pb = stato_pb | 0b00000100;
	BSF         main_stato_pb_L0+0, 2 
;Lab9_C.c,138 :: 		IntToStr(conteggio,conteggio_txt);
	CLRF        FARG_IntToStr_input+0 
	CLRF        FARG_IntToStr_input+1 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_C.c,139 :: 		Lcd_Out(1,11,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,140 :: 		}
L_main19:
;Lab9_C.c,141 :: 		stato_pb = PORTA & stato_pb;
	MOVF        PORTA+0, 0 
	ANDWF       main_stato_pb_L0+0, 1 
;Lab9_C.c,143 :: 		if(adc_flag){
	MOVF        _adc_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;Lab9_C.c,144 :: 		adc_flag = 0;
	CLRF        _adc_flag+0 
;Lab9_C.c,145 :: 		IntToStr(adc_tensione*5,adc_txt);
	MOVF        _adc_tensione+0, 0 
	MOVWF       R0 
	MOVF        _adc_tensione+1, 0 
	MOVWF       R1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_C.c,146 :: 		Lcd_Out(2,11,adc_txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_C.c,148 :: 		CCPR5L = adc_sonar;
	MOVF        _adc_sonar+0, 0 
	MOVWF       CCPR5L+0 
;Lab9_C.c,150 :: 		ADCON0.CHS0 = ~ADCON0.CHS0;
	BTG         ADCON0+0, 2 
;Lab9_C.c,151 :: 		ADCON0.CHS1 = ~ADCON0.CHS1;
	BTG         ADCON0+0, 3 
;Lab9_C.c,152 :: 		ADCON0.CHS2 = ~ADCON0.CHS2;
	BTG         ADCON0+0, 4 
;Lab9_C.c,153 :: 		ADCON0.CHS3 = ~ADCON0.CHS3;
	BTG         ADCON0+0, 5 
;Lab9_C.c,155 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Lab9_C.c,156 :: 		}
L_main20:
;Lab9_C.c,160 :: 		}
	GOTO        L_main15
;Lab9_C.c,162 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab9_C.c,164 :: 		void interrupt(){
;Lab9_C.c,165 :: 		if(PIR1.ADIF){
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt21
;Lab9_C.c,166 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Lab9_C.c,168 :: 		if(ADCON0.CHS0){
	BTFSS       ADCON0+0, 2 
	GOTO        L_interrupt22
;Lab9_C.c,169 :: 		adc_sonar = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_sonar+0 
;Lab9_C.c,170 :: 		LATD = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       LATD+0 
;Lab9_C.c,171 :: 		}
	GOTO        L_interrupt23
L_interrupt22:
;Lab9_C.c,173 :: 		adc_tensione = (ADRESH<<2) | (ADRESL>>6);
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_tensione+0 
	MOVLW       0
	MOVWF       _adc_tensione+1 
	RLCF        _adc_tensione+0, 1 
	BCF         _adc_tensione+0, 0 
	RLCF        _adc_tensione+1, 1 
	RLCF        _adc_tensione+0, 1 
	BCF         _adc_tensione+0, 0 
	RLCF        _adc_tensione+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt29:
	BZ          L__interrupt30
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt29
L__interrupt30:
	MOVF        R0, 0 
	IORWF       _adc_tensione+0, 1 
	MOVLW       0
	IORWF       _adc_tensione+1, 1 
;Lab9_C.c,174 :: 		}
L_interrupt23:
;Lab9_C.c,175 :: 		adc_flag = 1;
	MOVLW       1
	MOVWF       _adc_flag+0 
;Lab9_C.c,176 :: 		}
L_interrupt21:
;Lab9_C.c,178 :: 		}
L_end_interrupt:
L__interrupt28:
	RETFIE      1
; end of _interrupt
