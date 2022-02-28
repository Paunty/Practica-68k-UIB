; =============================================================================
; TITLE    : GAME CONSTANTS
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 28-12-2020
; =============================================================================

; ----- SHIP CONSTANTS --------------------------------------------------------
SHIPWIDH    EQU     64                      ; SHIP WIDTH
SHIPHEIG    EQU     16                      ; SHIP HEIGH
SHIPY       EQU     SCRHEIGH-SHIPHEIG-SHIPHEIG/2 ;SHIP Y COORDINATE  
SHISPEED    EQU     12                      ; SHIP SPEED
SHIPSCOX    EQU     2                       ; SCORE X COORDINATE
SHIPSCOY    EQU     1                       ; SCORE Y COORDINATE

; ----- CANNON CONSTANTS ------------------------------------------------------
CAN1WIDH    EQU     8                       ; CANNON WIDTH
CAN1HEIG    EQU     32                      ; CANNON HEIGH    
CANLIMIT    EQU     64
CAN2WIDH    EQU     8                       ; CANNON WIDTH
CAN2HEIG    EQU     32                      ; CANNON HEIGH  
CANSPEED    EQU     12                      ; CANNON SPEED
CANY        EQU     SCRHEIGH-CAN1HEIG-CAN1HEIG/2 ;CANNON Y COORDINATE  

; ---- SHOT CONSTANTS -------------------------------------------------------
SHTWIDTH    EQU     20                      ; SHOT WIDTH (PIXELS)
SHTHEIGH    EQU     3                       ; SHOT HEIGHT. ONLY TO DRAW.
SHTSPEED    EQU     4                       ; SHOT SPEED (PIXELS PER INT)

; --- AGENT CONSTANTS ------------------------------------------------------
SHOTID      EQU     1                       ; SHOT AGENT ID
ENEMID      EQU     2                       ; ENEMY AGENT ID
BOMBID      EQU     3                       ; BOMB AGENT ID

; --- STATE RELATED VARIABLES -------------------------------------------------
STAINTRO    EQU     0                       ; GAME INTRO SCREEN STATE
STAINSTR    EQU     1                       ; GAME INSTRUCTIONS STATE
STAGAME     EQU     2                       ; GAME STATE
STAGOVER    EQU     3                       ; GAME OVER STATE
            
; --- BOTTON RELATED CONSTANTS ------------------------------------------------
BOTGAMX     EQU     SCRWIDTH/2
BOTGAMY     EQU     306                     ; BOTON Y COORDENATE
BOTWIDTH    EQU     64                      ; BOTON WIDTH
BOTHEIGH    EQU     16                      ; BOTON HEIGHT

; --- STARMAP RELATED CONSTANTS -----------------------------------------------
STAWIDTH    EQU     2                       ;STAR WIDTH
STAHEIGH    EQU     2                       ;STAR HEIGH
 
; --- ENEMIES RELATED CONSTANTS -----------------------------------------------
ENEMSPEED   EQU     5                       ; ENEMY REFERENCE SPEED
ENEMRAD     EQU     18                      ; ENEMYS SHIP RADIOUS
ENEHEIGH    EQU     10
NUMENEM     EQU     2                       ; NUMBER OF ENEMYS SPAWNED
ENEMCORE    EQU     10                      ; NUMBER OF POINTS ENEMY KILLED

; --- BOMB RELATED CONSTANTS --------------------------------------------------
BOMRAD      EQU     6                       ; BOMB RADIOUS (PIXELS)
BOMSPEED    EQU     8                       ; BOMB SPEED (PIXELS PER INT)

; --- MUSIC RELATED CONSTANTS -------------------------------------------------

PLAYREF     EQU     1                       ; MUSIC REFERENCE  
MUSICWAV    DC.B    'MUSICA.wav',0          ; SONG
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
