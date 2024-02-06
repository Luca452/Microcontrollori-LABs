
_main:

;Lab4_es1.c,21 :: 		void main() {
;Lab4_es1.c,23 :: 		short int sentinella = 0;
	CLRF        main_sentinella_L0+0 
	CLRF        main_high_L0+0 
	CLRF        main_low_L0+0 
	MOVLW       15
	MOVWF       main_mask_L0+0 
	CLRF        main_count_L0+0 
;Lab4_es1.c,30 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab4_es1.c,31 :: 		LATD = 0b10000001;
	MOVLW       129
	MOVWF       LATD+0 
;Lab4_es1.c,33 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;Lab4_es1.c,34 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;Lab4_es1.c,36 :: 		high = 0b00001000;
	MOVLW       8
	MOVWF       main_high_L0+0 
;Lab4_es1.c,37 :: 		low  = 0b00000001;
	MOVLW       1
	MOVWF       main_low_L0+0 
;Lab4_es1.c,40 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab4_es1.c,41 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es1.c,42 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es1.c,44 :: 		while(1){
L_main0:
;Lab4_es1.c,46 :: 		if(delay_ms_1 >= 200){
	MOVLW       128
	XORWF       _delay_ms_1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       200
	SUBWF       _delay_ms_1+0, 0 
L__main18:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;Lab4_es1.c,48 :: 		if( high == 0b1111 && low == 0b1111)
	MOVF        main_high_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	MOVF        main_low_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
L__main16:
;Lab4_es1.c,49 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main6
L_main5:
;Lab4_es1.c,50 :: 		else if ( high == 0b0000 &&  low == 0b0000)
	MOVF        main_high_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        main_low_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main15:
;Lab4_es1.c,51 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main9:
L_main6:
;Lab4_es1.c,53 :: 		if(sentinella == 0){
	MOVF        main_sentinella_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;Lab4_es1.c,54 :: 		low  <<= 1;
	RLCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 0 
;Lab4_es1.c,55 :: 		high >>= 1;
	RRCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 7 
	BTFSC       main_high_L0+0, 6 
	BSF         main_high_L0+0, 7 
;Lab4_es1.c,56 :: 		low  += 0b00000001;
	INCF        main_low_L0+0, 1 
;Lab4_es1.c,57 :: 		high += 0b00001000;
	MOVLW       8
	ADDWF       main_high_L0+0, 1 
;Lab4_es1.c,58 :: 		} else{
	GOTO        L_main11
L_main10:
;Lab4_es1.c,59 :: 		high <<= 1;
	RLCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 0 
;Lab4_es1.c,60 :: 		low  >>= 1;
	RRCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 7 
	BTFSC       main_low_L0+0, 6 
	BSF         main_low_L0+0, 7 
;Lab4_es1.c,61 :: 		high &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_high_L0+0, 1 
;Lab4_es1.c,62 :: 		low &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_low_L0+0, 1 
;Lab4_es1.c,63 :: 		}
L_main11:
;Lab4_es1.c,65 :: 		LATD = (high << 4) | low;
	MOVLW       4
	MOVWF       R1 
	MOVF        main_high_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main19:
	BZ          L__main20
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main19
L__main20:
	MOVF        main_low_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       LATD+0 
;Lab4_es1.c,66 :: 		delay_ms_1 -= 200;
	MOVLW       200
	SUBWF       _delay_ms_1+0, 1 
	MOVLW       0
	SUBWFB      _delay_ms_1+1, 1 
;Lab4_es1.c,67 :: 		}
L_main2:
;Lab4_es1.c,69 :: 		if(delay_ms_2 >= 1000){
	MOVLW       128
	XORWF       _delay_ms_2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVLW       232
	SUBWF       _delay_ms_2+0, 0 
L__main21:
	BTFSS       STATUS+0, 0 
	GOTO        L_main12
;Lab4_es1.c,70 :: 		count++;
	INCF        main_count_L0+0, 1 
;Lab4_es1.c,71 :: 		IntToStr(count,count_txt);
	MOVF        main_count_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab4_es1.c,72 :: 		Lcd_Out(1,11,count_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab4_es1.c,73 :: 		delay_ms_2 -= 1000;
	MOVLW       232
	SUBWF       _delay_ms_2+0, 1 
	MOVLW       3
	SUBWFB      _delay_ms_2+1, 1 
;Lab4_es1.c,74 :: 		}
L_main12:
;Lab4_es1.c,76 :: 		}
	GOTO        L_main0
;Lab4_es1.c,78 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab4_es1.c,80 :: 		void interrupt(){
;Lab4_es1.c,81 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt13
;Lab4_es1.c,82 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Lab4_es1.c,83 :: 		delay_ms_1 +=32;
	MOVLW       32
	ADDWF       _delay_ms_1+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_1+1, 1 
;Lab4_es1.c,84 :: 		delay_ms_2 +=32;
	MOVLW       32
	ADDWF       _delay_ms_2+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_2+1, 1 
;Lab4_es1.c,85 :: 		delay_us +=768;
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
;Lab4_es1.c,86 :: 		if (delay_us >= 1000)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt24
	MOVLW       232
	SUBWF       R1, 0 
L__interrupt24:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt14
;Lab4_es1.c,88 :: 		delay_ms_1 +=1;
	INFSNZ      _delay_ms_1+0, 1 
	INCF        _delay_ms_1+1, 1 
;Lab4_es1.c,89 :: 		delay_ms_2 +=1;
	INFSNZ      _delay_ms_2+0, 1 
	INCF        _delay_ms_2+1, 1 
;Lab4_es1.c,90 :: 		delay_us = 0;
	CLRF        _delay_us+0 
	CLRF        _delay_us+1 
;Lab4_es1.c,91 :: 		}
L_interrupt14:
;Lab4_es1.c,92 :: 		}
L_interrupt13:
;Lab4_es1.c,94 :: 		}
L_end_interrupt:
L__interrupt23:
	RETFIE      1
; end of _interrupt
