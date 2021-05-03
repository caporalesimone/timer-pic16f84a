;  ASM code generated by mikroVirtualMachine for PIC - V. 6.2.1.0
;  Date/Time: 16/11/2008 16.41.14
;  Info: http://www.mikroelektronika.co.yu


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$28D3			GOTO	_main
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$0095			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$0094			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$0096			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
;Timer.c,29 :: 		void interrupt() {
;Timer.c,30 :: 		uiContTmp++;
$000D	$0A8C			INCF	_uiContTmp, 1
$000E	$1903			BTFSC	STATUS, Z
$000F	$0A8D			INCF	_uiContTmp+1, 1
;Timer.c,31 :: 		TMR0 = 96;
$0010	$3060			MOVLW	96
$0011	$0081			MOVWF	TMR0
;Timer.c,32 :: 		INTCON = 0x20;       // Set T0IE, clear T0IF
$0012	$3020			MOVLW	32
$0013	$008B			MOVWF	INTCON
;Timer.c,33 :: 		}
$0014	$	L_Interrupt_end:
$0014	$0816			MOVF	?savePCLATH, 0
$0015	$008A			MOVWF	PCLATH
$0016	$0814			MOVF	?saveFSR, 0
$0017	$0084			MOVWF	FSR
$0018	$0E15			SWAPF	?saveSTATUS, 0
$0019	$0083			MOVWF	STATUS
$001A	$0ECF			SWAPF	STACK_15, 1
$001B	$0E4F			SWAPF	STACK_15, 0
$001C	$0009			RETFIE
$001D	$	_Div_16x16_U:
$001D	$1303			BCF	STATUS, RP1
$001E	$1283			BCF	STATUS, RP0
$001F	$01C8			CLRF	STACK_8
$0020	$01C9			CLRF	STACK_9
$0021	$3010			MOVLW	16
$0022	$00CC			MOVWF	STACK_12
$0023	$0D41			RLF	STACK_1, W
$0024	$0DC8			RLF	STACK_8, F
$0025	$0DC9			RLF	STACK_9, F
$0026	$0844			MOVF	STACK_4, W
$0027	$02C8			SUBWF	STACK_8, F
$0028	$0845			MOVF	STACK_5, W
$0029	$1C03			BTFSS	STATUS, C
$002A	$0F45			INCFSZ	STACK_5, W
$002B	$02C9			SUBWF	STACK_9, F
$002C	$1803			BTFSC	STATUS, C
$002D	$2835			GOTO	$+8
$002E	$0844			MOVF	STACK_4, W
$002F	$07C8			ADDWF	STACK_8, F
$0030	$0845			MOVF	STACK_5, W
$0031	$1803			BTFSC	STATUS, C
$0032	$0F45			INCFSZ	STACK_5, W
$0033	$07C9			ADDWF	STACK_9, F
$0034	$1003			BCF	STATUS, C
$0035	$0DC0			RLF	STACK_0, F
$0036	$0DC1			RLF	STACK_1, F
$0037	$0BCC			DECFSZ	STACK_12, F
$0038	$2823			GOTO	$-21
$0039	$0008			RETURN
$003A	$	_EEprom_read:
$003A	$1303			BCF	STATUS, RP1
$003B	$1283			BCF	STATUS, RP0
$003C	$081E			MOVF	FARG_EEprom_read+0, 0
$003D	$0089			MOVWF	EEADR
$003E	$1683			BSF	STATUS, RP0
$003F	$1388			BCF	EECON1, 7
$0040	$1408			BSF	EECON1, 0
$0041	$1283			BCF	STATUS, RP0
$0042	$0808			MOVF	EEDATA, 0
$0043	$00C0			MOVWF	STACK_0
$0044	$0008			RETURN
$0045	$	_DisplayNum:
;Timer.c,36 :: 		void DisplayNum (void) {
;Timer.c,43 :: 		if (uiSecondi_Attuale > 0)  {
$0045	$3080			MOVLW	128
$0046	$1303			BCF	STATUS, RP1
$0047	$1283			BCF	STATUS, RP0
$0048	$00C0			MOVWF	STACK_0
$0049	$3080			MOVLW	128
$004A	$060F			XORWF	_uiSecondi_Attuale+1, 0
$004B	$0240			SUBWF	STACK_0, 0
$004C	$1D03			BTFSS	STATUS, Z
$004D	$2850			GOTO	L_DisplayNum_55
$004E	$080E			MOVF	_uiSecondi_Attuale, 0
$004F	$3C00			SUBLW	0
$0050	$	L_DisplayNum_55:
$0050	$1803			BTFSC	STATUS, C
$0051	$2889			GOTO	L_DisplayNum_0
;Timer.c,46 :: 		ucSecondi_Minuti = uiSecondi / 60;
$0052	$303C			MOVLW	60
$0053	$00C4			MOVWF	STACK_4
$0054	$3000			MOVLW	0
$0055	$00C5			MOVWF	STACK_4+1
$0056	$080E			MOVF	_uiSecondi_Attuale, 0
$0057	$00C0			MOVWF	STACK_0
$0058	$080F			MOVF	_uiSecondi_Attuale+1, 0
$0059	$00C1			MOVWF	STACK_0+1
$005A	$201D			CALL	_div_16x16_u
$005B	$0840			MOVF	STACK_0, 0
$005C	$00A0			MOVWF	DisplayNum_ucSecondi_Minuti_L0
;Timer.c,47 :: 		uiSecondi =  uiSecondi % 60;
$005D	$303C			MOVLW	60
$005E	$00C4			MOVWF	STACK_4
$005F	$3000			MOVLW	0
$0060	$00C5			MOVWF	STACK_4+1
$0061	$080E			MOVF	_uiSecondi_Attuale, 0
$0062	$00C0			MOVWF	STACK_0
$0063	$080F			MOVF	_uiSecondi_Attuale+1, 0
$0064	$00C1			MOVWF	STACK_0+1
$0065	$201D			CALL	_div_16x16_u
$0066	$0848			MOVF	STACK_8, 0
$0067	$00C0			MOVWF	STACK_0
$0068	$0849			MOVF	STACK_9, 0
$0069	$00C1			MOVWF	STACK_1
$006A	$0840			MOVF	STACK_0, 0
$006B	$00A1			MOVWF	FLOC_DisplayNum+3
$006C	$0841			MOVF	STACK_0+1, 0
$006D	$00A2			MOVWF	FLOC_DisplayNum+4
;Timer.c,48 :: 		ucSecondi_Decine = uiSecondi / 10;
$006E	$300A			MOVLW	10
$006F	$00C4			MOVWF	STACK_4
$0070	$3000			MOVLW	0
$0071	$00C5			MOVWF	STACK_4+1
$0072	$0821			MOVF	FLOC_DisplayNum+3, 0
$0073	$00C0			MOVWF	STACK_0
$0074	$0822			MOVF	FLOC_DisplayNum+4, 0
$0075	$00C1			MOVWF	STACK_0+1
$0076	$201D			CALL	_div_16x16_u
$0077	$0840			MOVF	STACK_0, 0
$0078	$009F			MOVWF	DisplayNum_ucSecondi_Decine_L0
;Timer.c,49 :: 		ucSecondi_Unita = uiSecondi % 10;
$0079	$300A			MOVLW	10
$007A	$00C4			MOVWF	STACK_4
$007B	$3000			MOVLW	0
$007C	$00C5			MOVWF	STACK_4+1
$007D	$0821			MOVF	FLOC_DisplayNum+3, 0
$007E	$00C0			MOVWF	STACK_0
$007F	$0822			MOVF	FLOC_DisplayNum+4, 0
$0080	$00C1			MOVWF	STACK_0+1
$0081	$201D			CALL	_div_16x16_u
$0082	$0848			MOVF	STACK_8, 0
$0083	$00C0			MOVWF	STACK_0
$0084	$0849			MOVF	STACK_9, 0
$0085	$00C1			MOVWF	STACK_1
$0086	$0840			MOVF	STACK_0, 0
$0087	$009E			MOVWF	DisplayNum_ucSecondi_Unita_L0
;Timer.c,50 :: 		}
$0088	$288C			GOTO	L_DisplayNum_1
$0089	$	L_DisplayNum_0:
;Timer.c,53 :: 		ucSecondi_Minuti = 0;
$0089	$01A0			CLRF	DisplayNum_ucSecondi_Minuti_L0, 1
;Timer.c,54 :: 		ucSecondi_Decine = 0;
$008A	$019F			CLRF	DisplayNum_ucSecondi_Decine_L0, 1
;Timer.c,55 :: 		ucSecondi_Unita = 0;
$008B	$019E			CLRF	DisplayNum_ucSecondi_Unita_L0, 1
;Timer.c,56 :: 		}
$008C	$	L_DisplayNum_1:
;Timer.c,58 :: 		switch(ucNumDisplay)
$008C	$28A8			GOTO	L_DisplayNum_2
;Timer.c,60 :: 		case 0: // Display delle unit� di secondi
$008D	$	L_DisplayNum_4:
;Timer.c,61 :: 		DISPLAY_VALUE = ucSecondi_Unita;
$008D	$081E			MOVF	DisplayNum_ucSecondi_Unita_L0, 0
$008E	$0086			MOVWF	PORTB
;Timer.c,62 :: 		DISPLAY_VALUE = DISPLAY_VALUE + 16 + ucOutEnabled;
$008F	$3010			MOVLW	16
$0090	$0706			ADDWF	PORTB, 0
$0091	$00C0			MOVWF	STACK_0
$0092	$0811			MOVF	_ucOutEnabled, 0
$0093	$0740			ADDWF	STACK_0, 0
$0094	$0086			MOVWF	PORTB
;Timer.c,63 :: 		break;
$0095	$28B4			GOTO	L_DisplayNum_3
;Timer.c,64 :: 		case 1: // Display delle decine di secondi
$0096	$	L_DisplayNum_5:
;Timer.c,65 :: 		DISPLAY_VALUE = ucSecondi_Decine;
$0096	$081F			MOVF	DisplayNum_ucSecondi_Decine_L0, 0
$0097	$0086			MOVWF	PORTB
;Timer.c,66 :: 		DISPLAY_VALUE = DISPLAY_VALUE + 32 + ucOutEnabled;
$0098	$3020			MOVLW	32
$0099	$0706			ADDWF	PORTB, 0
$009A	$00C0			MOVWF	STACK_0
$009B	$0811			MOVF	_ucOutEnabled, 0
$009C	$0740			ADDWF	STACK_0, 0
$009D	$0086			MOVWF	PORTB
;Timer.c,67 :: 		break;
$009E	$28B4			GOTO	L_DisplayNum_3
;Timer.c,68 :: 		case 2: // Display dei minuti
$009F	$	L_DisplayNum_6:
;Timer.c,69 :: 		DISPLAY_VALUE = ucSecondi_Minuti;
$009F	$0820			MOVF	DisplayNum_ucSecondi_Minuti_L0, 0
$00A0	$0086			MOVWF	PORTB
;Timer.c,70 :: 		DISPLAY_VALUE = DISPLAY_VALUE + 64 + ucOutEnabled;
$00A1	$3040			MOVLW	64
$00A2	$0706			ADDWF	PORTB, 0
$00A3	$00C0			MOVWF	STACK_0
$00A4	$0811			MOVF	_ucOutEnabled, 0
$00A5	$0740			ADDWF	STACK_0, 0
$00A6	$0086			MOVWF	PORTB
;Timer.c,71 :: 		break;
$00A7	$28B4			GOTO	L_DisplayNum_3
;Timer.c,72 :: 		}
$00A8	$	L_DisplayNum_2:
$00A8	$0810			MOVF	_ucNumDisplay, 0
$00A9	$3A00			XORLW	0
$00AA	$1903			BTFSC	STATUS, Z
$00AB	$288D			GOTO	L_DisplayNum_4
$00AC	$0810			MOVF	_ucNumDisplay, 0
$00AD	$3A01			XORLW	1
$00AE	$1903			BTFSC	STATUS, Z
$00AF	$2896			GOTO	L_DisplayNum_5
$00B0	$0810			MOVF	_ucNumDisplay, 0
$00B1	$3A02			XORLW	2
$00B2	$1903			BTFSC	STATUS, Z
$00B3	$289F			GOTO	L_DisplayNum_6
$00B4	$	L_DisplayNum_3:
;Timer.c,73 :: 		ucNumDisplay++;
$00B4	$0A90			INCF	_ucNumDisplay, 1
;Timer.c,74 :: 		if (ucNumDisplay >= 3) ucNumDisplay = 0;
$00B5	$3003			MOVLW	3
$00B6	$0210			SUBWF	_ucNumDisplay, 0
$00B7	$1C03			BTFSS	STATUS, C
$00B8	$28BA			GOTO	L_DisplayNum_7
$00B9	$0190			CLRF	_ucNumDisplay, 1
$00BA	$	L_DisplayNum_7:
;Timer.c,75 :: 		} // END void DisplayNum (void)
$00BA	$0008			RETURN
$00BB	$	_EEprom_write:
$00BB	$0000			NOP
$00BC	$	L_EEprom_write_0:
$00BC	$1303			BCF	STATUS, RP1
$00BD	$1683			BSF	STATUS, RP0
$00BE	$1C88			BTFSS	EECON1, 1
$00BF	$28C2			GOTO	L_EEprom_write_1
$00C0	$0000			NOP
$00C1	$28BC			GOTO	L_EEprom_write_0
$00C2	$	L_EEprom_write_1:
$00C2	$081E			MOVF	FARG_EEprom_write+0, 0
$00C3	$1283			BCF	STATUS, RP0
$00C4	$0089			MOVWF	EEADR
$00C5	$081F			MOVF	FARG_EEprom_write+1, 0
$00C6	$0088			MOVWF	EEDATA
$00C7	$1683			BSF	STATUS, RP0
$00C8	$1388			BCF	EECON1, 7
$00C9	$1508			BSF	EECON1, 2
$00CA	$138B			BCF	INTCON, 7
$00CB	$3055			MOVLW	85
$00CC	$0089			MOVWF	EECON2
$00CD	$30AA			MOVLW	170
$00CE	$0089			MOVWF	EECON2
$00CF	$1488			BSF	EECON1, 1
$00D0	$178B			BSF	INTCON, 7
$00D1	$1108			BCF	EECON1, 2
$00D2	$0008			RETURN
$00D3	$	_main:
;Timer.c,78 :: 		void main (void) {
;Timer.c,88 :: 		PORTB = 0;
$00D3	$1303			BCF	STATUS, RP1
$00D4	$1283			BCF	STATUS, RP0
$00D5	$0186			CLRF	PORTB, 1
;Timer.c,89 :: 		PORTA = 0;
$00D6	$0185			CLRF	PORTA, 1
;Timer.c,90 :: 		TRISA = 0xFF; // INPUT
$00D7	$30FF			MOVLW	255
$00D8	$1683			BSF	STATUS, RP0
$00D9	$0085			MOVWF	TRISA
;Timer.c,91 :: 		TRISB = 0x00; // OUTPUT
$00DA	$0186			CLRF	TRISB, 1
;Timer.c,94 :: 		OPTION_REG = 0x84;   // Assign prescaler to TMR0
$00DB	$3084			MOVLW	132
$00DC	$0081			MOVWF	OPTION_REG
;Timer.c,95 :: 		uiContTmp = 0;
$00DD	$018C			CLRF	_uiContTmp
$00DE	$018D			CLRF	_uiContTmp+1
;Timer.c,96 :: 		TMR0 = 96;
$00DF	$3060			MOVLW	96
$00E0	$1283			BCF	STATUS, RP0
$00E1	$0081			MOVWF	TMR0
;Timer.c,102 :: 		uiSecondi_Fine = Eeprom_Read(1);
$00E2	$3001			MOVLW	1
$00E3	$009E			MOVWF	FARG_EEprom_read+0
$00E4	$203A			CALL	_EEprom_read
$00E5	$0840			MOVF	STACK_0, 0
$00E6	$0092			MOVWF	_uiSecondi_Fine
$00E7	$0193			CLRF	_uiSecondi_Fine+1
;Timer.c,103 :: 		Delay_ms(250);
$00E8	$3002			MOVLW	2
$00E9	$00CC			MOVWF	STACK_12
$00EA	$30FF			MOVLW	255
$00EB	$00CB			MOVWF	STACK_11
$00EC	$30FF			MOVLW	255
$00ED	$00CA			MOVWF	STACK_10
$00EE	$0BCC			DECFSZ	STACK_12, F
$00EF	$28F1			GOTO	$+2
$00F0	$28F8			GOTO	$+8
$00F1	$0BCB			DECFSZ	STACK_11, F
$00F2	$28F4			GOTO	$+2
$00F3	$28F7			GOTO	$+4
$00F4	$0BCA			DECFSZ	STACK_10, F
$00F5	$28F4			GOTO	$-1
$00F6	$28F1			GOTO	$-5
$00F7	$28EE			GOTO	$-9
$00F8	$3046			MOVLW	70
$00F9	$00CB			MOVWF	STACK_11
$00FA	$30FF			MOVLW	255
$00FB	$00CA			MOVWF	STACK_10
$00FC	$0BCB			DECFSZ	STACK_11, F
$00FD	$28FF			GOTO	$+2
$00FE	$2902			GOTO	$+4
$00FF	$0BCA			DECFSZ	STACK_10, F
$0100	$28FF			GOTO	$-1
$0101	$28FC			GOTO	$-5
$0102	$30CF			MOVLW	207
$0103	$00CA			MOVWF	STACK_10
$0104	$0BCA			DECFSZ	STACK_10, F
$0105	$2904			GOTO	$-1
$0106	$0000			NOP
;Timer.c,104 :: 		uiSecondi_Fine = uiSecondi_Fine + (256 * Eeprom_Read(3));
$0107	$3003			MOVLW	3
$0108	$009E			MOVWF	FARG_EEprom_read+0
$0109	$203A			CALL	_EEprom_read
$010A	$0840			MOVF	STACK_0, 0
$010B	$00C1			MOVWF	STACK_0+1
$010C	$01C0			CLRF	STACK_0
$010D	$0840			MOVF	STACK_0, 0
$010E	$0712			ADDWF	_uiSecondi_Fine, 0
$010F	$00C2			MOVWF	STACK_2
$0110	$0813			MOVF	_uiSecondi_Fine+1, 0
$0111	$1803			BTFSC	STATUS, C
$0112	$3F01			ADDLW	1
$0113	$0741			ADDWF	STACK_0+1, 0
$0114	$00C3			MOVWF	STACK_2+1
$0115	$0842			MOVF	STACK_2, 0
$0116	$0092			MOVWF	_uiSecondi_Fine
$0117	$0843			MOVF	STACK_2+1, 0
$0118	$0093			MOVWF	_uiSecondi_Fine+1
;Timer.c,105 :: 		if (uiSecondi_Fine >= 585) uiSecondi_Fine = 585;
$0119	$3002			MOVLW	2
$011A	$0243			SUBWF	STACK_2+1, 0
$011B	$1D03			BTFSS	STATUS, Z
$011C	$291F			GOTO	L_main_56
$011D	$3049			MOVLW	73
$011E	$0242			SUBWF	STACK_2, 0
$011F	$	L_main_56:
$011F	$1C03			BTFSS	STATUS, C
$0120	$2925			GOTO	L_main_8
$0121	$3049			MOVLW	73
$0122	$0092			MOVWF	_uiSecondi_Fine
$0123	$3002			MOVLW	2
$0124	$0093			MOVWF	_uiSecondi_Fine+1
$0125	$	L_main_8:
;Timer.c,109 :: 		uiSecondi_Attuale = uiSecondi_Fine; // Setto il contatore dei secondi trascorsi
$0125	$0812			MOVF	_uiSecondi_Fine, 0
$0126	$008E			MOVWF	_uiSecondi_Attuale
$0127	$0813			MOVF	_uiSecondi_Fine+1, 0
$0128	$008F			MOVWF	_uiSecondi_Attuale+1
;Timer.c,110 :: 		ucOutEnabled = 0; // Uscita disattivata (Carico spento)
$0129	$0191			CLRF	_ucOutEnabled, 1
;Timer.c,112 :: 		uiMaxInterrupt = 187;
$012A	$30BB			MOVLW	187
$012B	$009C			MOVWF	main_uiMaxInterrupt_L0
$012C	$019D			CLRF	main_uiMaxInterrupt_L0+1
;Timer.c,114 :: 		while (1)
$012D	$	L_main_9:
;Timer.c,116 :: 		DisplayNum();
$012D	$1303			BCF	STATUS, RP1
$012E	$1283			BCF	STATUS, RP0
$012F	$2045			CALL	_DisplayNum
;Timer.c,119 :: 		if (PORTA.F0 == 0)
$0130	$3001			MOVLW	1
$0131	$0505			ANDWF	PORTA, 0
$0132	$00C2			MOVWF	STACK_2
$0133	$0842			MOVF	STACK_2, 0
$0134	$3A00			XORLW	0
$0135	$1D03			BTFSS	STATUS, Z
$0136	$2994			GOTO	L_main_11
;Timer.c,122 :: 		while (PORTA.F0 == 0) { }
$0137	$	L_main_12:
$0137	$3001			MOVLW	1
$0138	$0505			ANDWF	PORTA, 0
$0139	$00C2			MOVWF	STACK_2
$013A	$0842			MOVF	STACK_2, 0
$013B	$3A00			XORLW	0
$013C	$1903			BTFSC	STATUS, Z
$013D	$2937			GOTO	L_main_12
$013E	$	L_main_13:
;Timer.c,124 :: 		INTCON = 0xA0;       // Enable TMRO interrupt
$013E	$30A0			MOVLW	160
$013F	$008B			MOVWF	INTCON
;Timer.c,125 :: 		uiSecondi_Attuale = uiSecondi_Fine;
$0140	$0812			MOVF	_uiSecondi_Fine, 0
$0141	$008E			MOVWF	_uiSecondi_Attuale
$0142	$0813			MOVF	_uiSecondi_Fine+1, 0
$0143	$008F			MOVWF	_uiSecondi_Attuale+1
;Timer.c,126 :: 		while (uiSecondi_Attuale > 0)
$0144	$	L_main_14:
$0144	$3080			MOVLW	128
$0145	$00C0			MOVWF	STACK_0
$0146	$3080			MOVLW	128
$0147	$060F			XORWF	_uiSecondi_Attuale+1, 0
$0148	$0240			SUBWF	STACK_0, 0
$0149	$1D03			BTFSS	STATUS, Z
$014A	$294D			GOTO	L_main_57
$014B	$080E			MOVF	_uiSecondi_Attuale, 0
$014C	$3C00			SUBLW	0
$014D	$	L_main_57:
$014D	$1803			BTFSC	STATUS, C
$014E	$298E			GOTO	L_main_15
;Timer.c,128 :: 		ucOutEnabled = 128; // Abilita l'output (Relay)
$014F	$3080			MOVLW	128
$0150	$0091			MOVWF	_ucOutEnabled
;Timer.c,129 :: 		DisplayNum();
$0151	$2045			CALL	_DisplayNum
;Timer.c,131 :: 		if (uiContTmp >= uiMaxInterrupt)  // Era 200 per un secondo
$0152	$081D			MOVF	main_uiMaxInterrupt_L0+1, 0
$0153	$020D			SUBWF	_uiContTmp+1, 0
$0154	$1D03			BTFSS	STATUS, Z
$0155	$2958			GOTO	L_main_58
$0156	$081C			MOVF	main_uiMaxInterrupt_L0, 0
$0157	$020C			SUBWF	_uiContTmp, 0
$0158	$	L_main_58:
$0158	$1C03			BTFSS	STATUS, C
$0159	$296E			GOTO	L_main_16
;Timer.c,133 :: 		uiSecondi_Attuale--;
$015A	$3001			MOVLW	1
$015B	$028E			SUBWF	_uiSecondi_Attuale, 1
$015C	$1C03			BTFSS	STATUS, C
$015D	$038F			DECF	_uiSecondi_Attuale+1, 1
;Timer.c,134 :: 		uiContTmp = 0;
$015E	$018C			CLRF	_uiContTmp
$015F	$018D			CLRF	_uiContTmp+1
;Timer.c,137 :: 		if (uiSecondi_Attuale < 120) uiMaxInterrupt = 180;
$0160	$3080			MOVLW	128
$0161	$060F			XORWF	_uiSecondi_Attuale+1, 0
$0162	$00C0			MOVWF	STACK_0
$0163	$3080			MOVLW	128
$0164	$0240			SUBWF	STACK_0, 0
$0165	$1D03			BTFSS	STATUS, Z
$0166	$2969			GOTO	L_main_59
$0167	$3078			MOVLW	120
$0168	$020E			SUBWF	_uiSecondi_Attuale, 0
$0169	$	L_main_59:
$0169	$1803			BTFSC	STATUS, C
$016A	$296E			GOTO	L_main_17
$016B	$30B4			MOVLW	180
$016C	$009C			MOVWF	main_uiMaxInterrupt_L0
$016D	$019D			CLRF	main_uiMaxInterrupt_L0+1
$016E	$	L_main_17:
;Timer.c,138 :: 		}
$016E	$	L_main_16:
;Timer.c,142 :: 		if ((PORTA.F0 == 0) && (uiSecondi_Attuale < uiSecondi_Fine - 5))
$016E	$3001			MOVLW	1
$016F	$0505			ANDWF	PORTA, 0
$0170	$00C2			MOVWF	STACK_2
$0171	$0842			MOVF	STACK_2, 0
$0172	$3A00			XORLW	0
$0173	$1D03			BTFSS	STATUS, Z
$0174	$298D			GOTO	L_main_20
$0175	$3005			MOVLW	5
$0176	$0212			SUBWF	_uiSecondi_Fine, 0
$0177	$00C2			MOVWF	STACK_2
$0178	$3000			MOVLW	0
$0179	$1C03			BTFSS	STATUS, C
$017A	$3F01			ADDLW	1
$017B	$0213			SUBWF	_uiSecondi_Fine+1, 0
$017C	$00C3			MOVWF	STACK_2+1
$017D	$0843			MOVF	STACK_2+1, 0
$017E	$020F			SUBWF	_uiSecondi_Attuale+1, 0
$017F	$1D03			BTFSS	STATUS, Z
$0180	$2983			GOTO	L_main_60
$0181	$0842			MOVF	STACK_2, 0
$0182	$020E			SUBWF	_uiSecondi_Attuale, 0
$0183	$	L_main_60:
$0183	$1803			BTFSC	STATUS, C
$0184	$298D			GOTO	L_main_20
$0185	$	L149_ex_L_main_20:
;Timer.c,145 :: 		while (PORTA.F0 == 0) { }
$0185	$	L_main_21:
$0185	$3001			MOVLW	1
$0186	$0505			ANDWF	PORTA, 0
$0187	$00C2			MOVWF	STACK_2
$0188	$0842			MOVF	STACK_2, 0
$0189	$3A00			XORLW	0
$018A	$1903			BTFSC	STATUS, Z
$018B	$2985			GOTO	L_main_21
$018C	$	L_main_22:
;Timer.c,146 :: 		break;
$018C	$298E			GOTO	L_main_15
;Timer.c,147 :: 		}
$018D	$	L_main_20:
;Timer.c,148 :: 		} // END while (uiSecondi_Attuale < uiSecondi_Fine)
$018D	$2944			GOTO	L_main_14
$018E	$	L_main_15:
;Timer.c,149 :: 		INTCON = 0x00;         // Disable TMRO interrupt
$018E	$018B			CLRF	INTCON, 1
;Timer.c,151 :: 		uiSecondi_Attuale = uiSecondi_Fine;
$018F	$0812			MOVF	_uiSecondi_Fine, 0
$0190	$008E			MOVWF	_uiSecondi_Attuale
$0191	$0813			MOVF	_uiSecondi_Fine+1, 0
$0192	$008F			MOVWF	_uiSecondi_Attuale+1
;Timer.c,152 :: 		ucOutEnabled = 0;
$0193	$0191			CLRF	_ucOutEnabled, 1
;Timer.c,153 :: 		} // END Gesione tasto 1 (START/STOP)
$0194	$	L_main_11:
;Timer.c,156 :: 		if (PORTA.F1 == 0)
$0194	$3000			MOVLW	0
$0195	$1885			BTFSC	PORTA, 1
$0196	$3001			MOVLW	1
$0197	$00C2			MOVWF	STACK_2
$0198	$0842			MOVF	STACK_2, 0
$0199	$3A00			XORLW	0
$019A	$1D03			BTFSS	STATUS, Z
$019B	$2ADA			GOTO	L_main_23
;Timer.c,158 :: 		cEsciLoop = 0;
$019C	$0197			CLRF	main_cEsciLoop_L0, 1
;Timer.c,160 :: 		while (PORTA.F1 == 0) { }
$019D	$	L_main_24:
$019D	$3000			MOVLW	0
$019E	$1885			BTFSC	PORTA, 1
$019F	$3001			MOVLW	1
$01A0	$00C2			MOVWF	STACK_2
$01A1	$0842			MOVF	STACK_2, 0
$01A2	$3A00			XORLW	0
$01A3	$1903			BTFSC	STATUS, Z
$01A4	$299D			GOTO	L_main_24
$01A5	$	L_main_25:
;Timer.c,162 :: 		uiSecondi_Attuale = uiSecondi_Fine;
$01A5	$0812			MOVF	_uiSecondi_Fine, 0
$01A6	$008E			MOVWF	_uiSecondi_Attuale
$01A7	$0813			MOVF	_uiSecondi_Fine+1, 0
$01A8	$008F			MOVWF	_uiSecondi_Attuale+1
;Timer.c,164 :: 		while (cEsciLoop == 0)
$01A9	$	L_main_26:
$01A9	$1303			BCF	STATUS, RP1
$01AA	$1283			BCF	STATUS, RP0
$01AB	$0817			MOVF	main_cEsciLoop_L0, 0
$01AC	$3A00			XORLW	0
$01AD	$1D03			BTFSS	STATUS, Z
$01AE	$2ADA			GOTO	L_main_27
;Timer.c,166 :: 		DisplayNum();
$01AF	$2045			CALL	_DisplayNum
;Timer.c,167 :: 		j = 0;
$01B0	$019A			CLRF	main_j_L0, 1
;Timer.c,168 :: 		k = 1;
$01B1	$3001			MOVLW	1
$01B2	$009B			MOVWF	main_k_L0
;Timer.c,171 :: 		while (PORTA.F2 == 0)
$01B3	$	L_main_28:
$01B3	$3000			MOVLW	0
$01B4	$1905			BTFSC	PORTA, 2
$01B5	$3001			MOVLW	1
$01B6	$00C2			MOVWF	STACK_2
$01B7	$0842			MOVF	STACK_2, 0
$01B8	$3A00			XORLW	0
$01B9	$1D03			BTFSS	STATUS, Z
$01BA	$2A27			GOTO	L_main_29
;Timer.c,173 :: 		j = j + k;
$01BB	$081B			MOVF	main_k_L0, 0
$01BC	$071A			ADDWF	main_j_L0, 0
$01BD	$00C2			MOVWF	STACK_2
$01BE	$0842			MOVF	STACK_2, 0
$01BF	$009A			MOVWF	main_j_L0
;Timer.c,174 :: 		if (j >= 10)  k = 5;  // Anzich� di incrementare di uno incremento
$01C0	$300A			MOVLW	10
$01C1	$0242			SUBWF	STACK_2, 0
$01C2	$1C03			BTFSS	STATUS, C
$01C3	$29C6			GOTO	L_main_30
$01C4	$3005			MOVLW	5
$01C5	$009B			MOVWF	main_k_L0
$01C6	$	L_main_30:
;Timer.c,175 :: 		if (j >= 60)  k = 30; // di 5 e poi di 30 per fare prima.
$01C6	$303C			MOVLW	60
$01C7	$021A			SUBWF	main_j_L0, 0
$01C8	$1C03			BTFSS	STATUS, C
$01C9	$29CC			GOTO	L_main_31
$01CA	$301E			MOVLW	30
$01CB	$009B			MOVWF	main_k_L0
$01CC	$	L_main_31:
;Timer.c,178 :: 		for (i=0;i<50;i++) {
$01CC	$0198			CLRF	main_i_L0
$01CD	$0199			CLRF	main_i_L0+1
$01CE	$	L_main_32:
$01CE	$3000			MOVLW	0
$01CF	$0219			SUBWF	main_i_L0+1, 0
$01D0	$1D03			BTFSS	STATUS, Z
$01D1	$29D4			GOTO	L_main_61
$01D2	$3032			MOVLW	50
$01D3	$0218			SUBWF	main_i_L0, 0
$01D4	$	L_main_61:
$01D4	$1803			BTFSC	STATUS, C
$01D5	$29E9			GOTO	L_main_33
;Timer.c,179 :: 		DisplayNum();
$01D6	$2045			CALL	_DisplayNum
;Timer.c,180 :: 		Delay_ms(1);
$01D7	$3002			MOVLW	2
$01D8	$00CB			MOVWF	STACK_11
$01D9	$30FF			MOVLW	255
$01DA	$00CA			MOVWF	STACK_10
$01DB	$0BCB			DECFSZ	STACK_11, F
$01DC	$29DE			GOTO	$+2
$01DD	$29E1			GOTO	$+4
$01DE	$0BCA			DECFSZ	STACK_10, F
$01DF	$29DE			GOTO	$-1
$01E0	$29DB			GOTO	$-5
$01E1	$304A			MOVLW	74
$01E2	$00CA			MOVWF	STACK_10
$01E3	$0BCA			DECFSZ	STACK_10, F
$01E4	$29E3			GOTO	$-1
;Timer.c,181 :: 		}
$01E5	$	L_main_34:
;Timer.c,178 :: 		for (i=0;i<50;i++) {
$01E5	$0A98			INCF	main_i_L0, 1
$01E6	$1903			BTFSC	STATUS, Z
$01E7	$0A99			INCF	main_i_L0+1, 1
;Timer.c,181 :: 		}
$01E8	$29CE			GOTO	L_main_32
$01E9	$	L_main_33:
;Timer.c,183 :: 		if (uiSecondi_Attuale + k  < 599)
$01E9	$081B			MOVF	main_k_L0, 0
$01EA	$070E			ADDWF	_uiSecondi_Attuale, 0
$01EB	$00C2			MOVWF	STACK_2
$01EC	$080F			MOVF	_uiSecondi_Attuale+1, 0
$01ED	$1803			BTFSC	STATUS, C
$01EE	$3F01			ADDLW	1
$01EF	$00C3			MOVWF	STACK_2+1
$01F0	$3000			MOVLW	0
$01F1	$1B9B			BTFSC	main_k_L0, 7
$01F2	$30FF			MOVLW	255
$01F3	$07C3			ADDWF	STACK_2+1, 1
$01F4	$3080			MOVLW	128
$01F5	$0643			XORWF	STACK_2+1, 0
$01F6	$00C0			MOVWF	STACK_0
$01F7	$3080			MOVLW	128
$01F8	$3A02			XORLW	2
$01F9	$0240			SUBWF	STACK_0, 0
$01FA	$1D03			BTFSS	STATUS, Z
$01FB	$29FE			GOTO	L_main_62
$01FC	$3057			MOVLW	87
$01FD	$0242			SUBWF	STACK_2, 0
$01FE	$	L_main_62:
$01FE	$1803			BTFSC	STATUS, C
$01FF	$2A05			GOTO	L_main_35
;Timer.c,184 :: 		uiSecondi_Attuale = uiSecondi_Attuale + k;
$0200	$081B			MOVF	main_k_L0, 0
$0201	$078E			ADDWF	_uiSecondi_Attuale, 1
$0202	$1803			BTFSC	STATUS, C
$0203	$0A8F			INCF	_uiSecondi_Attuale+1, 1
$0204	$2A09			GOTO	L_main_36
$0205	$	L_main_35:
;Timer.c,185 :: 		else uiSecondi_Attuale = 1;
$0205	$3001			MOVLW	1
$0206	$008E			MOVWF	_uiSecondi_Attuale
$0207	$3000			MOVLW	0
$0208	$008F			MOVWF	_uiSecondi_Attuale+1
$0209	$	L_main_36:
;Timer.c,187 :: 		for (i=0;i<50;i++) {
$0209	$0198			CLRF	main_i_L0
$020A	$0199			CLRF	main_i_L0+1
$020B	$	L_main_37:
$020B	$3000			MOVLW	0
$020C	$0219			SUBWF	main_i_L0+1, 0
$020D	$1D03			BTFSS	STATUS, Z
$020E	$2A11			GOTO	L_main_63
$020F	$3032			MOVLW	50
$0210	$0218			SUBWF	main_i_L0, 0
$0211	$	L_main_63:
$0211	$1803			BTFSC	STATUS, C
$0212	$2A26			GOTO	L_main_38
;Timer.c,188 :: 		DisplayNum();
$0213	$2045			CALL	_DisplayNum
;Timer.c,189 :: 		Delay_ms(1);
$0214	$3002			MOVLW	2
$0215	$00CB			MOVWF	STACK_11
$0216	$30FF			MOVLW	255
$0217	$00CA			MOVWF	STACK_10
$0218	$0BCB			DECFSZ	STACK_11, F
$0219	$2A1B			GOTO	$+2
$021A	$2A1E			GOTO	$+4
$021B	$0BCA			DECFSZ	STACK_10, F
$021C	$2A1B			GOTO	$-1
$021D	$2A18			GOTO	$-5
$021E	$304A			MOVLW	74
$021F	$00CA			MOVWF	STACK_10
$0220	$0BCA			DECFSZ	STACK_10, F
$0221	$2A20			GOTO	$-1
;Timer.c,190 :: 		}
$0222	$	L_main_39:
;Timer.c,187 :: 		for (i=0;i<50;i++) {
$0222	$0A98			INCF	main_i_L0, 1
$0223	$1903			BTFSC	STATUS, Z
$0224	$0A99			INCF	main_i_L0+1, 1
;Timer.c,190 :: 		}
$0225	$2A0B			GOTO	L_main_37
$0226	$	L_main_38:
;Timer.c,191 :: 		} // END while (PORTA.F2 == 0)
$0226	$29B3			GOTO	L_main_28
$0227	$	L_main_29:
;Timer.c,194 :: 		while (PORTA.F3 == 0)
$0227	$	L_main_40:
$0227	$3000			MOVLW	0
$0228	$1985			BTFSC	PORTA, 3
$0229	$3001			MOVLW	1
$022A	$00C2			MOVWF	STACK_2
$022B	$0842			MOVF	STACK_2, 0
$022C	$3A00			XORLW	0
$022D	$1D03			BTFSS	STATUS, Z
$022E	$2A8F			GOTO	L_main_41
;Timer.c,196 :: 		j = j + k;
$022F	$081B			MOVF	main_k_L0, 0
$0230	$071A			ADDWF	main_j_L0, 0
$0231	$00C2			MOVWF	STACK_2
$0232	$0842			MOVF	STACK_2, 0
$0233	$009A			MOVWF	main_j_L0
;Timer.c,197 :: 		if (j >= 10)  k = 5;
$0234	$300A			MOVLW	10
$0235	$0242			SUBWF	STACK_2, 0
$0236	$1C03			BTFSS	STATUS, C
$0237	$2A3A			GOTO	L_main_42
$0238	$3005			MOVLW	5
$0239	$009B			MOVWF	main_k_L0
$023A	$	L_main_42:
;Timer.c,198 :: 		if (j >= 60)  k = 30;
$023A	$303C			MOVLW	60
$023B	$021A			SUBWF	main_j_L0, 0
$023C	$1C03			BTFSS	STATUS, C
$023D	$2A40			GOTO	L_main_43
$023E	$301E			MOVLW	30
$023F	$009B			MOVWF	main_k_L0
$0240	$	L_main_43:
;Timer.c,200 :: 		for (i=0;i<50;i++)
$0240	$0198			CLRF	main_i_L0
$0241	$0199			CLRF	main_i_L0+1
$0242	$	L_main_44:
$0242	$3000			MOVLW	0
$0243	$0219			SUBWF	main_i_L0+1, 0
$0244	$1D03			BTFSS	STATUS, Z
$0245	$2A48			GOTO	L_main_64
$0246	$3032			MOVLW	50
$0247	$0218			SUBWF	main_i_L0, 0
$0248	$	L_main_64:
$0248	$1803			BTFSC	STATUS, C
$0249	$2A5D			GOTO	L_main_45
;Timer.c,202 :: 		DisplayNum();
$024A	$2045			CALL	_DisplayNum
;Timer.c,203 :: 		Delay_ms(1);
$024B	$3002			MOVLW	2
$024C	$00CB			MOVWF	STACK_11
$024D	$30FF			MOVLW	255
$024E	$00CA			MOVWF	STACK_10
$024F	$0BCB			DECFSZ	STACK_11, F
$0250	$2A52			GOTO	$+2
$0251	$2A55			GOTO	$+4
$0252	$0BCA			DECFSZ	STACK_10, F
$0253	$2A52			GOTO	$-1
$0254	$2A4F			GOTO	$-5
$0255	$304A			MOVLW	74
$0256	$00CA			MOVWF	STACK_10
$0257	$0BCA			DECFSZ	STACK_10, F
$0258	$2A57			GOTO	$-1
;Timer.c,204 :: 		}
$0259	$	L_main_46:
;Timer.c,200 :: 		for (i=0;i<50;i++)
$0259	$0A98			INCF	main_i_L0, 1
$025A	$1903			BTFSC	STATUS, Z
$025B	$0A99			INCF	main_i_L0+1, 1
;Timer.c,204 :: 		}
$025C	$2A42			GOTO	L_main_44
$025D	$	L_main_45:
;Timer.c,206 :: 		if (uiSecondi_Attuale > 1)
$025D	$3080			MOVLW	128
$025E	$00C0			MOVWF	STACK_0
$025F	$3080			MOVLW	128
$0260	$060F			XORWF	_uiSecondi_Attuale+1, 0
$0261	$0240			SUBWF	STACK_0, 0
$0262	$1D03			BTFSS	STATUS, Z
$0263	$2A66			GOTO	L_main_65
$0264	$080E			MOVF	_uiSecondi_Attuale, 0
$0265	$3C01			SUBLW	1
$0266	$	L_main_65:
$0266	$1803			BTFSC	STATUS, C
$0267	$2A6D			GOTO	L_main_47
;Timer.c,207 :: 		uiSecondi_Attuale = uiSecondi_Attuale - k;
$0268	$081B			MOVF	main_k_L0, 0
$0269	$028E			SUBWF	_uiSecondi_Attuale, 1
$026A	$1C03			BTFSS	STATUS, C
$026B	$038F			DECF	_uiSecondi_Attuale+1, 1
$026C	$2A71			GOTO	L_main_48
$026D	$	L_main_47:
;Timer.c,208 :: 		else uiSecondi_Attuale = 599;
$026D	$3057			MOVLW	87
$026E	$008E			MOVWF	_uiSecondi_Attuale
$026F	$3002			MOVLW	2
$0270	$008F			MOVWF	_uiSecondi_Attuale+1
$0271	$	L_main_48:
;Timer.c,210 :: 		for (i=0;i<50;i++)
$0271	$0198			CLRF	main_i_L0
$0272	$0199			CLRF	main_i_L0+1
$0273	$	L_main_49:
$0273	$3000			MOVLW	0
$0274	$0219			SUBWF	main_i_L0+1, 0
$0275	$1D03			BTFSS	STATUS, Z
$0276	$2A79			GOTO	L_main_66
$0277	$3032			MOVLW	50
$0278	$0218			SUBWF	main_i_L0, 0
$0279	$	L_main_66:
$0279	$1803			BTFSC	STATUS, C
$027A	$2A8E			GOTO	L_main_50
;Timer.c,212 :: 		DisplayNum();
$027B	$2045			CALL	_DisplayNum
;Timer.c,213 :: 		Delay_ms(1);
$027C	$3002			MOVLW	2
$027D	$00CB			MOVWF	STACK_11
$027E	$30FF			MOVLW	255
$027F	$00CA			MOVWF	STACK_10
$0280	$0BCB			DECFSZ	STACK_11, F
$0281	$2A83			GOTO	$+2
$0282	$2A86			GOTO	$+4
$0283	$0BCA			DECFSZ	STACK_10, F
$0284	$2A83			GOTO	$-1
$0285	$2A80			GOTO	$-5
$0286	$304A			MOVLW	74
$0287	$00CA			MOVWF	STACK_10
$0288	$0BCA			DECFSZ	STACK_10, F
$0289	$2A88			GOTO	$-1
;Timer.c,214 :: 		}
$028A	$	L_main_51:
;Timer.c,210 :: 		for (i=0;i<50;i++)
$028A	$0A98			INCF	main_i_L0, 1
$028B	$1903			BTFSC	STATUS, Z
$028C	$0A99			INCF	main_i_L0+1, 1
;Timer.c,214 :: 		}
$028D	$2A73			GOTO	L_main_49
$028E	$	L_main_50:
;Timer.c,215 :: 		} // END while (PORTA.F3 == 0)
$028E	$2A27			GOTO	L_main_40
$028F	$	L_main_41:
;Timer.c,218 :: 		if (PORTA.F1 == 0)
$028F	$3000			MOVLW	0
$0290	$1885			BTFSC	PORTA, 1
$0291	$3001			MOVLW	1
$0292	$00C2			MOVWF	STACK_2
$0293	$0842			MOVF	STACK_2, 0
$0294	$3A00			XORLW	0
$0295	$1D03			BTFSS	STATUS, Z
$0296	$2AD7			GOTO	L_main_52
;Timer.c,220 :: 		cEsciLoop = 1;
$0297	$3001			MOVLW	1
$0298	$0097			MOVWF	main_cEsciLoop_L0
;Timer.c,222 :: 		while (PORTA.F1 == 0) { }
$0299	$	L_main_53:
$0299	$3000			MOVLW	0
$029A	$1885			BTFSC	PORTA, 1
$029B	$3001			MOVLW	1
$029C	$00C2			MOVWF	STACK_2
$029D	$0842			MOVF	STACK_2, 0
$029E	$3A00			XORLW	0
$029F	$1903			BTFSC	STATUS, Z
$02A0	$2A99			GOTO	L_main_53
$02A1	$	L_main_54:
;Timer.c,224 :: 		uiSecondi_Fine = uiSecondi_Attuale;
$02A1	$080E			MOVF	_uiSecondi_Attuale, 0
$02A2	$0092			MOVWF	_uiSecondi_Fine
$02A3	$080F			MOVF	_uiSecondi_Attuale+1, 0
$02A4	$0093			MOVWF	_uiSecondi_Fine+1
;Timer.c,228 :: 		EEprom_Write(1, uiSecondi_Fine & 0b11111111);
$02A5	$3001			MOVLW	1
$02A6	$009E			MOVWF	FARG_EEprom_write+0
$02A7	$30FF			MOVLW	255
$02A8	$050E			ANDWF	_uiSecondi_Attuale, 0
$02A9	$009F			MOVWF	FARG_EEprom_write+1
$02AA	$20BB			CALL	_EEprom_write
;Timer.c,229 :: 		Delay_ms(250);
$02AB	$3002			MOVLW	2
$02AC	$00CC			MOVWF	STACK_12
$02AD	$30FF			MOVLW	255
$02AE	$00CB			MOVWF	STACK_11
$02AF	$30FF			MOVLW	255
$02B0	$00CA			MOVWF	STACK_10
$02B1	$0BCC			DECFSZ	STACK_12, F
$02B2	$2AB4			GOTO	$+2
$02B3	$2ABB			GOTO	$+8
$02B4	$0BCB			DECFSZ	STACK_11, F
$02B5	$2AB7			GOTO	$+2
$02B6	$2ABA			GOTO	$+4
$02B7	$0BCA			DECFSZ	STACK_10, F
$02B8	$2AB7			GOTO	$-1
$02B9	$2AB4			GOTO	$-5
$02BA	$2AB1			GOTO	$-9
$02BB	$3046			MOVLW	70
$02BC	$00CB			MOVWF	STACK_11
$02BD	$30FF			MOVLW	255
$02BE	$00CA			MOVWF	STACK_10
$02BF	$0BCB			DECFSZ	STACK_11, F
$02C0	$2AC2			GOTO	$+2
$02C1	$2AC5			GOTO	$+4
$02C2	$0BCA			DECFSZ	STACK_10, F
$02C3	$2AC2			GOTO	$-1
$02C4	$2ABF			GOTO	$-5
$02C5	$30CF			MOVLW	207
$02C6	$00CA			MOVWF	STACK_10
$02C7	$0BCA			DECFSZ	STACK_10, F
$02C8	$2AC7			GOTO	$-1
$02C9	$0000			NOP
;Timer.c,230 :: 		EEprom_Write(3, uiSecondi_Fine / 0b11111111);
$02CA	$3003			MOVLW	3
$02CB	$009E			MOVWF	FARG_EEprom_write+0
$02CC	$30FF			MOVLW	255
$02CD	$00C4			MOVWF	STACK_4
$02CE	$01C5			CLRF	STACK_4+1
$02CF	$0812			MOVF	_uiSecondi_Fine, 0
$02D0	$00C0			MOVWF	STACK_0
$02D1	$0813			MOVF	_uiSecondi_Fine+1, 0
$02D2	$00C1			MOVWF	STACK_0+1
$02D3	$201D			CALL	_div_16x16_u
$02D4	$0840			MOVF	STACK_0, 0
$02D5	$009F			MOVWF	FARG_EEprom_write+1
$02D6	$20BB			CALL	_EEprom_write
;Timer.c,231 :: 		}
$02D7	$	L_main_52:
;Timer.c,232 :: 		}
$02D7	$1303			BCF	STATUS, RP1
$02D8	$1683			BSF	STATUS, RP0
$02D9	$29A9			GOTO	L_main_26
$02DA	$	L_main_27:
;Timer.c,233 :: 		} // // END Gesione tasto 2 (SET/STORE)
$02DA	$	L_main_23:
;Timer.c,235 :: 		} // END while(1)
$02DA	$1303			BCF	STATUS, RP1
$02DB	$1683			BSF	STATUS, RP0
$02DC	$1303			BCF	STATUS, RP1
$02DD	$1683			BSF	STATUS, RP0
$02DE	$292D			GOTO	L_main_9
;Timer.c,236 :: 		} // END void main (void)
$02DF	$2ADF			GOTO	$
