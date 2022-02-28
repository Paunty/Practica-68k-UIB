; =============================================================================
; TITLE    : SUPER STARSHIP (MAIN PROGRAM)
; AUTHOR   : PAU BONET ALCOVER- JUAN JOSE RODRIGUEZ
; HISTORY  : 26-DEC-2020 - CREATION
;            15-GEN-2021 - MINOR CHANGES
; =============================================================================
            
            ORG     $1000
            
; --- CODE INCLUDES -----------------------------------------------------------
            
            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "RANDOM.X68"            ; RANDOM
            INCLUDE "AGENTLST.X68"          ; AGENT LIST MANAGEMENT
            INCLUDE "USEFUL.X68"            ; USEFUL THINGS
            INCLUDE "STATES.X68"            ; STATES 
            INCLUDE "SHIP.X68"              ; SHIP CODE
            INCLUDE "BOTO.X68"              ; BOTTON MANAGEMENT
            INCLUDE "STARSMAP.X68"          ; STARS MAP MANAGEMENT
            INCLUDE "ENEMIES.X68"           ; ENEMIES MANAGEMENT
            INCLUDE "SHOT.X68"              ; SHOTS FROM SHIPS
            INCLUDE "BOMB.X68"              ; ENEMY'S BOMB MANAGEMENT
            INCLUDE "SONG.X68"              ; MUSIC CODE

; --- INITIALIZE --------------------------------------------------------------
            
START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF            
            JSR     STAINIT                 ; INITIALIZES STATES            
           
           
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD
            JSR     STAUPD                  ; UPDATE STATES
            
; --- WAIT SYNCH --------------------------------------------------------------
            
.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            
; --- PLOT --------------------------------------------------------------------
                        
            JSR     STAPLOT                 ; PLOT STATES             
            TRAP    #SCRTRAP                ; SHOW GRAPHICS            
            BRA     .LOOP                   ; MAIN LOOP
             
            SIMHALT
            
; --- VARIABLES ---------------------------------------------------------------
            
            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START














*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
