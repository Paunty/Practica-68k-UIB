; =============================================================================
; TITLE    : GAME ENEMIES (AGENT)
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 12-1-2020
; COMMENTS : ENEMY AGENT LOCAL VARIABLES
;            (A0) : XCENTER - WORD
;            2(A0) : YCENTER - WORD
;            4(A0) : XSPEED  - WORD
;            6(A0) : YSPEED  - WORD            
; =============================================================================

; -----------------------------------------------------------------------------
ENEINIT
; ININTIALITZE THE ENEMIES
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)             ; STACK REGISTERS
            JSR RNDGET                      ; DO.L=RND(0,255)
            MOVE.W  D0,(A0)                 ; X ENEMY=D0 
           
            JSR RNDGET                      ; DO.L=RND(0,255)5)
            MOVE.W  D0,2(A0)                ; Y ENEMY=D0
            
            JSR RNDGET                      ; D0.L=RND(0,255)
            AND.L   #%00001100,D0           ; MASK D0
            LEA     .SPEEDS,A1              ; GET VECTOR ADRESS
            MOVE.L  (A1,D0),4(A0)           ; INIT SPEEDS
            
            MOVEM.L (A7)+,D0/A1             ; STACK REGISTERS
            RTS 
    
.SPEEDS     DC.W    ENEMSPEED,ENEMSPEED     
            DC.W    ENEMSPEED,-ENEMSPEED    
            DC.W    -ENEMSPEED,ENEMSPEED    
            DC.W    -ENEMSPEED,-ENEMSPEED   

; -----------------------------------------------------------------------------
ENEMUPD
; UPDATE ENEMIES
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0,-(A7)                ; STACK REGISTER
            
            MOVE.W  (A0),D0
            ADD.W   4(A0),D0
            MOVE.W  D0,(A0)                 ; X:X+VX
            MOVE.W  2(A0),D0
            ADD.W   6(A0),D0
            MOVE.W  D0,2(A0)                ; Y:Y+VY           
            BTST.B  #5,(SCRCYCCT)           ; NO FIRE TIME
            BEQ     .NOFIRE

            MOVEM.L A1-A3/D0-D2,-(A7)       ; STACK REGISTER
            LEA     BOMINIT,A1
            LEA     BOMUPD,A2
            LEA     BOMPLOT,A3
            MOVE.W  #BOMBID,D0
            MOVE.W  (A0),D1                 ; ENEMIES POSITION X 
            MOVE.W  2(A0),D2                ; ENEMIES POSITION Y
            JSR     AGLADD                  ; CREATE AN ENEMY AGENT
            MOVEM.L (A7)+,A1-A3/D0-D2       ; STACK REGISTER
.NOFIRE
           
            CMP.W   #ENEMRAD,(A0)           ; CHECK LEFT BOUNDRY
            BLT     .BOUNCEL                ; IF COLLISION -> BOUNCE
            CMP.W   #SCRWIDTH-1-ENEMRAD,(A0) ; CHECK RIGHT BOUNDRY
            BGT     .BOUNCER                ; IF COLLISION -> BOUNCE
            
.CHKV       CMP.W   #ENEMRAD,2(A0)          ; CHECK TOP BOUNDARY
            BLT     .BOUNCET                ; IF COLISION -> BOUNCE
            CMP.W   #200-1-ENEMRAD,2(A0)    ; CHECK BOTTOM BOUNDARY
            BGT     .BOUNCEB                ; IF COLLISION -> BOUNCE
            BRA     .END          
                       
.BOUNCEL    MOVE.W  #ENEMRAD,(A0)           ; ADJUST X
            MOVE.W  #ENEMSPEED,4(A0)        ; BOUNCE
            BRA     .CHKV                   
            
.BOUNCER    MOVE.W  #SCRWIDTH-1-ENEMRAD,(A0) ; ADJUST X
            MOVE.W  #-ENEMSPEED,4(A0)       ; BOUNCE
            BRA     .CHKV
            
.BOUNCET    MOVE.W  #ENEMRAD,2(A0)          ; ADJUST Y
            MOVE.W  #ENEMSPEED,6(A0)        ; BOUNCE
            BRA     .END
            
.BOUNCEB    MOVE.W  #150-1-ENEMRAD,2(A0)    ; ADJUST Y
            MOVE.W  #-ENEMSPEED,6(A0)       ; BOUNCE
            
.END        MOVEM.L (A7)+,D0                ; STACK REGISTER
            RTS
; -----------------------------------------------------------------------------
ENEMPLT
; ENEMIES PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK REGISTERS
            COLORPEN    #$0000FF00          ; MACRO PEN COLOUR
            COLORFIL    #$000000FF          ; MACRO FILL COLOUR                    
; --- ENEMY'S GUN -------------------------------------------------------------
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            ADD.W   #12,D2
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #ENEMRAD/4,D1           ; D1:=XLEFT
            SUB.W   #ENEMRAD/4,D2           ; D2:=YTOP
            ADD.W   #ENEMRAD/4,D3           ; D3:=XRIGTH
            ADD.W   #ENEMRAD/4,D4           ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT           
              
            COLORPEN    #$0000FF00          ; MACRO PEN COLOUR
            COLORFIL    #$00003300          ; MACRO FILL COLOUR                    
; --- ENEMY'S HEAD ------------------------------------------------------------
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            SUB.W   #10,D2
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #ENEMRAD,D1             ; D1:=XLEFT
            SUB.W   #ENEMRAD,D2             ; D2:=YTOP
            ADD.W   #ENEMRAD,D3             ; D3:=XRIGTH
            ADD.W   #ENEMRAD,D4             ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15            
             
; --- ENEMY'S LEFT WIND -------------------------------------------------------        
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            SUB.W   #20,D1
            ADD.W   #10,D2
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER           
            SUB.W   #ENEMRAD/6,D1           ; D1:=XLEFT
            SUB.W   #ENEMRAD/4,D2           ; D2:=YTOP
            ADD.W   #ENEMRAD/4,D3           ; D3:=XRIGTH
            ADD.W   #ENEMRAD/8,D4           ; D4:=YBOTTOM
            MOVE.B  #87,D0                  ; DRAW RECTANGLE/SQUARE TASK
            TRAP    #15                     ; DO IT 
           
; --- ENEMY'S RIGHT WIND ------------------------------------------------------       
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            ADD.W   #20,D1
            ADD.W   #10,D2
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER           
            SUB.W   #ENEMRAD/4,D1           ; D1:=XLEFT
            SUB.W   #ENEMRAD/4,D2           ; D2:=YTOP
            ADD.W   #ENEMRAD/6,D3           ; D3:=XRIGTH
            ADD.W   #ENEMRAD/8,D4           ; D4:=YBOTTOM
            MOVE.B  #87,D0                  ; DRAW RECTANGLE/SQUARE TASK
            TRAP    #15                     ; DO IT     
      
; --- ENEMY'S BODY -------------------------------------------------------------            
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #ENEMRAD,D1             ; D1:=XLEFT
            SUB.W   #ENEHEIGH,D2            ; D2:=YTOP
            ADD.W   #ENEMRAD,D3             ; D3:=XRIGTH
            ADD.W   #ENEHEIGH,D4            ; D4:=YBOTTOM
            MOVE.B  #87,D0                  ; DRAW RECTANGLE/SQUARE TASK
            TRAP    #15                     ; DO IT            
            
            MOVEM.L (A7)+,D0-D4             ; STACK REGISTERS
            RTS     

*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
