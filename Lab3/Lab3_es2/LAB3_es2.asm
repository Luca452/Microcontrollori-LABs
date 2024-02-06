
_main:

;LAB3_es2.c,23 :: 		void main() {
;LAB3_es2.c,24 :: 		short int sentinella=0;
	CLRF        main_sentinella_L0+0 
;LAB3_es2.c,25 :: 		TRISB = 0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;LAB3_es2.c,26 :: 		ANSELB = 0x3F;
	MOVLW       63
	MOVWF       ANSELB+0 
;LAB3_es2.c,28 :: 		IOCB = 0b11000000;
	MOVLW       192
	MOVWF       IOCB+0 
;LAB3_es2.c,29 :: 		INTCON = 0b10101000;
	MOVLW       168
	MOVWF       INTCON+0 
;LAB3_es2.c,31 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;LAB3_es2.c,32 :: 		LATD = 0x01;
	MOVLW       1
	MOVWF       LATD+0 
;LAB3_es2.c,34 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;LAB3_es2.c,37 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;LAB3_es2.c,38 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB3_es2.c,39 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB3_es2.c,41 :: 		while(1){
L_main0:
;LAB3_es2.c,43 :: 		if(delay_ms >= dly){
	MOVLW       128
	XORWF       _delay_ms+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _dly+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        _dly+0, 0 
	SUBWF       _delay_ms+0, 0 
L__main23:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;LAB3_es2.c,45 :: 		if(LATD == 0b10000000)
	MOVF        LATD+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;LAB3_es2.c,46 :: 		sentinella = 1;
	MOVLW       1
	MOVWF       main_sentinella_L0+0 
	GOTO        L_main4
L_main3:
;LAB3_es2.c,47 :: 		else if(LATD == 0b00000001)
	MOVF        LATD+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;LAB3_es2.c,48 :: 		sentinella = 0;
	CLRF        main_sentinella_L0+0 
L_main5:
L_main4:
;LAB3_es2.c,50 :: 		if(!sentinella)
	MOVF        main_sentinella_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
;LAB3_es2.c,51 :: 		LATD <<= 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
	GOTO        L_main7
L_main6:
;LAB3_es2.c,53 :: 		LATD >>= 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
L_main7:
;LAB3_es2.c,54 :: 		delay_ms -= dly ;
	MOVF        _dly+0, 0 
	SUBWF       _delay_ms+0, 1 
	MOVF        _dly+1, 0 
	SUBWFB      _delay_ms+1, 1 
;LAB3_es2.c,56 :: 		}
L_main2:
;LAB3_es2.c,57 :: 		if (delay_ms2 >= dly)
	MOVLW       128
	XORWF       _delay_ms2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _dly+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVF        _dly+0, 0 
	SUBWF       _delay_ms2+0, 0 
L__main24:
	BTFSS       STATUS+0, 0 
	GOTO        L_main8
;LAB3_es2.c,59 :: 		count++;
	INCF        _count+0, 1 
;LAB3_es2.c,60 :: 		IntToStr(count,count_txt);
	MOVF        _count+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	BTFSC       _count+0, 7 
	MOVLW       255
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _count_txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_count_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB3_es2.c,61 :: 		Lcd_Out(1,11,count_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _count_txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_count_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB3_es2.c,62 :: 		delay_ms2 -= dly;
	MOVF        _dly+0, 0 
	SUBWF       _delay_ms2+0, 1 
	MOVF        _dly+1, 0 
	SUBWFB      _delay_ms2+1, 1 
;LAB3_es2.c,63 :: 		}
L_main8:
;LAB3_es2.c,64 :: 		}
	GOTO        L_main0
;LAB3_es2.c,65 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB3_es2.c,67 :: 		void interrupt(){
;LAB3_es2.c,69 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt9
;LAB3_es2.c,71 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LAB3_es2.c,72 :: 		delay_ms +=32;
	MOVLW       32
	ADDWF       _delay_ms+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms+1, 1 
;LAB3_es2.c,73 :: 		delay_ms2 +=32;
	MOVLW       32
	ADDWF       _delay_ms2+0, 1 
	MOVLW       0
	ADDWFC      _delay_ms2+1, 1 
;LAB3_es2.c,74 :: 		delay_us +=768;
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
;LAB3_es2.c,75 :: 		if (delay_us >= 1000)
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt27
	MOVLW       232
	SUBWF       R1, 0 
L__interrupt27:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt10
;LAB3_es2.c,77 :: 		delay_ms +=1;
	INFSNZ      _delay_ms+0, 1 
	INCF        _delay_ms+1, 1 
;LAB3_es2.c,78 :: 		delay_ms2 +=1;
	INFSNZ      _delay_ms2+0, 1 
	INCF        _delay_ms2+1, 1 
;LAB3_es2.c,79 :: 		delay_us = 0;
	CLRF        _delay_us+0 
	CLRF        _delay_us+1 
;LAB3_es2.c,80 :: 		}
L_interrupt10:
;LAB3_es2.c,81 :: 		}
	GOTO        L_interrupt11
L_interrupt9:
;LAB3_es2.c,84 :: 		else if(INTCON.RBIF){
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt12
;LAB3_es2.c,85 :: 		if(PORTB.RB7 && dly<1000)
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt15
	MOVLW       128
	XORWF       _dly+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       3
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt28
	MOVLW       232
	SUBWF       _dly+0, 0 
L__interrupt28:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt15
L__interrupt21:
;LAB3_es2.c,86 :: 		dly += 50;
	MOVLW       50
	ADDWF       _dly+0, 1 
	MOVLW       0
	ADDWFC      _dly+1, 1 
	GOTO        L_interrupt16
L_interrupt15:
;LAB3_es2.c,87 :: 		else if(PORTB.RB6 && dly>50)
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt19
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _dly+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt29
	MOVF        _dly+0, 0 
	SUBLW       50
L__interrupt29:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt19
L__interrupt20:
;LAB3_es2.c,88 :: 		dly -= 50;
	MOVLW       50
	SUBWF       _dly+0, 1 
	MOVLW       0
	SUBWFB      _dly+1, 1 
L_interrupt19:
L_interrupt16:
;LAB3_es2.c,89 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;LAB3_es2.c,90 :: 		}
L_interrupt12:
L_interrupt11:
;LAB3_es2.c,91 :: 		}
L_end_interrupt:
L__interrupt26:
	RETFIE      1
; end of _interrupt
