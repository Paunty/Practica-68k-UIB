; =============================================================================
; TITLE    : SHOT 
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 30-12-2020
; SHOT MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; =============================================================================

; -----------------------------------------------------------------------------
SHTINIT
; INITALIZES A SHOT
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
SHTUPD
; UPDATES A SHOT BY MOVING IT RIGHTWARD.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            ADD.W   #-SHTSPEED,2(A0)        ; MOVE
            CMP.W   #0,2(A0)                ; KILL IF OUT OF SCREEN
            BEQ     .KILL
            
.CONTINUE   MOVEM.L A0-A1/D0-D7,-(A7)       ; STACK REGISTERS
            MOVE.W  (A0),D2                 ; PREPARE SHOT COORDINATES FOR
            MOVE.W  2(A0),D3                ; COLLISION CHECK
            MOVE.W  #SHTWIDTH,D5
            MOVE.W  #SHIPHEIG,D7
            MOVE.L  A0,A1
            MOVE.W  #ENEMID,D0              ; LOOP THROUGH ALL ENEMIES 
            JSR     DMMFRSTO
.LOOP       CMP.L   #0,A0
            BEQ     .END
            MOVE.W  8(A0),D0
            MOVE.W  10(A0),D1
            MOVE.W  #ENEMRAD,D4
            MOVE.W  #ENEMRAD,D6
            JSR     UTLCHCOL                ; CHECK COLISSIONS
            TST.B   D0
            BNE     .DELETE                 ; IF COLLISION, DELETE AGENT
            MOVE.W  #ENEMID,D0
            JSR     DMMNEXTO
            BRA     .LOOP
.END        MOVEM.L (A7)+,A0-A1/D0-D7       ; STACK REGISTERS
            RTS
            
.DELETE     ADD.W   #ENEMCORE, (SHIPCORE)   ; INCREASE SCORE
            MOVE.W  #ENEMID,D0
            JSR     AGLKILL                 ; KILL THE AGENT ENEMY
            BRA     .END

.KILL       MOVE.W  #SHOTID,D0              ; PUTS ID OF THE AGENT
            JSR     AGLKILL                 ; KILL THE AGENT SHOT
            BRA     .CONTINUE               

; -----------------------------------------------------------------------------
SHTPLOT
; PLOTS THE SHOT.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L     A0/D1-D4,-(A7)      ; STACK REGISTERS
            COLORPEN    #$00FFFFFF
            COLORFIL    #$0000FFFF
            MOVE.W      (A0)+,D1            ; D1 X CENTER
            MOVE.W      (A0)+,D2            ; D2 Y CENTER
            
; --- CENTRAL SHOT ------------------------------------------------------------
            MOVE.W      D1,D3               
            MOVE.W      D2,D4 
            ADD.W       #4,D3               ; D3 X RIGHT                             
            ADD.W       #20,D4              ; D4 Y BOTTOM                         
            MOVE.B      #87,D0                          
            TRAP        #15                 ; DRAW SHOT

; --- LEFT SHOT ------------------------------------------------------------
            SUB.W       #30,D1              ; D1 X LEFT
            MOVE.W      D1,D3
            MOVE.W      D2,D4
            ADD.W       #4,D3               ; D3 X RIGHT           
            ADD.W       #10,D4              ; D4 Y BOTTOM       
            TRAP        #15                 ; DRAW SHOT
            
; --- RIGHT SHOT ------------------------------------------------------------
            ADD.W       #60,D1
            MOVE.W      D1,D3
            ADD.W       #4,D3               ; D3 X RIGHT               
            TRAP        #15                 ; DRAW SHOT
                  
            MOVEM.L     (A7)+,A0/D1-D4      ; STACK REGISTER
            RTS





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
