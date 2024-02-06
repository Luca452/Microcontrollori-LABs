
_main:

;Lab7_2.c,20 :: 		void main(){
;Lab7_2.c,22 :: 		TRISC.RC6 = 0;
	BCF         TRISC+0, 6 
;Lab7_2.c,23 :: 		LATC.RC6 = 1;
	BSF         LATC+0, 6 
;Lab7_2.c,26 :: 		ANSELC.RC2 = 0;
	BCF         ANSELC+0, 2 
;Lab7_2.c,34 :: 		CCP1CON.CCP1M3 = 0;
	BCF         CCP1CON+0, 3 
;Lab7_2.c,35 :: 		CCP1CON.CCP1M2 = 1;
	BSF         CCP1CON+0, 2 
;Lab7_2.c,36 :: 		CCP1CON.CCP1M1 = 0;
	BCF         CCP1CON+0, 1 
;Lab7_2.c,37 :: 		CCP1CON.CCP1M0 = 1;
	BSF         CCP1CON+0, 0 
;Lab7_2.c,40 :: 		CCPTMRS0.C1TSEL1 = 0;
	BCF         CCPTMRS0+0, 1 
;Lab7_2.c,41 :: 		CCPTMRS0.C1TSEL0 = 0;
	BCF         CCPTMRS0+0, 0 
;Lab7_2.c,44 :: 		T1CON = 0b00010011;
	MOVLW       19
	MOVWF       T1CON+0 
;Lab7_2.c,47 :: 		PIE1.CCP1IE = 1;
	BSF         PIE1+0, 2 
;Lab7_2.c,48 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;Lab7_2.c,51 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Lab7_2.c,53 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Lab7_2.c,56 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab7_2.c,57 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab7_2.c,58 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab7_2.c,59 :: 		Lcd_Out(1,1,"d[mm]:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab7_2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab7_2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab7_2.c,61 :: 		while(1){
L_main0:
;Lab7_2.c,62 :: 		if(!edge){
	MOVF        _edge+0, 0 
	IORWF       _edge+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;Lab7_2.c,63 :: 		IntToStr(tmr-tmr_old,tmr_char);
	MOVF        _tmr_old+0, 0 
	SUBWF       _tmr+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _tmr_old+1, 0 
	SUBWFB      _tmr+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _tmr_char+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_tmr_char+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab7_2.c,64 :: 		Lcd_Out(1,11,tmr_char);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tmr_char+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tmr_char+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab7_2.c,66 :: 		}
L_main2:
;Lab7_2.c,67 :: 		}
	GOTO        L_main0
;Lab7_2.c,68 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Lab7_2.c,70 :: 		void interrupt(){
;Lab7_2.c,71 :: 		if(PIR1.CCP1IF){
	BTFSS       PIR1+0, 2 
	GOTO        L_interrupt3
;Lab7_2.c,72 :: 		LATD++;
	MOVF        LATD+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;Lab7_2.c,73 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;Lab7_2.c,75 :: 		if(CCP1CON.CCP1M0)
	BTFSS       CCP1CON+0, 0 
	GOTO        L_interrupt4
;Lab7_2.c,76 :: 		edge = 1;
	MOVLW       1
	MOVWF       _edge+0 
	MOVLW       0
	MOVWF       _edge+1 
	GOTO        L_interrupt5
L_interrupt4:
;Lab7_2.c,78 :: 		edge = 0;
	CLRF        _edge+0 
	CLRF        _edge+1 
L_interrupt5:
;Lab7_2.c,80 :: 		CCP1CON.CCP1M0 = !CCP1CON.CCP1M0;
	BTG         CCP1CON+0, 0 
;Lab7_2.c,81 :: 		tmr_old = tmr;
	MOVF        _tmr+0, 0 
	MOVWF       _tmr_old+0 
	MOVF        _tmr+1, 0 
	MOVWF       _tmr_old+1 
;Lab7_2.c,82 :: 		tmr = (CCPR1H<<8) | CCPR1L;
	MOVF        CCPR1H+0, 0 
	MOVWF       _tmr+1 
	CLRF        _tmr+0 
	MOVF        CCPR1L+0, 0 
	IORWF       _tmr+0, 1 
	MOVLW       0
	IORWF       _tmr+1, 1 
;Lab7_2.c,83 :: 		}
L_interrupt3:
;Lab7_2.c,84 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE      1
; end of _interrupt
