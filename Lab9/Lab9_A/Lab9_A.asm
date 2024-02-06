
_main:

;Lab9_A.c,16 :: 		void main() {
;Lab9_A.c,18 :: 		unsigned short int conteggio=0;
	CLRF        main_conteggio_L0+0 
	CLRF        main_conteggio_txt_L0+0 
	CLRF        main_conteggio_txt_L0+1 
	CLRF        main_conteggio_txt_L0+2 
	CLRF        main_conteggio_txt_L0+3 
	CLRF        main_conteggio_txt_L0+4 
	CLRF        main_conteggio_txt_L0+5 
	CLRF        main_conteggio_txt_L0+6 
;Lab9_A.c,23 :: 		ANSELA=0b11110001;
	MOVLW       241
	MOVWF       ANSELA+0 
;Lab9_A.c,26 :: 		TRISA = 0b11111111;
	MOVLW       255
	MOVWF       TRISA+0 
;Lab9_A.c,29 :: 		Lcd_Init();		// Init the display library (This will set also the PORTB Configuration)
	CALL        _Lcd_Init+0, 0
;Lab9_A.c,30 :: 		Lcd_Cmd(_LCD_CLEAR);    	// Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_A.c,31 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor OFF
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Lab9_A.c,32 :: 		Lcd_Out(1,1,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_A.c,34 :: 		while(1){
L_main0:
;Lab9_A.c,37 :: 		if((PORTA & ~stato_pb) & 0b00001000){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 3 
	GOTO        L_main2
;Lab9_A.c,38 :: 		conteggio++;
	INCF        main_conteggio_L0+0, 1 
;Lab9_A.c,39 :: 		stato_pb = stato_pb | 0b00001000;
	BSF         main_stato_pb_L0+0, 3 
;Lab9_A.c,40 :: 		IntToStr(conteggio_txt,conteggio);
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_input+1 
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_A.c,41 :: 		Lcd_Out(1,1,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_A.c,42 :: 		}
L_main2:
;Lab9_A.c,45 :: 		if((PORTA & ~stato_pb) & 0b00000010){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 1 
	GOTO        L_main3
;Lab9_A.c,46 :: 		conteggio--;
	DECF        main_conteggio_L0+0, 1 
;Lab9_A.c,47 :: 		stato_pb = stato_pb | 0b00000010;
	BSF         main_stato_pb_L0+0, 1 
;Lab9_A.c,48 :: 		IntToStr(conteggio_txt,conteggio);
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_input+1 
	MOVF        main_conteggio_L0+0, 0 
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_A.c,49 :: 		Lcd_Out(1,1,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_A.c,50 :: 		}
L_main3:
;Lab9_A.c,53 :: 		if((PORTA & ~stato_pb) & 0b00000100){
	COMF        main_stato_pb_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	BTFSS       R1, 2 
	GOTO        L_main4
;Lab9_A.c,54 :: 		conteggio = 0;
	CLRF        main_conteggio_L0+0 
;Lab9_A.c,55 :: 		stato_pb = stato_pb | 0b00000100;
	BSF         main_stato_pb_L0+0, 2 
;Lab9_A.c,56 :: 		IntToStr(conteggio_txt,conteggio);
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_IntToStr_input+1 
	CLRF        FARG_IntToStr_output+0 
	CLRF        FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Lab9_A.c,57 :: 		Lcd_Out(1,1,conteggio_txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_conteggio_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_conteggio_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_A.c,58 :: 		}
L_main4:
;Lab9_A.c,59 :: 		Lcd_Out(1,1, "ciao");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Lab9_A+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Lab9_A+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Lab9_A.c,60 :: 		stato_pb = PORTA & stato_pb;
	MOVF        PORTA+0, 0 
	ANDWF       main_stato_pb_L0+0, 1 
;Lab9_A.c,61 :: 		}
	GOTO        L_main0
;Lab9_A.c,63 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
