; =============================================================================
; TITLE    : PSEUDO-RANDOM NUMBER GENERATOR
; AUTHOR   : ANTONI BURGUERA
; COMMENTS : VERY LAZY AND STUPID "ALGORITHM" IMPLEMENTED.
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

; -----------------------------------------------------------------------------
RNDINIT
; INITIALIZES RANDOM NUMBER GENERATOR
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CLR.B   (RNDINDEX)
            RTS
; -----------------------------------------------------------------------------
RNDGET
; PROVIDES A PSEUDO-RANDOM BYTE
; INPUT    - NONE
; OUTPUT   - D0.L RANDOM VALUE (ONLY BYTE)
; MODIFIES - NONE (ASIDE OF OUTPUT)
; -----------------------------------------------------------------------------
            MOVE.L  A0,-(A7)
            LEA     .RANDVEC,A0
            CLR.L   D0
            MOVE.B  (RNDINDEX),D0
            MOVE.B  (A0,D0.L),D0
            ADDQ.B  #1,(RNDINDEX)
            MOVE.L  (A7)+,A0
            RTS

.RANDVEC    DC.B    162, 238, 154, 12 , 245, 36 , 32 , 103
            DC.B    42 , 163, 81 , 38 , 224, 172, 19 , 69
            DC.B    117, 81 , 202, 253, 51 , 235, 108, 154
            DC.B    96 , 204, 231, 184, 154, 235, 34 , 203
            DC.B    29 , 118, 181, 149, 176, 137, 62 , 108
            DC.B    57 , 21 , 72 , 201, 110, 202, 159, 41
            DC.B    67 , 231, 226, 124, 55 , 37 , 84 , 62
            DC.B    233, 148, 206, 233, 228, 82 , 243, 78
            DC.B    55 , 109, 154, 132, 162, 40 , 30 , 39
            DC.B    25 , 226, 198, 119, 128, 212, 232, 225
            DC.B    10 , 90 , 50 , 103, 51 , 194, 222, 40
            DC.B    89 , 128, 220, 14 , 87 , 252, 243, 252
            DC.B    138, 171, 188, 247, 7  , 77 , 29 , 234
            DC.B    239, 213, 119, 110, 30 , 187, 131, 23
            DC.B    214, 224, 42 , 143, 189, 40 , 212, 130
            DC.B    19 , 79 , 102, 236, 10 , 100, 122, 188
            DC.B    86 , 82 , 154, 22 , 155, 144, 7  , 199
            DC.B    6  , 138, 164, 247, 1  , 218, 166, 82
            DC.B    242, 231, 119, 40 , 177, 118, 220, 102
            DC.B    164, 66 , 227, 129, 177, 103, 165, 108
            DC.B    191, 206, 250, 22 , 191, 56 , 30 , 161
            DC.B    209, 139, 80 , 12 , 95 , 73 , 168, 56
            DC.B    222, 76 , 20 , 162, 64 , 220, 93 , 12
            DC.B    182, 155, 10 , 56 , 93 , 171, 89 , 6
            DC.B    226, 27 , 221, 117, 21 , 130, 101, 18
            DC.B    138, 38 , 81 , 48 , 159, 71 , 57 , 21
            DC.B    30 , 138, 187, 113, 198, 110, 185, 152
            DC.B    159, 71 , 229, 52 , 148, 39 , 77 , 6
            DC.B    125, 6  , 214, 186, 48 , 15 , 212, 22
            DC.B    236, 127, 126, 3  , 207, 45 , 193, 2
            DC.B    148, 91 , 35 , 242, 139, 205, 248, 237
            DC.B    116, 51 , 236, 185, 15 , 213, 221, 6



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
