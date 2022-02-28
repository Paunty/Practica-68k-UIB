; =============================================================================
; TITLE    : MUSIC CODE
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 16-01-2021
; =============================================================================

PLAYSONG
;------------------------------------------------------------------------------
    MOVEM.L D0-D1,-(A7)
    
    MOVE.W  #70,D0              ; LOADS THE SOUND INTO SOUND MEMORY
    MOVE.B  SONGNURE,D1
    TRAP    #15
        
    MOVEM.L (A7)+,D0-D1
    RTS
    

;------------------------------------------------------------------------------
STOPSONG
;------------------------------------------------------------------------------
    MOVEM.L D0/D2,-(A7)
   
    MOVE.W  #70,D0
    MOVE.L  #0,D0
    TRAP    #15
    
    MOVEM.L (A7)+,D0/D2

    RTS
    
    
    
    
    
    
    
    
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
