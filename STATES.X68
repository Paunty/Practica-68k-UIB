; =============================================================================
; TITLE    : GAME STATE MANAGEMENT
; AUTHOR   : PAU BONET ALCOVER, JUAN JOSE RODRIGUEZ ARANDA
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #-1,(STACUR)            ; INVALID STATE, JUST TO FORCE INIT
            MOVE.W  #0,(STANEXT)            ; INITIAL STATE
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STAINTRI,STAINSTI,STAPLAYI,STAGOVRI
.UPDTBL     DC.L    STAINTRU,STAINSTU,STAPLAYU,STAGOVRU

; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.PLTTBL     DC.L    STAINTRP,STAINSTP,STAPLAYP,STAGOVRP

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
STAINTRI    
; GAME INTRO INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JMP     BOTINIT                 ; INITIALIZES BOTO
            JSR     STARINI                 ; INITIALIZES STARS
            RTS
; -----------------------------------------------------------------------------
STAINTRU
; GAME INTRO UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     STARUPD                ; UPDATE STARS
            JSR     BOTUPD                 ; UPDATE BOTO
            
            BTST.B  #KBDBITF1,(KBDEDGE)     ; SPACE IS PRESSED -> GAME
            BEQ     .INTRO                    
            MOVE.W  #STAGAME,(STANEXT)
            RTS
            
.INTRO      BTST.B  #KBDBITF3,(KBDEDGE)     ; SHIFT IS PRESSED -> INSTRUCIONS
            BEQ     .END
            MOVE.W #STAINSTR,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAINTRP
; GAME INTRO PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D5/A1,-(A7)          ; STACK REGISTERS            
            JSR     STARPLT                 ; PLOT STAR            
            JSR     BOTPLOT                 ; PLOT BOTO
; --- 1 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|7,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR0,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- 2 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|8,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR1,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- 3 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|9,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR2,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- 4 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|10,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR3,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT            
; --- 5 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|11,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR4,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT             
; --- 6 LINE ------------------------------------------------------------------                                     
            MOVE.W  #((80-52)/2)<<8|12,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR5,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT           
; --- 7 LINE ------------------------------------------------------------------                                                       
            MOVE.W  #((80-52)/2)<<8|13,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR6,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT          
; --- 8 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|14,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR7,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT          
; --- 9 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-52)/2)<<8|15,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR8,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT         
; --- 10 LINE -----------------------------------------------------------------                                 
            MOVE.W  #((80-52)/2)<<8|16,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR9,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT    
; --- 11 LINE -----------------------------------------------------------------                                 
            MOVE.W  #((80-52)/2)<<8|17,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR10,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT      
; --- 12 LINE -----------------------------------------------------------------                                                       
            MOVE.W  #((80-52)/2)<<8|18,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR11,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- 13 LINE -----------------------------------------------------------------                                                 
            BTST.B  #4,(SCRCYCCT)
            BEQ     .END
    
            MOVE.W  #((80-56)/2)<<8|25,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR12,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT        
; --- 14 LINE -----------------------------------------------------------------                                 
            MOVE.W  #((80-4)/2)<<8|20,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR13,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- STARTS MUSIC -----------------------------------------------------------
            MOVE.B  #PLAYREF,(SONGNURE)
            LEA     MUSICWAV,A1
            JSR     PLAYSONG
; ----------------------------------------------------------------------------

.END        MOVEM.L (A7)+,D0-D5/A1
            RTS
.STR0        DC.B    '         ___             ___     ___    ___         ',0          
.STR1        DC.B    '        /   \   |   |   |   \   |      |   \        ',0
.STR2        DC.B    '        \___    |   |   |___/   |___   |___/        ',0
.STR3        DC.B    '            \   |   |   |       |      | \          ',0
.STR4        DC.B    '        ____/   \___/   |       |___   |  \         ',0
.STR5        DC.B    '                                                    ',0     
.STR6        DC.B    '  ___  _____   _      ___     ___              ___  ',0          
.STR7        DC.B    ' /   \   |    / \    |   \   /      |   |  |  |   \ ',0
.STR8        DC.B    ' \___    |   /___\   |___/   \___   |___|  |  |___/ ',0
.STR9        DC.B    '     \   |  /     \  | \         \  |   |  |  |     ',0
.STR10       DC.B    ' ____/   | /       \ |  \     ___/  |   |  |  |     ',0
.STR11       DC.B    '                                                    ',0          

.STR12      DC.B    'PUSH SPACE KEY OR SHIFT (+CTRL ON MACOS) TO INSTRUCTIONS',0
.STR13      DC.B    'PLAY',0
            DS.W    0

; -----------------------------------------------------------------------------
STAPLAYI
; GAME INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     STARINI
            JSR     SHIPINIT
            JSR     CAN1INIT
            MOVE.W  #$0000,(SHIPCORE)       ; INITIALIZE SCORE TO 0        
            RTS

; -----------------------------------------------------------------------------
STAPLAYU
; GAME UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     STARUPD                 ; UPDATE STAR
            JSR     SHIPUPDT                ; UPDATE SHIP
            JSR     CAN1UPDT                ; UPDATE CANON
            JSR     SPAWNUPD                ; UPDATE SPAWN
            JSR     AGLUPD
            RTS
        

; -----------------------------------------------------------------------------
STAPLAYP
; GAME PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     STARPLT
            JSR     SHIPPLOT
            JSR     CAN1PLOT
            
            JSR     AGLPLOT
            RTS
; -----------------------------------------------------------------------------
STAGOVRI    EQU     STAEMPTY
; GAME OVER INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            JSR     STARINI
            JSR     STOPSONG
            MOVEM.L D1/A1,-(A7)          ; STACK REGISTERS
            JSR FILREAD
            MOVE.W  A1,D1
            CMP.W   (SHIPCORE),D1
            BLT     .END
            JSR FILWRITE
    
.END        MOVEM.L (A7)+,D1/A0          ; STACK REGISTERS
          
            RTS
; -----------------------------------------------------------------------------
STAGOVRU
; GAME OVER UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     STARUPD             
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAINTRO,(STANEXT)
.END        RTS

; -----------------------------------------------------------------------------
STAGOVRP
; GAME PLOT PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)          ; STACK REGISTERS
            JSR     STARPLT
            COLORPEN    #$00FF0110          ; MACRO PEN COLOUR
            COLORFIL    #$00FF0110          ; MACRO FILL COLOUR 
; --- 1 LINE ------------------------------------------------------------------                                             
            MOVE.W  #((80-10)/2)<<8|10,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR0,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
; --- 2 LINE ------------------------------------------------------------------                                       
            MOVE.W  #((80-42)/2)<<8|12,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR1,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
            
; --- 3 LINE -----------------------------------------------------------------
            
            MOVE.W  #((80-18)/2)<<8|14,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR2,A1               ; CHARGE STRING TO A1
            CLR.L   D1
            MOVE.W  SHIPCORE,D1             ; PUT THE SCORE ON D1
            MOVE.W  #17,D0                  
            TRAP    #15                     ; DO IT 
            
; --- 4 LINE ------------------------------------------------------------------

            MOVE.W  #((75-16)/2)<<8|16,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR4,A1                ; CHARGE STRING TO A1
            MOVE.W  #13,D0 
            TRAP    #15

            MOVE.W  #((95-2)/2)<<8|16,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15           
            JSR     FILREAD             
            MOVE.W  #13,D0 
            TRAP    #15                     ; DO IT     
 
; --- 5 LINE ------------------------------------------------------------------
            BTST.B  #3,(SCRCYCCT)
            BEQ     .END
    
            MOVE.W  #((80-25)/2)<<8|25,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR3,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT


.END        MOVEM.L (A7)+,D0-D1/A1
            RTS
.STR0       DC.B    'GAME  OVER',0
.STR1       DC.B    'YOU ARE THE WORST PLAYER IN THE UNIVERSITY',0
.STR2       DC.B    'YOUR SCORE WAS: ',0
.STR3       DC.B    'PUSH SPACE KEY TO RESTART',0
.STR4       DC.B    'YOUR RECORD WAS: ',0
            DS.W    0



; -----------------------------------------------------------------------------
STAINSTI    EQU     STAEMPTY
; INSTRUCTIONS INITIALIZATION
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
STAINSTU
; INSTRUCTIONS UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .END
            MOVE.W  #STAINTRO,(STANEXT)
.END        RTS


; -----------------------------------------------------------------------------
STAINSTP
; INSTRUCTIONS PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)          ; STACK REGISTERS

; --- 1 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-28)/2)<<8|7,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR0,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
            
; --- 2 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-51)/2)<<8|12,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR1,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT

; --- 3 LINE ------------------------------------------------------------------                                           
            MOVE.W  #((80-22)/2)<<8|14,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR2,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT

; --- 4 LINE ------------------------------------------------------------------                                              
            MOVE.W  #((80-14)/2)<<8|16,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR3,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT            

; --- 5 LINE ------------------------------------------------------------------                                  
            MOVE.W  #((80-58)/2)<<8|18,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR4,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT  
      
; --- 6 LINE ------------------------------------------------------------------                                  
            BTST.B  #4,(SCRCYCCT)
            BEQ     .END
    
            MOVE.W  #((80-22)/2)<<8|25,D1   ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR5,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15                     ; DO IT
.END        MOVEM.L (A7)+,D0-D1/A1
            RTS
.STR0       DC.B    'INSTRUCTIONS AND EXPLANATION',0
.STR1       DC.B    'YOU MUST DESTROY ALL THE BALLS THAT YOU HAVE IN TOP',0
.STR2       DC.B    'PUSH SPACE KEY TO SHOT',0
.STR3       DC.B    'MAKE YOUR BEST',0
.STR4       DC.B    'IF YOUR SCORE IS LESS THAN 40 GO TO ANOTHER GAME LOOSER ;)',0
.STR5       DC.B    'PUSH SPACE KEY TO SKIP',0
            DS.W    0


; -----------------------------------------------------------------------------
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
