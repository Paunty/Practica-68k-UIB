; =============================================================================
; TITLE    : STARS MAP
; AUTHOR   : PAU BONET ALCOVER & JUAN JOSE RODRIGUEZ ARANDA
; COMMENTS : 
; HISTORY  : 11/01/2021 - CREATION
; =============================================================================
; -----------------------------------------------------------------------------
STARINI     EQU     STAEMPTY
; INITIALIZE THE STAR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
; -----------------------------------------------------------------------------
STARUPD     EQU     STAEMPTY
; UPDATE THE STAR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------            
            

; -----------------------------------------------------------------------------
STARPLT
; PLOT  THE STAR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D5/A1-A2,-(A7)       ; STACK REGISTER
            MOVE.W  #80,D5 
            LEA     STARSSX,A1              ; PUTS POSOTIONS X ON A1
            LEA     STARSSY,A2              ; PUTS POSOTIONS Y ON A2
             
.LOOP       COLORPEN    #$00FFFFFF          ; MACRO PEN COLOUR
            COLORFIL    #$00FFFFFF          ; MACRO FILL COLOUR
            MOVE.W  (A1)+,D1                ; D1:=XCENTER
            MOVE.W  (A2)+,D2                ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #STAWIDTH/2,D1          ; D1:=XLEFT
            SUB.W   #STAHEIGH/2,D2          ; D2:=YTOP
            ADD.W   #STAWIDTH/2,D3          ; D3:=XRIGHT
            ADD.W   #STAHEIGH/2,D4          ; D4:=YBOTTOM
            MOVE.B  #87,D0
            TRAP    #15                     ; DRAW ELIPSE
            DBRA    D5,.LOOP
            
            MOVEM.L (A7)+,D0-D5/A1-A2       ; RESTORE REGISTERS
            RTS



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
