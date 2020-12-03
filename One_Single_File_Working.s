#include <pic18_chip_select.inc>

#include <xc.inc>

   

psect    code, abs

   

main:

    org    0x0

    goto keyboard_setup            

 

keyboard_setup:

    clrf TRISE,A ;port E as output

    clrf LATE,A

    movlw 0xf0

    movwf TRISD, A

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

 

sound_select:

    bsf LATD,0,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_flute ;(0,3),call flute waveforms

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,0,A

   

    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_trumpet ;(1,3),call trumpet waveforms

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,1,A

   

    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_triangular ;(3,2),call triangular waveforms

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,2,A

   

    bsf LATD,3,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,7,A

    call read_sine ;(3,3),call sin waveforms

    btfsc PORTD,7,A

    goto 0x0

    bcf LATD,3,A

   

   

    call read_square ;call square waveforms

   

    goto 0x0

   

read_square:

    call setup

    call SquareTable

    call start_square

    call read_1

    call read_2

    call read_3

    call read_4

    call read_5

    call read_6

    call read_7

    return

   

read_triangular:

    bcf LATD,2,A

    call setup

    call TriangularTable

    call start_triangular

    call read_1

    call read_2

    call read_3

    call read_4

    call read_5

    call read_6

    call read_7

    bsf LATD,2,A

    return

   

read_sine:

    bcf LATD,3,A

    call setup

    call SineTable

    call start_sine

    call read_1

    call read_2

    call read_3

    call read_4

    call read_5

    call read_6

    call read_7

    bsf LATD,3,A

    return

   

read_trumpet:

    bcf LATD,1,A

    call setup

    call TrumpetTable

    call start_trumpet

    call read_1

    call read_2

    call read_3

    call read_4

    call read_5

    call read_6

    call read_7

    bsf LATD,1,A

    return

 

read_flute:

    bcf LATD,0,A

    call setup

    call FluteTable

    call start_flute

    call read_1

    call read_2

    call read_3

    call read_4

    call read_5

    call read_6

    call read_7

    bsf LATD,0,A

    return

   

read_1:

    bsf LATD,0,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_1 ;(0,0)

    bcf LATD,0,A

    return

   

read_2:

    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_2 ;(1,0)

    bcf LATD,1,A

    return

   

read_3:

    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_3 ;(2,0)

    bcf LATD,2,A

    return

   

read_4:

    bsf LATD,3,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,4,A

    call loop_4 ;(3,0)

    bcf LATD,3,A

    return

   

read_5:

    bsf LATD,0,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_5 ;(0,1)

    bcf LATD,0,A

    return

   

read_6:

    bsf LATD,1,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_6 ;(1,1)

    bcf LATD,1,A

    return

   

read_7:

    bsf LATD,2,A

    movlw 0x01

    movwf 0x20,A

    call delay_read

    btfsc PORTD,5,A

    call loop_7 ;(2,1)

    bcf LATD,2,A

    return

   

   

 

setup:

    bcf CFGS ; point to Flash program memory  

    bsf EEPGD ; access Flash program memory

    return

 

SquareTable:

    db 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90

    myArray EQU 0x400 ; Address in RAM for data

    counter EQU 0x10 ; Address of counter variable

    align 2 ; ensure alignment of subsequent instructions

    return

   

 

start_square:

    lfsr 0, myArray ; Load FSR0 with address in RAM

    movlw low highword(SquareTable) ; address of data in PM

    movwf TBLPTRU, A ; load upper bits to TBLPTRU

    movlw high(SquareTable) ; address of data in PM

    movwf TBLPTRH, A ; load high byte to TBLPTRH

    movlw low(SquareTable) ; address of data in PM

    movwf TBLPTRL, A ; load low byte to TBLPTRL

    movlw 20 ; 20 bytes to read

    movwf counter, A ; our counter register

    return

   

 TriangularTable:

    db 0x00,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0x90,0x80,0x70,0x60,0x50,0x40,0x30,0x20,0x10

    myArray2 EQU 0x420 ; Address in RAM for data

    counter EQU 0x10 ; Address of counter variable

    align 2 ; ensure alignment of subsequent instructions

    return

   

 

start_triangular:

    lfsr 0, myArray2 ; Load FSR0 with address in RAM

    movlw low highword(TriangularTable) ; address of data in PM

    movwf TBLPTRU, A ; load upper bits to TBLPTRU

    movlw high(TriangularTable) ; address of data in PM

    movwf TBLPTRH, A ; load high byte to TBLPTRH

    movlw low(TriangularTable) ; address of data in PM

    movwf TBLPTRL, A ; load low byte to TBLPTRL

    movlw 20 ; 20 bytes to read

    movwf counter, A ; our counter register

    return

   

SineTable:

    db 0x40,0x55,0x67,0x76,0x7E,0x80,0x7B,0x6F,0x5E,0x4B,0x35,0x22,0x11,0x05,0x00,0x02,0x0A,0x19,0x2B,0x40

    myArray3 EQU 0x440 ; Address in RAM for data

    counter EQU 0x10 ; Address of counter variable

    align 2 ; ensure alignment of subsequent instructions

    return

   

 

start_sine:

    lfsr 0, myArray3 ; Load FSR0 with address in RAM

    movlw low highword(SineTable) ; address of data in PM

    movwf TBLPTRU, A ; load upper bits to TBLPTRU

    movlw high(SineTable) ; address of data in PM

    movwf TBLPTRH, A ; load high byte to TBLPTRH

    movlw low(SineTable) ; address of data in PM

    movwf TBLPTRL, A ; load low byte to TBLPTRL

    movlw 20 ; 20 bytes to read

    movwf counter, A ; our counter register

    return

   

TrumpetTable:

    db 0x80,0x3e,0x42,0x4a,0x47,0x3f,0x3b,0x3c,0x42,0x46,0x49,0x49,0x4a,0x4f,0x54,0x53,0x41,0x1d,0x9,0x7e

    myArray4 EQU 0x460 ; Address in RAM for data

    counter EQU 0x10 ; Address of counter variable

    align 2 ; ensure alignment of subsequent instructions

    return

   

start_trumpet:

    lfsr 0, myArray4 ; Load FSR0 with address in RAM

    movlw low highword(TrumpetTable) ; address of data in PM

    movwf TBLPTRU, A ; load upper bits to TBLPTRU

    movlw high(TrumpetTable) ; address of data in PM

    movwf TBLPTRH, A ; load high byte to TBLPTRH

    movlw low(TrumpetTable) ; address of data in PM

    movwf TBLPTRL, A ; load low byte to TBLPTRL

    movlw 20 ; 20 bytes to read

    movwf counter, A ; our counter register

    return  

   

FluteTable:

    db 0x78,0x40,0x46,0x63,0x7a,0x7f,0x75,0x66,0x5d,0x60,0x61,0x7d,0x81,0x70,0x4b,0x1f,0x06,0x19,0x59,0x78

    myArray5 EQU 0x480 ; Address in RAM for data

    counter EQU 0x10 ; Address of counter variable

    align 2 ; ensure alignment of subsequent instructions

    return

   

start_flute:

    lfsr 0, myArray5 ; Load FSR0 with address in RAM

    movlw low highword(FluteTable) ; address of data in PM

    movwf TBLPTRU, A ; load upper bits to TBLPTRU

    movlw high(FluteTable) ; address of data in PM

    movwf TBLPTRH, A ; load high byte to TBLPTRH

    movlw low(FluteTable) ; address of data in PM

    movwf TBLPTRL, A ; load low byte to TBLPTRL

    movlw 20 ; 20 bytes to read

    movwf counter, A ; our counter register

    return  

   

loop_1:

    tblrd*+ ; move one byte from PM to TABLAT, increment TBLPRT

    movff TABLAT, POSTINC0 ; move read data from TABLAT to (FSR0), increment FSR0

    movff TABLAT,PORTE,A

    movlw 0xE9

    movwf 0x20,A

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


