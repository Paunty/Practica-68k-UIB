; =============================================================================
; TITLE    : BOTO MANAGEMENT
; AUTHOR   : PAU BONET ALCOVER & JUAN JOSE RODRIGUEZ ARANDA
; COMMENTS :
; HISTORY  : 3/01/2021 - CREATION
; =============================================================================

; -----------------------------------------------------------------------------
BOTINIT
; INITIALIZE THE BOTON
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
BOTUPD
; UPDATE THE BOTON
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D6,-(A7)             ; STACK REGISTER
              
            MOVE.L  #61,D0                  ; TRAP MODE FOR MOUSE
            CLR.L   D1                      ; D1 = 0, READ MOUSE STATE
            TRAP    #15
            BTST    #0,D0                   ; CLICK IS PRESSED
            BEQ   .END                                 
            MOVE.L  D1,D2                   
            LSR.L   #8,D2                   ; Y COORDENATE 0-15
            LSR.L   #8,D2                   ; X COORDENATE 16-31               
            MOVE.W  #BOTGAMX,D3             ; D1:=XCENTER
            MOVE.W  #BOTGAMY,D4             ; D2:=YCENTER
            MOVE.W  D3,D5                   ; D3:=XCENTER
            MOVE.W  D4,D6                   ; D4:=YCENTER
            SUB.W   #BOTWIDTH/2,D3          ; D1:=XLEFT
            SUB.W   #BOTHEIGH/2,D4          ; D2:=YTOP
            ADD.W   #BOTWIDTH/2,D5          ; D3:=XRIGHT
            ADD.W   #BOTHEIGH/2,D6          ; D4:=YBOTTOM

            CMP.W   D3,D1
            BLT     .END
            CMP.W   D5,D1
            BGT     .END
            CMP.W   D4,D2
            BLT     .END
            CMP.W   D6,D2
            BGT     .END
            MOVE.W  #STAGAME,(STANEXT)      ; GO TO GAME IF ITS PRESSED

.END        MOVEM.L (A7)+,D0-D6             ; RESTORE REGISTERS
            RTS

; -----------------------------------------------------------------------------
BOTPLOT
; PLOT THE BOTON
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK REGISTER
            COLORPEN    #$00FF0110          ; MACRO PEN COLOUR
            COLORFIL    #$00FF0110          ; MACRO FILL COLOUR  
            MOVE.W  #BOTGAMX,D1             ; D1:=XCENTER
            MOVE.W  #BOTGAMY,D2             ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #BOTWIDTH/2,D1          ; D1:=XLEFT
            SUB.W   #BOTHEIGH/2,D2          ; D2:=YTOP
            ADD.W   #BOTWIDTH/2,D3          ; D3:=XRIGHT
            ADD.W   #BOTHEIGH/2,D4          ; D4:=YBOTTOM
            MOVE.B  #87,D0
            TRAP    #15                     ; DRAW RECTANGLE
            MOVEM.L (A7)+,D0-D4             ; RESTORE REGISTERS
            RTS


*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
