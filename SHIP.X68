*------------------------------------------------------------------------------
;TITLE  : SHIP CODE
;AUTHOR : PAU BONET - JUAN JOSE RODRIGUEZ
;HISTORY: 28-12-2020
*------------------------------------------------------------------------------

;------------------------------------------------------------------------------    
SHIPINIT
;INITIALITZE THE SHIP
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------       
            MOVE.W  #SCRWIDTH/2, (SHIPX)
            RTS
;------------------------------------------------------------------------------
SHIPUPDT
;INITIALITZE THE SHIP
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------
; --- SHIP'S GUN PRESSED ------------------------------------------------------          
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .NOFIRE

            MOVEM.L A1-A3/D0-D2,-(A7)
            LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #SHOTID,D0
            MOVE.W  (SHIPX),D1
            MOVE.W  #SHIPY,D2            
            JSR     AGLADD
            MOVEM.L (A7)+,A1-A3/D0-D2 
        
.NOFIRE     BTST.B  #KBDBITLF,(KBDVAL)      ;LEFT KEY PRESSED
            BNE     .MOVEL
           
            BTST.B  #KBDBITRT,(KBDVAL)      ;RIGHT KEY PRESSED
            BNE     .MOVER
            RTS
.MOVEL      CMP.W   #SHIPWIDH/2,(SHIPX)     ;LIMIT
            BGT     .DOL
            RTS
.DOL        SUB.W   #SHISPEED,(SHIPX)       ;MOVE LEFT
            RTS
.MOVER      CMP.W   #SCRWIDTH-1-SHIPWIDH/2,(SHIPX) ;LIMIT
            BLT     .DOR
            RTS
.DOR        ADD.W   #SHISPEED,(SHIPX)       ;MOVE RIGHT
            RTS

;------------------------------------------------------------------------------
SHIPPLOT
;INITIALITZE THE SHIP
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK         
            
            COLORPEN #$0000FF             ; MACRO PEN COLOUR
            COLORFIL #$0000FF             ; MACRO FILL COLOUR
            MOVE.W  (SHIPX),D1              ; D1 X CENTER
            MOVE.W  #SHIPY,D2               ; D2 Y CENTER
            MOVE.W  D1,D3                   ; D3 X CENTER
            MOVE.W  D2,D4                   ; D4 Y CENTER
            SUB.W   #SHIPWIDH/2,D1          ; D1 X LEFT
            SUB.W   #SHIPHEIG/2,D2          ; D2 Y TOP
            ADD.W   #SHIPWIDH/2,D3          ; D3 X RIGHT
            ADD.W   #SHIPHEIG/2,D4          ; D4 Y BOTTOM
            MOVE.W  #87,D0                  
            TRAP    #15                     ; DRAW SHIP
                       
            LEA     .SCORE,A1               ; CHARGE STRING TO A1
            CLR.L   D1
            MOVE.W  SHIPCORE,D1             ; PUT THE SCORE ON D1
            MOVE.W  #17,D0                  
            TRAP    #15                     ; DO IT 
            
            MOVEM.L (A7)+,D0-D4             ; STACK
            RTS
.SCORE      DC.B    'SCORE: ',0

;------------------------------------------------------------------------------
CAN1INIT
;INITIALITZE THE CANNON
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------           
            MOVE.W  #SCRHEIGH-SCRHEIGH/3,(CANX)
            RTS
;------------------------------------------------------------------------------
CAN1UPDT
;UPDATE THE CANNON
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------ 
            BTST.B  #KBDBITLF,(KBDVAL)      ;LEFT KEY PRESSED
            BNE     .MOVEL2
            BTST.B  #KBDBITRT,(KBDVAL)      ;RIGHT KEY PRESSED
            BNE     .MOVER2
            RTS

.MOVEL2     CMP.W   #CANLIMIT/2,(CANX)     ;LIMIT
            BGT     .DOL2
            RTS
.DOL2       SUB.W   #CANSPEED,(CANX)       ;MOVE LEFT
            RTS
.MOVER2     CMP.W   #SCRWIDTH-1-CANLIMIT/2,(CANX) ;LIMIT
            BLT     .DOR2
            RTS
.DOR2       ADD.W   #CANSPEED,(CANX)       ;MOVE RIGHT
            RTS 
;------------------------------------------------------------------------------
CAN1PLOT
;INITIALITZE THE CANNON
;INPUT    - NONE
;OUTPUT   - NONE
;MODIFIES - NONE
;------------------------------------------------------------------------------   
; --- PRINCIPAL SHIP'S GUN ----------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK
            
            COLORPEN    #$000000FF          ; MACRO PEN COLOUR
            COLORFIL    #$000000FF          ; MACRO FILL COLOUR
            MOVE.W  (CANX),D1               ; D1 X CENTER
            MOVE.W  #CANY,D2                ; D2 Y CENTER
            MOVE.W  D1,D3                   ; D3 X CENTER
            MOVE.W  D2,D4                   ; D4 Y CENTER
            SUB.W   #CAN1WIDH/2,D1          ; D1 X LEFT
            SUB.W   #CAN1HEIG/2,D2          ; D2 Y TOP
            ADD.W   #CAN1WIDH/2,D3          ; D3 X RIGHT
            ADD.W   #CAN1HEIG/2,D4          ; D4 Y BOTTOM
            MOVE.W  #87,D0                  
            TRAP    #15                     ; DRAW CANNON            
            
; ---- FIRST SHIP'S GUN -------------------------------------------------------
            MOVE.W  (CANX),D1               ; D1 X CENTER
            ADD.W   #30,D1                  ; UNA POSICION EN X
            MOVE.W  #CANY,D2                ; D2 Y CENTER
            SUB.W   #10,D2
            MOVE.W  D1,D3                   ; D3 X CENTER
            MOVE.W  D2,D4                   ; D4 Y CENTER
            SUB.W   #CAN1WIDH/2,D1          ; D1 X LEFT
            SUB.W   #CAN1HEIG/2,D2          ; D2 Y TOP
            ADD.W   #CAN1WIDH/2,D3          ; D3 X RIGHT
            ADD.W   #CAN1HEIG/2,D4          ; D4 Y BOTTOM
            MOVE.W  #87,D0                  
            TRAP    #15                     ; DRAW CANNON
      
; ---- THIRD SHIP'S GUN -------------------------------------------------------
            MOVE.W  (CANX),D1               ; D1 X CENTER
            SUB.W   #30,D1                  ; UNA POSICION EN X
            MOVE.W  #CANY,D2    
            SUB.W   #10,D2                  ; D2 Y CENTER
            MOVE.W  D1,D3                   ; D3 X CENTER
            MOVE.W  D2,D4                   ; D4 Y CENTER
            SUB.W   #CAN1WIDH/2,D1          ; D1 X LEFT
            SUB.W   #CAN1HEIG/2,D2          ; D2 Y TOP
            ADD.W   #CAN1WIDH/2,D3          ; D3 X RIGHT
            ADD.W   #CAN1HEIG/2,D4          ; D4 Y BOTTOM
            MOVE.W  #87,D0                  
            TRAP    #15                     ; DRAW CANNON      
            MOVEM.L (A7)+,D0-D4             ; RESTORE STACK           
            RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
