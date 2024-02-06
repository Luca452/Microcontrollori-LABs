
_main:

;Lab4_es2.c,24 :: 		void main() {
;Lab4_es2.c,26 :: 		short int sentinella = 0;
	CLRF        main_sentinella_L0+0 
	CLRF        main_high_L0+0 
	CLRF        main_low_L0+0 
	MOVLW       15
	MOVWF       main_mask_L0+0 
	CLRF        main_count_L0+0 
	CLRF        main_count_prec_L0+0 
;Lab4_es2.c,35 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab4_es2.c,36 :: 		LATD = 0b10000001;
	MOVLW       129
	MOVWF       LATD+0 
;Lab4_es2.c,38 :: 		TRISA = 0b00011111;
	MOVLW       31
	MOVWF       TRISA+0 
;Lab4_es2.c,39 :: 		ANSELA = 0b11100000;
	MOVLW       224
	MOVWF       ANSELA+0 
;Lab4_es2.c,41 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;Lab4_es2.c,42 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;Lab4_es2.c,44 :: 		high = 0b00001000;
	MOVLW       8
	MOVWF       main_high_L0+0 
;Lab4_es2.c,45 :: 		low  = 0b00000001;
	MOVLW       1
	MOVWF       main_low_L0+0 
;Lab4_es2.c,48 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab4_es2.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es2.c,50 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es2.c,52 :: 		IntToStr(count,count_txt);
	MOVF        main_count_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab4_es2.c,53 :: 		Lcd_Out(1,11,count_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab4_es2.c,55 :: 		while(1){
L_main0:
;Lab4_es2.c,57 :: 		if(delay_ms_1 >= delay_kitt){
	MOVLW       128
	XORWF       _delay_ms_1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        _delay_kitt+0, 0 
	SUBWF       _delay_ms_1+0, 0 
L__main38:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;Lab4_es2.c,59 :: 		if( high == 0b1111 && low == 0b1111)
	MOVF        main_high_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	MOVF        main_low_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
L__main34:
;Lab4_es2.c,60 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main6
L_main5:
;Lab4_es2.c,61 :: 		else if ( high == 0b0000 &&  low == 0b0000)
	MOVF        main_high_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        main_low_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main33:
;Lab4_es2.c,62 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main9:
L_main6:
;Lab4_es2.c,64 :: 		if(sentinella == 0){
	MOVF        main_sentinella_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;Lab4_es2.c,65 :: 		low  <<= 1;
	RLCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 0 
;Lab4_es2.c,66 :: 		high >>= 1;
	RRCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 7 
	BTFSC       main_high_L0+0, 6 
	BSF         main_high_L0+0, 7 
;Lab4_es2.c,67 :: 		low  += 0b00000001;
	INCF        main_low_L0+0, 1 
;Lab4_es2.c,68 :: 		high += 0b00001000;
	MOVLW       8
	ADDWF       main_high_L0+0, 1 
;Lab4_es2.c,69 :: 		} else{
	GOTO        L_main11
L_main10:
;Lab4_es2.c,70 :: 		high <<= 1;
	RLCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 0 
;Lab4_es2.c,71 :: 		low  >>= 1;
	RRCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 7 
	BTFSC       main_low_L0+0, 6 
	BSF         main_low_L0+0, 7 
;Lab4_es2.c,72 :: 		high &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_high_L0+0, 1 
;Lab4_es2.c,73 :: 		low &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_low_L0+0, 1 
;Lab4_es2.c,74 :: 		}
L_main11:
;Lab4_es2.c,76 :: 		LATD = (high << 4) | low;
	MOVLW       4
	MOVWF       R1 
	MOVF        main_high_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main39:
	BZ          L__main40
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main39
L__main40:
	MOVF        main_low_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       LATD+0 
;Lab4_es2.c,77 :: 		delay_ms_1 -= delay_kitt;
	MOVF        _delay_kitt+0, 0 
	SUBWF       _delay_ms_1+0, 1 
	MOVF        _delay_kitt+1, 0 
	SUBWFB      _delay_ms_1+1, 1 
;Lab4_es2.c,78 :: 		}
L_main2:
;Lab4_es2.c,80 :: 		if(delay_ms_2 >= 1000){
	MOVLW       128
	XORWF       _delay_ms_2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVLW       232
	SUBWF       _delay_ms_2+0, 0 
L__main41:
	BTFSS       STATUS+0, 0 
	GOTO        L_main12
;Lab4_es2.c,81 :: 		if(!reset && !stop)
	MOVF        _reset+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _stop+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
L__main32:
;Lab4_es2.c,82 :: 		count++;
	INCF        main_count_L0+0, 1 
L_main15:
;Lab4_es2.c,83 :: 		if(reset)
	MOVF        _reset+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
;Lab4_es2.c,84 :: 		count=0;
	CLRF        main_count_L0+0 
L_main16:
;Lab4_es2.c,86 :: 		if (count != count_prec){
	MOVF        main_count_L0+0, 0 
	XORWF       main_count_prec_L0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
;Lab4_es2.c,87 :: 		IntToStr(count,count_txt);
	MOVF        main_count_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab4_es2.c,88 :: 		Lcd_Out(1,11,count_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab4_es2.c,89 :: 		}
L_main17:
;Lab4_es2.c,90 :: 		delay_ms_2 -= 1000;
	MOVLW       232
	SUBWF       _delay_ms_2+0, 1 
	MOVLW       3
	SUBWFB      _delay_ms_2+1, 1 
;Lab4_es2.c,91 :: 		count_prec = count;
	MOVF        main_count_L0+0, 0 
	MOVWF       main_count_prec_L0+0 
;Lab4_es2.c,92 :: 		}
L_main12:
;Lab4_es2.c,94 :: 		}
	GOTO        L_main0
;Lab4_es2.c,96 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab4_es2.c,98 :: 		void interrupt(){
;Lab4_es2.c,100 :: 		if (PORTA.RA3 && delay_kitt<1000)
	BTFSS       PORTA+0, 3 
	GOTO        L_interrupt20
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt44
	MOVLW       232
	SUBWF       _delay_kitt+0, 0 
L__interrupt44:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt36:
;Lab4_es2.c,101 :: 		delay_kitt +=50;
	MOVLW       50
	ADDWF       _delay_kitt+0, 1 
	MOVLW       0
	ADDWFC      _delay_kitt+1, 1 
	GOTO        L_interrupt21
L_interrupt20:
;Lab4_es2.c,102 :: 		else if (PORTA.RA4 && delay_kitt>100)
	BTFSS       PORTA+0, 4 
	GOTO        L_interrupt24
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt45
	MOVF        _delay_kitt+0, 0 
	SUBLW       100
L__interrupt45:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt24
L__interrupt35:
;Lab4_es2.c,103 :: 		delay_kitt -=50;
	MOVLW       50
	SUBWF       _delay_kitt+0, 1 
	MOVLW       0
	SUBWFB      _delay_kitt+1, 1 
L_interrupt24:
L_interrupt21:
;Lab4_es2.c,105 :: 		if (PORTA.RA2){ //precedenza al reset
	BTFSS       PORTA+0, 2 
	GOTO        L_interrupt25
;Lab4_es2.c,106 :: 		stop = 0;
	CLRF        _stop+0 
;Lab4_es2.c,107 :: 		reset = 1;}
	MOVLW       1
	MOVWF       _reset+0 
	GOTO        L_interrupt26
L_interrupt25:
;Lab4_es2.c,108 :: 		else if (PORTA.RA1){ //poi stop
	BTFSS       PORTA+0, 1 
	GOTO        L_interrupt27
;Lab4_es2.c,109 :: 		stop = 1;
	MOVLW       1
	MOVWF       _stop+0 
;Lab4_es2.c,110 :: 		reset = 0;}
	CLRF        _reset+0 
	GOTO        L_interrupt28
L_interrupt27:
;Lab4_es2.c,111 :: 		else if (PORTA.RA0){ //infine start
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt29
;Lab4_es2.c,112 :: 		stop = 0;
	CLRF        _stop+0 
;Lab4_es2.c,113 :: 		reset = 0;}
	CLRF        _reset+0 
L_interrupt29:
L_interrupt28:
L_interrupt26:
;Lab4_es2.c,116 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt30
;Lab4_es2.c,117 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Lab4_es2.c,118 :: 		delay_ms_1 +=32;
	MOVLW       32
	ADDWF       _delay_ms_1+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_1+1, 1 
;Lab4_es2.c,119 :: 		delay_ms_2 +=32;
	MOVLW       32
	ADDWF       _delay_ms_2+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_2+1, 1 
;Lab4_es2.c,120 :: 		delay_us +=768;
	MOVLW       0
	ADDWF       _delay_us+0, 0 
	MOVWF       R1 
	MOVLW       3
	ADDWFC      _delay_us+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _delay_us+0 
	MOVF        R2, 0 
	MOVWF       _delay_us+1 
;Lab4_es2.c,121 :: 		if (delay_us >= 1000)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt46
	MOVLW       232
	SUBWF       R1, 0 
L__interrupt46:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt31
;Lab4_es2.c,123 :: 		delay_ms_1 +=1;
	INFSNZ      _delay_ms_1+0, 1 
	INCF        _delay_ms_1+1, 1 
;Lab4_es2.c,124 :: 		delay_ms_2 +=1;
	INFSNZ      _delay_ms_2+0, 1 
	INCF        _delay_ms_2+1, 1 
;Lab4_es2.c,125 :: 		delay_us = 0;
	CLRF        _delay_us+0 
	CLRF        _delay_us+1 
;Lab4_es2.c,126 :: 		}
L_interrupt31:
;Lab4_es2.c,127 :: 		}
L_interrupt30:
;Lab4_es2.c,129 :: 		}
L_end_interrupt:
L__interrupt43:
	RETFIE      1
; end of _interrupt
