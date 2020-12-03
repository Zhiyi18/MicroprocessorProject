#include <xc.inc>

global start_square,start_triangular,start_sine,start_trumpet,start_flute
    
;this file is for loading FSR and table pointer
    
;when a key for a specific waveform is pressed FSR is updated, holding the address where the corresponding table is stored
    
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
    
end



