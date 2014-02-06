INCLUDE "includes.asm"

placestring_: MACRO
    hlcoord \1, \2
    ld de, \3
    call PlaceString
    ENDM

jbutton: MACRO
	ld a, [hJoyPressed]
	and \1
	jp nz, \2 ; TODO jx
    ENDM

printbit: MACRO
    ld hl, \1
    bit \2, [hl]
    decoord \3, \4
    jr z, .notset\@
    ld a, \5
    ld [de], a
    jr .end\@
.notset\@
    ld a, \6
    ld [de], a
.end\@
    inc de
    ENDM

textbox: MACRO
    hlcoord \1, \2
    ld bc, ( (\4-\2) << 8) + (\3-\1)
    call TextBox
    ENDM

NUMSONGS EQU 113

SECTION "bank79", ROMX, BANK[$79]

MusicPlayer:
	ld de, MUSIC_NONE
	call PlayMusic
	;call WhiteBGMap
	;call ClearTileMap
	ld bc, MPTilemapEnd-MPTilemap
	ld hl, MPTilemap
	decoord 0, 0
	call CopyBytes
.loop
    call DelayFrame
	call GetJoypad
	jbutton B_BUTTON, .exit
	jbutton D_LEFT, .left
	jbutton D_RIGHT, .right
	jbutton A_BUTTON, .a
	call DrawChData
    jr .loop
.left
    ld a, [wSongSelection]
    dec a
    cp a, $ff
    jr nz, .redraw
    ld a, NUMSONGS-1
    jr .redraw
.right
    ld a, [wSongSelection]
    inc a
    cp a, NUMSONGS
    jr nz, .redraw
    xor a
    jr .redraw
.redraw
    ld [wSongSelection], a
	ld a, " "
	hlcoord 0, 1
	ld bc, 60
	call ByteFill
	hlcoord 0, 1
	ld de, wSongSelection
	ld bc, $0103
	call PrintNum
	call DrawSongName
	jr .loop
.a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	callba PlayMusic2
	jr .loop
.exit
    ret

DrawChData:
    printbit Channel1Flags,  0, 0, 5, "1", "-" ; enabled
    printbit Channel1Flags,  4, 1, 5, "N", "n" ; noise sampling
    printbit Channel1Flags2, 0, 2, 5, "V", "v" ; vibrato
    printbit Channel1Flags2, 2, 3, 5, "D", "d" ; dutycycle
    printbit Channel1Flags3, 0, 4, 5, "U", "D" ; vibrato up/down
    ld a, [Channel1Pitch]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 1, 7
    call PlaceString
    ld a, [Channel1Octave]
    add $f6
    hlcoord 3, 7
    ld [hli], a
    
    hlcoord 0, 6
	ld de, Channel1Tempo
	ld bc, $0103
	call PrintNum
    
    hlcoord 1, 8
	ld de, Channel1NoteDuration
	ld bc, $0103
	call PrintNum
	
	
; CHANNEL 2
    printbit Channel1Flags+$32,  0, 6+0, 5, "1", "-" ; enabled
    printbit Channel1Flags+$32,  4, 6+1, 5, "N", "n" ; noise sampling
    printbit Channel1Flags2+$32, 0, 6+2, 5, "V", "v" ; vibrato
    printbit Channel1Flags2+$32, 2, 6+3, 5, "D", "d" ; dutycycle
    printbit Channel1Flags3+$32, 0, 6+4, 5, "U", "D" ; vibrato up/down
    ld a, [$c145]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 6+1, 7
    call PlaceString
    ld a, [$c146]
    add $f6
    hlcoord 6+3, 7
    ld [hli], a
    
    hlcoord 6+1, 8
	ld de, $c148
	ld bc, $0103
	call PrintNum

; CHANNEL 3
    printbit Channel3+3,  0, 12+0, 5, "1", "-" ; enabled
    
    ld a, [$c177]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 12+1, 7
    call PlaceString
    ld a, [$c178]
    add $f6
    hlcoord 12+3, 7
    ld [hli], a
    
    hlcoord 12+1, 8
	ld de, $c17a
	ld bc, $0103
	call PrintNum
	
; CHANNEL 4
    printbit Channel4+3,  0, 18+0, 5, "1", "-" ; enabled
    ret

DrawSongName:
    ld a, [wSongSelection]
    ld b, a
    ld hl, SongNames
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr z, .found
.wrongcomposer
    ld a, [hli]
    cp "@"
    jr nz, .wrongcomposer
.wrongname
    ld a, [hli]
    cp "@"
    jr nz, .wrongname
    jr .loop
.found
    push hl
    pop de
    hlcoord 5, 1
    call PlaceString
    inc de
    hlcoord 0, 2
    call PlaceString
    ret
.noname
    ret

MusicPlayerText:
    db "--- MUSIC PLAYER ---@"

ZeroText:
    db "000@"

NoteNames:
    db "- @C @C'@D @D'@E @F @F'@G @G'@A @A'@B @XX@"
; ┌─┐│└┘
MPTilemap:
db "──┘ MUSIC PLAYER └──"
db "                    "
db "                    "
db "                    "
db "─Ch1───Ch2───Ch3─Ch4"
db "     │     │     │  "
db "     │     │     │  "
db "     │     │     │  "
db "     │     │     │  "
db "────────────────────"
db "                    "
db "                    "
db "                    "
db "                    "
db "                    "
db "                    "
db "                    "
db "                    "
MPTilemapEnd

SongNames:
    db 0, "@", "- None -@"
    db 1, "@", "Title Screen@"
    db 2, "Junichi Masuda@", "Route 1@"
    db 103, "Frogg@", "Johto Battle (Kanto Remix)@"
    db 104, "Frogg@", "Cerulean City (HGSS)@"
    db 105, "Frogg@", "Cinnabar Island (HGSS)@"
    db 110, "Levus@", "Wild Battle (Prism)@"
    db 111, "GRonnoc@", "Gym Leader Battle (Prism)@"
    db 112, "Cat333Pokémon@", "Pallet Battle (Prism)@"
    db -1






