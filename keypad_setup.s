#include <xc.inc>

global keypad_setup
    
;this file sets upper nibble of keypad as output and lower nibble as input

keypad_setup:

    clrf TRISE,A ;port E as output

    clrf LATE,A

    bcf TRISD,0,A

    bcf TRISD,1,A

    bcf TRISD,2,A

    bcf TRISD,3,A

    bsf TRISD,4,A

    bsf TRISD,5,A

    bsf TRISD,6,A

    bsf TRISD,7,A

    ;set upper nibble as output and lower nibble as input

    movlw 00000000

    movwf LATD,A

    movwf LATE,A



