; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   : PAU BONET - JUAN JOSE RODRIGUEZ
; HISTORY  : 28-12-2020
; =============================================================================

; --- SHIP RELATED VARIABLES ---------------------------------------------------

SHIPX       DS.W    1                       ; SHIP X COORDINATE( X CENTER)
CANX        DS.W    1                       ; CANNON X COORDINATE ( X CENTER BOTTOM )
SHIPCORE    DS.W    1


; --- RANDOM NUMBER GENERATOR VARIABLES ---------------------------------------

RNDINDEX    DS.B    1                       ; RANDOM INDEX
            DS.W    0
            
; --- STATE MANAGEMENT VARIABLES ----------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- STARSMAP RELATED VARIABLES ----------------------------------------------

STARX       DS.W    1                       ;STAR X COORDENATE
STARY       DS.W    1                       ;STAR Y COORDENATE

STARSSX     DC.W    20,50,70,80,100,20,30,90,100,50       ;SOME STARS X COORDENATE
            DC.W    150,170,260,300,230,150,270,200,180,130
            DC.W    280,330,270,350,200,270,300,250,270,310
            DC.W    350,370,360,300,330,450,270,300,380,330
            DC.W    500,450,370,410,470,560,500,400,550,450
            DC.W    20,50,70,80,100,20,30,90,100,50
            DC.W    250,300,350,400,280,330,370,400,320,280
            DC.W    500,590,550,490,520,480,570,560,500,550
            DS.W    0
            
STARSSY     DC.W    20,40,60,70,100,150,160,200,250,300    ;SOME STARS Y COORDENATE
            DC.W    50,100,180,230,270,310,350,400,420,470
            DC.W    10,20,150,260,330,270,110,150,370,400
            DC.W    100,180,230,270,310,350,400,420,470,300
            DC.W    100,180,230,270,310,350,400,420,470
            DC.W    180,200,250,360,300,330,340,390,310,350
            DC.W    100,180,230,270,310,350,400,420,470,300
            DC.W    20,40,60,70,100,150,160,200,250,300
            DS.W    0

; --- SCORE RELATED VARIABLES ----------------------------------------------


RECORD      DC.B    'RECORD.TXT',0
            DS.W    0
STRING      DS.B    1                      ; BUFFER 
VECSIZE     DS.W    1
FILEID      DS.L    1

; --- MUSIC RELATED VARIABLES --------------------------------------------

SONGNURE    DS.B    1
            DS.W    0











*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
