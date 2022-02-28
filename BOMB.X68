; =============================================================================
; TITLE    : SHOT
; AUTHOR   : PAU BONET ALCOVER- JUAN JOSE RODRIGUEZ
; HISTORY  : 30-12-2020
; BOMB MANAGEMENT. IT IS AN AGENT.
; =============================================================================

; -----------------------------------------------------------------------------
BOMINIT
; INITALIZES A BOMB
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
;            D1.W INITIAL X COORDINATE
;            D2.W INITIAL Y COORDINATE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            SUB.W   #2,D1 
            SUB.W   #20,D2        
            MOVE.W  D1,(A0)                 
            MOVE.W  D2,2(A0)
            RTS
  
; -----------------------------------------------------------------------------
BOMUPD
; UPDATES A BOMB BY MOVING IT.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            SUB.W   #-BOMSPEED,2(A0)        ; MOVE
            CMP.W   #SCRHEIGH,2(A0)        ; KILL IF OUT OF SCREEN
            BGT     .KILL
            
.CONTINUE   MOVEM.L A0-A1/D0-D7,-(A7)
            MOVE.W  (A0),D2                 ; PREPARE SHOT COORDINATES 
            MOVE.W  2(A0),D3                ; COLLISION CHECK
            MOVE.W  #BOMRAD,D5
            MOVE.W  #BOMRAD,D7
            MOVE.W  (SHIPX),D0              ; SHIP X COORDENATE
            MOVE.W  #SHIPY,D1               ; SHIP Y COORDENATE
            MOVE.W  #SHIPWIDH,D4
            MOVE.W  #SHIPHEIG,D6
            JSR     UTLCHCOL                ; CHECK COLISSIONS
            TST.B   D0
            BNE     .ENDGAME                 ; IF COLLISION, DELETE AGENT
.END        MOVEM.L (A7)+,A0-A1/D0-D7
            RTS
            
.ENDGAME              
            MOVE.W  #BOMBID,D0              ; PUTS ID OF THE AGENT
            JSR     AGLKILL                 ; KILL THE AGENT SHOT
            MOVE.W  #STAGOVER,(STANEXT)
            BRA     .END

.KILL       MOVE.W  #BOMBID,D0              ; PUTS ID OF THE AGENT
            JSR     AGLKILL                 ; KILL THE AGENT SHOT
            BRA     .CONTINUE               

; -----------------------------------------------------------------------------
BOMPLOT
; PLOTS THE SHOT.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A0/D1-D4,-(A7)
            COLORPEN    #$00FFFFFF
            COLORFIL    #$000000FF
            MOVE.W  (A0)+,D1
            MOVE.W  (A0)+,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4 
            SUB.W   #BOMRAD,D1              ; D1:=XLEFT
            SUB.W   #BOMRAD,D2              ; D2:=YTOP
            ADD.W   #BOMRAD,D3              ; D3:=XRIGTH
            ADD.W   #BOMRAD,D4              ; D4:=YBOTTOM             
            MOVE.B      #88,D0              ; DRAW CIRCLE              
            TRAP        #15                 ; DO IT
                 
            MOVEM.L     (A7)+,A0/D1-D4
            RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
