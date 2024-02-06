
_main:

;Lab4_es4.c,25 :: 		void main() {
;Lab4_es4.c,27 :: 		short int sentinella = 0;
	MOVLW       ?ICSmain_sentinella_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSmain_sentinella_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSmain_sentinella_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       main_sentinella_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(main_sentinella_L0+0)
	MOVWF       FSR1H 
	MOVLW       45
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;Lab4_es4.c,39 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;Lab4_es4.c,40 :: 		LATD = 0b10000001;
	MOVLW       129
	MOVWF       LATD+0 
;Lab4_es4.c,42 :: 		TRISA = 0b00011111;
	MOVLW       31
	MOVWF       TRISA+0 
;Lab4_es4.c,43 :: 		ANSELA = 0b11100000;
	MOVLW       224
	MOVWF       ANSELA+0 
;Lab4_es4.c,45 :: 		T0CON = 0b11000110;
	MOVLW       198
	MOVWF       T0CON+0 
;Lab4_es4.c,46 :: 		INTCON = 0b10100000;
	MOVLW       160
	MOVWF       INTCON+0 
;Lab4_es4.c,48 :: 		high = 0b00001000;
	MOVLW       8
	MOVWF       main_high_L0+0 
;Lab4_es4.c,49 :: 		low  = 0b00000001;
	MOVLW       1
	MOVWF       main_low_L0+0 
;Lab4_es4.c,52 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab4_es4.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es4.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab4_es4.c,56 :: 		while(1){
L_main0:
;Lab4_es4.c,58 :: 		if(delay_ms_1 >= delay_kitt){
	MOVLW       128
	XORWF       _delay_ms_1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVF        _delay_kitt+0, 0 
	SUBWF       _delay_ms_1+0, 0 
L__main50:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;Lab4_es4.c,59 :: 		if( high == 0b1111 && low == 0b1111)
	MOVF        main_high_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
	MOVF        main_low_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
L__main46:
;Lab4_es4.c,60 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main6
L_main5:
;Lab4_es4.c,61 :: 		else if ( high == 0b0000 &&  low == 0b0000)
	MOVF        main_high_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVF        main_low_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main45:
;Lab4_es4.c,62 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main9:
L_main6:
;Lab4_es4.c,64 :: 		if(sentinella == 0){
	MOVF        main_sentinella_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
;Lab4_es4.c,65 :: 		low  <<= 1;
	RLCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 0 
;Lab4_es4.c,66 :: 		high >>= 1;
	RRCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 7 
	BTFSC       main_high_L0+0, 6 
	BSF         main_high_L0+0, 7 
;Lab4_es4.c,67 :: 		low  += 0b00000001;
	INCF        main_low_L0+0, 1 
;Lab4_es4.c,68 :: 		high += 0b00001000;
	MOVLW       8
	ADDWF       main_high_L0+0, 1 
;Lab4_es4.c,69 :: 		} else{
	GOTO        L_main11
L_main10:
;Lab4_es4.c,70 :: 		high <<= 1;
	RLCF        main_high_L0+0, 1 
	BCF         main_high_L0+0, 0 
;Lab4_es4.c,71 :: 		low  >>= 1;
	RRCF        main_low_L0+0, 1 
	BCF         main_low_L0+0, 7 
	BTFSC       main_low_L0+0, 6 
	BSF         main_low_L0+0, 7 
;Lab4_es4.c,72 :: 		high &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_high_L0+0, 1 
;Lab4_es4.c,73 :: 		low &= mask;
	MOVF        main_mask_L0+0, 0 
	ANDWF       main_low_L0+0, 1 
;Lab4_es4.c,74 :: 		}
L_main11:
;Lab4_es4.c,75 :: 		LATD = (high << 4) | low;
	MOVLW       4
	MOVWF       R1 
	MOVF        main_high_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main51:
	BZ          L__main52
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main51
L__main52:
	MOVF        main_low_L0+0, 0 
	IORWF       R0, 0 
	MOVWF       LATD+0 
;Lab4_es4.c,76 :: 		delay_ms_1 -= delay_kitt;
	MOVF        _delay_kitt+0, 0 
	SUBWF       _delay_ms_1+0, 1 
	MOVF        _delay_kitt+1, 0 
	SUBWFB      _delay_ms_1+1, 1 
;Lab4_es4.c,77 :: 		}
L_main2:
;Lab4_es4.c,80 :: 		if(delay_ms_2 >= 8){
	MOVLW       128
	XORWF       _delay_ms_2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main53
	MOVLW       8
	SUBWF       _delay_ms_2+0, 0 
L__main53:
	BTFSS       STATUS+0, 0 
	GOTO        L_main12
;Lab4_es4.c,82 :: 		if(!reset && !stop){
	MOVF        _reset+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _stop+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
L__main44:
;Lab4_es4.c,83 :: 		ora[0] += delay_ms_2;
	MOVF        _delay_ms_2+0, 0 
	ADDWF       main_ora_L0+0, 0 
	MOVWF       R1 
	MOVF        _delay_ms_2+1, 0 
	ADDWFC      main_ora_L0+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       main_ora_L0+0 
	MOVF        R2, 0 
	MOVWF       main_ora_L0+1 
;Lab4_es4.c,84 :: 		if(ora[0] >= 1000){
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main54
	MOVLW       232
	SUBWF       R1, 0 
L__main54:
	BTFSS       STATUS+0, 0 
	GOTO        L_main16
;Lab4_es4.c,85 :: 		ora[0] = 0;
	CLRF        main_ora_L0+0 
	CLRF        main_ora_L0+1 
;Lab4_es4.c,86 :: 		ora[1] += 1;
	INFSNZ      main_ora_L0+2, 1 
	INCF        main_ora_L0+3, 1 
;Lab4_es4.c,87 :: 		if(ora[1] >= 60){
	MOVLW       128
	XORWF       main_ora_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main55
	MOVLW       60
	SUBWF       main_ora_L0+2, 0 
L__main55:
	BTFSS       STATUS+0, 0 
	GOTO        L_main17
;Lab4_es4.c,88 :: 		ora[1] = 0;
	CLRF        main_ora_L0+2 
	CLRF        main_ora_L0+3 
;Lab4_es4.c,89 :: 		ora[2] += 1;
	INFSNZ      main_ora_L0+4, 1 
	INCF        main_ora_L0+5, 1 
;Lab4_es4.c,90 :: 		if(ora[2] >= 60){
	MOVLW       128
	XORWF       main_ora_L0+5, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVLW       60
	SUBWF       main_ora_L0+4, 0 
L__main56:
	BTFSS       STATUS+0, 0 
	GOTO        L_main18
;Lab4_es4.c,91 :: 		ora[2] = 0;
	CLRF        main_ora_L0+4 
	CLRF        main_ora_L0+5 
;Lab4_es4.c,92 :: 		ora[3] +=1;}
	INFSNZ      main_ora_L0+6, 1 
	INCF        main_ora_L0+7, 1 
L_main18:
;Lab4_es4.c,93 :: 		}
L_main17:
;Lab4_es4.c,94 :: 		}
L_main16:
;Lab4_es4.c,96 :: 		for (i = 3; i >= 0; i--){
	MOVLW       3
	MOVWF       main_i_L0+0 
	MOVLW       0
	MOVWF       main_i_L0+1 
L_main19:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       0
	SUBWF       main_i_L0+0, 0 
L__main57:
	BTFSS       STATUS+0, 0 
	GOTO        L_main20
;Lab4_es4.c,97 :: 		IntToStr(ora[i],count_txt);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_ora_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_ora_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab4_es4.c,98 :: 		strcat(count_txt_prec,Ltrim(count_txt));
	MOVLW       main_count_txt_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_count_txt_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        R1, 0 
	MOVWF       FARG_strcat_from+1 
	MOVLW       main_count_txt_prec_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_count_txt_prec_L0+0)
	MOVWF       FARG_strcat_to+1 
	CALL        _strcat+0, 0
;Lab4_es4.c,99 :: 		if(i!=0)
	MOVLW       0
	XORWF       main_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVLW       0
	XORWF       main_i_L0+0, 0 
L__main58:
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
;Lab4_es4.c,100 :: 		strcat(count_txt_prec,":");
	MOVLW       main_count_txt_prec_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_count_txt_prec_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_Lab4_es4+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_Lab4_es4+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_main22:
;Lab4_es4.c,96 :: 		for (i = 3; i >= 0; i--){
	MOVLW       1
	SUBWF       main_i_L0+0, 1 
	MOVLW       0
	SUBWFB      main_i_L0+1, 1 
;Lab4_es4.c,101 :: 		}
	GOTO        L_main19
L_main20:
;Lab4_es4.c,102 :: 		Lcd_Out(1,9,count_txt_prec);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_count_txt_prec_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_count_txt_prec_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab4_es4.c,103 :: 		for (i = 0; i < 17; i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main23:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main59
	MOVLW       17
	SUBWF       main_i_L0+0, 0 
L__main59:
	BTFSC       STATUS+0, 0 
	GOTO        L_main24
;Lab4_es4.c,104 :: 		count_txt_prec[i]=0;
	MOVLW       main_count_txt_prec_L0+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_count_txt_prec_L0+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Lab4_es4.c,103 :: 		for (i = 0; i < 17; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;Lab4_es4.c,104 :: 		count_txt_prec[i]=0;
	GOTO        L_main23
L_main24:
;Lab4_es4.c,105 :: 		}
L_main15:
;Lab4_es4.c,107 :: 		if(reset){
	MOVF        _reset+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
;Lab4_es4.c,108 :: 		for (i = 0; i < 4; i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main27:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main60
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
L__main60:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
;Lab4_es4.c,109 :: 		ora[i] = 0;
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_ora_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(main_ora_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Lab4_es4.c,108 :: 		for (i = 0; i < 4; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;Lab4_es4.c,109 :: 		ora[i] = 0;
	GOTO        L_main27
L_main28:
;Lab4_es4.c,110 :: 		Lcd_Out(1,9,reset_string);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_reset_string_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_reset_string_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab4_es4.c,111 :: 		}
L_main26:
;Lab4_es4.c,113 :: 		delay_ms_2 -= 8;
	MOVLW       8
	SUBWF       _delay_ms_2+0, 1 
	MOVLW       0
	SUBWFB      _delay_ms_2+1, 1 
;Lab4_es4.c,114 :: 		}
L_main12:
;Lab4_es4.c,116 :: 		}
	GOTO        L_main0
;Lab4_es4.c,118 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab4_es4.c,120 :: 		void interrupt(){
;Lab4_es4.c,122 :: 		if (PORTA.RA3 && delay_kitt<1000)
	BTFSS       PORTA+0, 3 
	GOTO        L_interrupt32
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt63
	MOVLW       232
	SUBWF       _delay_kitt+0, 0 
L__interrupt63:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt32
L__interrupt48:
;Lab4_es4.c,123 :: 		delay_kitt +=20;
	MOVLW       20
	ADDWF       _delay_kitt+0, 1 
	MOVLW       0
	ADDWFC      _delay_kitt+1, 1 
	GOTO        L_interrupt33
L_interrupt32:
;Lab4_es4.c,124 :: 		else if (PORTA.RA4 && delay_kitt>20)
	BTFSS       PORTA+0, 4 
	GOTO        L_interrupt36
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _delay_kitt+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt64
	MOVF        _delay_kitt+0, 0 
	SUBLW       20
L__interrupt64:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt36
L__interrupt47:
;Lab4_es4.c,125 :: 		delay_kitt -=20;
	MOVLW       20
	SUBWF       _delay_kitt+0, 1 
	MOVLW       0
	SUBWFB      _delay_kitt+1, 1 
L_interrupt36:
L_interrupt33:
;Lab4_es4.c,127 :: 		if (PORTA.RA2){ //precedenza al reset
	BTFSS       PORTA+0, 2 
	GOTO        L_interrupt37
;Lab4_es4.c,128 :: 		stop = 0;
	CLRF        _stop+0 
;Lab4_es4.c,129 :: 		reset = 1;}
	MOVLW       1
	MOVWF       _reset+0 
	GOTO        L_interrupt38
L_interrupt37:
;Lab4_es4.c,130 :: 		else if (PORTA.RA1){ //poi stop
	BTFSS       PORTA+0, 1 
	GOTO        L_interrupt39
;Lab4_es4.c,131 :: 		stop = 1;
	MOVLW       1
	MOVWF       _stop+0 
;Lab4_es4.c,132 :: 		reset = 0;}
	CLRF        _reset+0 
	GOTO        L_interrupt40
L_interrupt39:
;Lab4_es4.c,133 :: 		else if (PORTA.RA0){ //infine start
	BTFSS       PORTA+0, 0 
	GOTO        L_interrupt41
;Lab4_es4.c,134 :: 		stop = 0;
	CLRF        _stop+0 
;Lab4_es4.c,135 :: 		reset = 0;}
	CLRF        _reset+0 
L_interrupt41:
L_interrupt40:
L_interrupt38:
;Lab4_es4.c,138 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt42
;Lab4_es4.c,139 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;Lab4_es4.c,140 :: 		delay_ms_1 +=8;
	MOVLW       8
	ADDWF       _delay_ms_1+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_1+1, 1 
;Lab4_es4.c,141 :: 		delay_ms_2 +=8;
	MOVLW       8
	ADDWF       _delay_ms_2+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms_2+1, 1 
;Lab4_es4.c,142 :: 		delay_us +=192;
	MOVLW       192
	ADDWF       _delay_us+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _delay_us+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _delay_us+0 
	MOVF        R2, 0 
	MOVWF       _delay_us+1 
;Lab4_es4.c,143 :: 		if (delay_us >= 1000)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt65
	MOVLW       232
	SUBWF       R1, 0 
L__interrupt65:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt43
;Lab4_es4.c,145 :: 		delay_ms_1 +=1;
	INFSNZ      _delay_ms_1+0, 1 
	INCF        _delay_ms_1+1, 1 
;Lab4_es4.c,146 :: 		delay_ms_2 +=1;
	INFSNZ      _delay_ms_2+0, 1 
	INCF        _delay_ms_2+1, 1 
;Lab4_es4.c,147 :: 		delay_us = 0;
	CLRF        _delay_us+0 
	CLRF        _delay_us+1 
;Lab4_es4.c,148 :: 		}
L_interrupt43:
;Lab4_es4.c,149 :: 		}
L_interrupt42:
;Lab4_es4.c,151 :: 		}
L_end_interrupt:
L__interrupt62:
	RETFIE      1
; end of _interrupt
