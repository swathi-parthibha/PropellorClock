#include <p16f887.inc>

count EQU 0x20
del1 EQU 0x21
del2 EQU 0x22
count10 EQU 0x23

	ORG 0
	GOTO main
	ORG 4
	GOTO isr
main:
	BANKSEL ANSELH	
	CLRF ANSELH
	BANKSEL TRISB
	CLRF TRISB
	BANKSEL PORTB
	MOVLW 0xFF
	MOVWF PORTB


	MOVLW 0x00
	MOVWF count
	MOVLW .10
	MOVWF count10
	CLRW 
	


loop:
	CALL display
	MOVWF PORTB
	CALL delay
	INCF count, 1
	MOVF count, 0
	XORLW 0x0F
	BTFSC STATUS, 2
	GOTO endword
	MOVF count, 0
	GOTO loop

display:
	ADDWF PCL, 1
	RETLW B'10000000' ;
	RETLW B'10000000' ;
	RETLW B'11111000' ;
	RETLW B'10000000' ;
	RETLW B'10000000' ;
	RETLW B'00000000'
	RETLW B'11111000' ;
	RETLW B'10001000' ;
	RETLW B'11111000' ; 
	RETLW B'00000000' ;
	RETLW B'11111000' ;
	RETLW B'10001000' ;
	RETLW B'11111000' ; 
	RETLW B'00000000' ;


delay: 
	MOVLW .250
	MOVWF del1
loop1: 
	MOVLW .5
	MOVWF del2
loop2:
	NOP
	DECFSZ del2
	GOTO loop2	

	DECFSZ del1
	GOTO loop1
	RETURN

endword:
	CLRW
	CLRF count
	MOVLW .10
	MOVWF count10
delay50ms:
	CALL delay
	DECFSZ count10
	GOTO delay50ms
	GOTO loop

isr:
	NOP
	RETFIE

	END
