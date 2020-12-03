#include <xc.inc>

global read_square,read_triangular,read_sine,read_trumpet,read_flute
    
extrn loop_1,loop_2,loop_3,loop_4,loop_5,loop_6,loop_7

;this file asks the keypad which key has been pressed(for different frequencies)
;if a key has been pressed, the code will call the signal generator for that specific frequency(loop_1 to loop_7) 
    
read_square:
    call start_square ;loads FSR and table pointer register to read the waveform table from PM

    call read_keypad_1 ;asks the keypad if any keys has been pressed

    call read_keypad_2

    call read_keypad_3

    call read_keypad_4

    call read_keypad_5

    call read_keypad_6

    call read_keypad_7

    return

   

read_triangular:

    bcf LATD,2,A ;clears pin 2 which has been set high when reading waveform selection keys

    call start_triangular

    call read_keypad_1

    call read_keypad_2

    call read_keypad_3

    call read_keypad_4

    call read_keypad_5

    call read_keypad_6

    call read_keypad_7

    bsf LATD,2,A ;set pin 2 high back again since when returned to the main program, it indicates this loop has been run once and the main program has to return to the beginning to ask the keypad if the key has been pressed again

    return

   

read_sine:

    bcf LATD,3,A

    call start_sine

    call read_keypad_1

    call read_keypad_2

    call read_keypad_3

    call read_keypad_4

    call read_keypad_5

    call read_keypad_6

    call read_keypad_7

    bsf LATD,3,A

    return

   

read_trumpet:

    bcf LATD,1,A

    call start_trumpet

    call read_keypad_1

    call read_keypad_2

    call read_keypad_3

    call read_keypad_4

    call read_keypad_5

    call read_keypad_6

    call read_keypad_7

    bsf LATD,1,A

    return

 

read_flute:

    bcf LATD,0,A

    call start_flute

    call read_keypad_1

    call read_keypad_2

    call read_keypad_3

    call read_keypad_4

    call read_keypad_5

    call read_keypad_6

    call read_keypad_7

    bsf LATD,0,A

    return
    
read_keypad_1:

    bsf LATD,0,A ;sets output pin 0 high

    movlw 0x01

    movwf 0x20,A ;sets counter for delay_read

    call delay_read ;delay which gives PIC time to read from input pin

    btfsc PORTD,4,A ;tests input pin 0, if zero the the key is not pressed, skips the next line(signal generator)

    call loop_1 ;(0,0)

    bcf LATD,0,A ;clears output pin 0

    return

   

read_keypad_2:

    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_2 ;(1,0)

    bcf LATD,1,A

    return

   

read_keypad_3:

    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_3 ;(2,0)

    bcf LATD,2,A

    return

   

read_keypad_4:

    bsf LATD,3,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_4 ;(3,0)

    bcf LATD,3,A

    return

   

read_keypad_5:

    bsf LATD,0,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_5 ;(0,1)

    bcf LATD,0,A

    return

   

read_keypad_6:

    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_6 ;(1,1)

    bcf LATD,1,A

    return

   

read_keypad_7:

    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_7 ;(2,1)

    bcf LATD,2,A

    return
    
end



