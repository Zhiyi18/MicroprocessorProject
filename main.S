#include <pic18_chip_select.inc>

#include <xc.inc>

extrn delay_1,delay_1_2,delay_read,memory_setup,SquareTable,TriangularTable,SineTable,TrumpetTable,keypad_setup

psect    code, abs

   

main:

    org    0x0

    goto load_table            

load_table:
    
    ; loading tables for different waveforms into program memory
    
    call memory_setup
    
    call SquareTable
    
    call TriangularTable
    
    call SquareTable
    
    call TrumpetTable
    
    call FluteTable 

    
sound_select:
    
    call keypad_setup ;set up keypad for reading the keys
    
    ;********************************************
    
    ;this part of code asks the keypad if the keys for different waveforms have been pressed
    
    ;if pressed then go to frequency selection(frequency.s) for the specific waveform
    
    ;if not pressed then skip frequency selection and return to the beginning
    
    ;the default waveform is square wave
    
    ;in all cases the program returns to the beginning, and asks the keypad again if any keys has been pressed
 
    ;********************************************
    
    
    
    ;checking the key for flute waveform is pressed or not
    
    bsf LATD,0,A ;sets output pin 0 to high

    movlw 0x01

    movwf 0x20,A ;sets counter for delay_read

    call delay_read ;leaves time for input pin to read

    btfsc PORTD,7,A ;tests if input pin is high, if high then the key is pressed, call frequency selection

    call read_flute ;(0,3),call frequency selection for flute waveforms

    btfsc PORTD,7,A ;if no key has been pressed do not go to the beginning, keep asking the next key

    goto 0x0

    bcf LATD,0,A

   
    ;trumpet
    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_trumpet 

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,1,A

   
    ;triangular wave
    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_triangular 

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,2,A

   
    ;sine wave
    bsf LATD,3,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_sine

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,3,A

   

   

    call read_square ;square wave(if no key for waveform selection has been pressed)

   

    goto 0x0


    end