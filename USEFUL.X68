; =============================================================================
; TITLE    : USEFUL
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 14-1-2021

; =============================================================================
; -----------------------------------------------------------------------------
UTLCHCOL
; CHECKS COLLISION
; INPUT    - D0.W X0 COORDINATE
;            D1.W Y0 COORDINATE
;            D2.W X1 COORDINATE
;            D3.W Y1 COORDINATE
;            D4.W WIDTH 0
;            D5.W WIDTH 1
;            D6.W HEIGHT 0
;            D7.W HEIGHT 1
; OUTPUT   - D0.B=FF - COLLISION, =0 - NO COLLISION
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            ADD.W   D0,D4
            CMP.W   D2,D4
            BLE     .NOCOL
            ADD.W   D2,D5
            CMP.W   D0,D5
            BLE     .NOCOL
            ADD.W   D1,D6
            CMP.W   D3,D6
            BLE     .NOCOL
            ADD.W   D3,D7
            CMP.W   D1,D7
            BLE     .NOCOL
            MOVE.B  #$FF,D0
            BRA     .END
.NOCOL      CLR.B   D0
.END        RTS


; -----------------------------------------------------------------------------
FILREAD
; READ FILES
; INPUT    - NONE 
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
 ; --- OPEN FILE ---------------------------------------------------------------
            LEA     RECORD,A1
            MOVE.B  #51,D0
            TRAP    #15
            MOVE.L  D1,FILEID
; --- READ FILE ---------------------------------------------------------------
            
            MOVE.L  #RECORD,D2
            LEA     STRING,A1
            MOVE.B  #53,D0
            TRAP    #15

; --- CLOSE FILE ------------------------------------------------------------
            MOVE.B  #56,D0
            TRAP    #15
            RTS   
            
; -----------------------------------------------------------------------------
FILWRITE
; READ FILES
; INPUT    - NONE 
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
 ; --- OPEN FILE ---------------------------------------------------------------
            LEA     RECORD,A1
            MOVE.B  #51,D0
            TRAP    #15
            MOVE.L  D1,FILEID
            
; --- WRITE FILE -------------------------------------------------------------            
            LEA     STRING,A1
            MOVE.L  FILEID,D1
            CLR.L   D2
            MOVE.W  VECSIZE,D2
            ADD.W   #1,D2
            MOVE.B  #54,D0
            TRAP    #15

; --- CLOSE FILE ------------------------------------------------------------
            MOVE.B  #56,D0
            TRAP    #15
            RTS



; -----------------------------------------------------------------------------
SPAWNUPD
; SPAWN UNITS
; INPUT    - NONE 
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1-A3,-(A7)          ; STACK               
            BTST.B  #15,(SCRCYCCT)
            BEQ     .END
            CLR.L   D1
            MOVE.W  #NUMENEM-1,D1           ; LOOP FOR CREATE AGENTS
            MOVE.W  #ENEMID, D0             ; PUT THE ID FOR THE AGENT
            LEA     ENEINIT, A1
            LEA     ENEMUPD, A2
            LEA     ENEMPLT, A3
.LOOPA      JSR     AGLADD                  ; CREATE AN ENEMY AGENT
            DBRA.W  D1,.LOOPA  

.END        MOVEM.L (A7)+,D0-D1/A1-A3          ; STACK               
            RTS


; ----------------------------------------------------------  
COLORPEN    MACRO
; SET PEN TRAP 15 TASK
; INPUT    : \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   : NONE
; MODIFIES : D0,D1
; ---------------------------------------------------------
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM

; ---------------------------------------------------------
COLORFIL    MACRO
; SET FIL TRAP 15 TASK
; INPUT    : \1 COLOR IN FORMAT $00BBGGRR
; OUTPUT   : NONE
; MODIFIES : D0,D1
; ---------------------------------------------------------
            MOVE.B  #81,D0
            MOVE.L  \1,D1
            TRAP    #15
            ENDM






*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~0~
*~Tab size~4~
