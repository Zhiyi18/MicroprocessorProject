#include <xc.inc>

global loop_1,loop_2,loop_3,loop_4,loop_5,loop_6,loop_7

;this file reads waveform table from PM and outputs to port E
    
;different loops are for different frequencies

;table pointer and FSR are set in start_read_table.s, the set up is updated each time a key for changing waveform is pressed
    
;which lets FSR point to corresponding address and clears table pointer
    
    loop_1:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A ;move data from TABLAT to PORTE

    movlw 0xE9

    movwf 0x20,A ;setting counter for delays

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_1 ; keep going until finished

    return

   

loop_2:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0xD0

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_2 ; keep going until finished

    return

   

loop_3:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0xB9

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_3 ; keep going until finished

    return

 

loop_4:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0xAE

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_4 ; keep going until finished

    return

   

loop_5:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0x9B

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_5 ; keep going until finished

    return

   

loop_6:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0x8A

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_6 ; keep going until finished

    return

   

loop_7:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0x7B

    movwf 0x20,A

    call delay_1

    decfsz counter, A ; count down to zero

    bra loop_7 ; keep going until finished

    return
    
end


