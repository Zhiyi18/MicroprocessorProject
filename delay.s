#include <xc.inc>

global delay_1,delay_1_2,delay_read

delay_1:

    decfsz 0x20,A

    NOP

    movlw 0x01

    movwf 0x30,A

    call delay_1_2

    tstfsz 0x20,A

    bra delay_1

    return

 

delay_1_2:

    decfsz 0x30,A

    bra delay_1_2

    return

   

delay_read:

    decfsz 0x20,A

    bra delay_read

    return

    end


