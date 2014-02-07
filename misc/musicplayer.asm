;Written by Sanqui
INCLUDE "includes.asm"

SECTION "Music_Player", ROMX, BANK[MUSIC_PLAYER]

NUMSONGS EQU 167

MusicTestGFX:
INCBIN "gfx/misc/music_test.2bpp"

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

MusicPlayer:
	;ld de, 01
	;call PlayMusic
	;call WhiteBGMap
	;call ClearTileMap
	di
	ld hl, $ff41
	ld a, 1
.wait
	ld a, [hl]
	and 3
	cp a,1
	jr nz, .wait
	ld b, MUSIC_PLAYER ;load the gfx
	ld c, 10
	ld de, MusicTestGFX
	ld hl, $8c60
	call Copy2bpp
	ei

	ld bc, MPTilemapEnd-MPTilemap
	ld hl, MPTilemap
	decoord 0, 0
	call CopyBytes
	ld a, [CurMusic]
	jr .redraw
.loop
    call DelayFrame
	call GetJoypad
	jbutton B_BUTTON, .exit
	jbutton D_LEFT, .left
	jbutton D_RIGHT, .right
	jbutton D_DOWN, .down
	jbutton D_UP, .up
	jbutton A_BUTTON, .a
	jbutton SELECT, .select
	call DrawChData
    jr .loop
.left
    ld a, [wSongSelection]
    dec a
    cp a, $0
    jr nz, .redraw
    ld a, NUMSONGS-1
    jr .redraw
.right
    ld a, [wSongSelection]
    inc a
    cp a, NUMSONGS
    jr nz, .redraw
    ld a, 1
    jr .redraw
.down
    ld a, [wSongSelection]
    sub a, 10
    cp a, NUMSONGS
    jr c, .redraw
    ld a, NUMSONGS-1
    jr .redraw
.up
    ld a, [wSongSelection]
    add a, 10
    cp a, NUMSONGS
    jr c, .redraw
    ld a, 1
    jr .redraw
.redraw
    ld [wSongSelection], a
	ld [CurMusic], a
	ld a, " "
	hlcoord 5, 2
	ld bc, 95
	call ByteFill
	hlcoord 0, 8
	ld bc, 40
	call ByteFill
	hlcoord 0, 11
	ld bc, 40
	call ByteFill
	hlcoord 5, 2
	ld de, wSongSelection
	ld bc, $0103
	call PrintNum
	call DrawSongInfo
	hlcoord 16, 1
	ld de, .daystring
	ld a, [GBPrinter]
	bit 2, a
	jr nz, .nitemusic
.drawtimestring
	call PlaceString
	jp .loop
.nitemusic
	ld de, .nitestring
	jr .drawtimestring
.nitestring
	db "Nite@"
.daystring
	db "    @"
.a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	callba PlayMusic2
	jp .loop
.select
	ld a, [GBPrinter]
	xor 4
	ld [GBPrinter], a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	callba PlayMusic2
	ld a, [wSongSelection]
	jp .redraw
.exit
    ret

DrawChData:
    printbit Channel1Flags,  0, 0, 15, "1", "-" ; enabled
    printbit Channel1Flags,  4, 1, 15, "N", "n" ; noise sampling
    printbit Channel1Flags2, 0, 2, 15, "V", "v" ; vibrato
    printbit Channel1Flags2, 2, 3, 15, "D", "d" ; dutycycle
    printbit Channel1Flags3, 0, 4, 15, "U", "D" ; vibrato up/down
    ld a, [Channel1Pitch]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 1, 16
    call PlaceString
    ld a, [Channel1Octave]
    add $f6
    hlcoord 3, 16
    ld [hli], a
    
    hlcoord 0, 14
	ld de, Channel1Tempo
	ld bc, $0103
	call PrintNum
	
	
; CHANNEL 2
    printbit Channel1Flags+$32,  0, 6+0, 15, "1", "-" ; enabled
    printbit Channel1Flags+$32,  4, 6+1, 15, "N", "n" ; noise sampling
    printbit Channel1Flags2+$32, 0, 6+2, 15, "V", "v" ; vibrato
    printbit Channel1Flags2+$32, 2, 6+3, 15, "D", "d" ; dutycycle
    printbit Channel1Flags3+$32, 0, 6+4, 15, "U", "D" ; vibrato up/down
    ld a, [$c145]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 6+1, 16
    call PlaceString
    ld a, [$c146]
    add $f6
    hlcoord 6+3, 16
    ld [hli], a

; CHANNEL 3
    printbit Channel3+3,  0, 12+0, 15, "1", "-" ; enabled
    
    ld a, [$c177]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 12+1, 16
    call PlaceString
    ld a, [$c178]
    add $f6
    hlcoord 12+3, 16
    ld [hli], a
    	
; CHANNEL 4
    printbit Channel4+3,  0, 18+0, 15, "1", "-" ; enabled
    ret

DrawSongInfo:
    ld a, [wSongSelection]
    ld b, a
    ld hl, SongInfo
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr z, .found
.loop2
    ld a, [hli]
	cp "@"
	jr z, .nextline
    jr .loop2
.found
    push hl
    pop de
    hlcoord 0, 4
    call PlaceString
	inc de
	push de
	call GetSongOrigin
    hlcoord 0, 3
    call PlaceString
	pop de
    inc de
	push de
	call GetSongArtist
    hlcoord 0, 8
    call PlaceString
	pop de
    inc de
	push de
	call GetSongArtist
    hlcoord 0, 11
    call PlaceString
	pop de
    ret
.nextline
	inc hl
	inc hl
	inc hl
	jr .loop
.noname
    ret

GetSongOrigin:
    ld a, [de]
    ld b, a
    ld hl, Origin
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr nz, .loop
    push hl
    pop de
    ret
.noname
	ld de, BlankName
    ret

GetSongArtist:
    ld a, [de]
    ld b, a
    ld hl, Artist
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr nz, .loop
    push hl
    pop de
    ret
.noname
	ld de, BlankName
    ret

MusicPlayerText:
    db "--- MUSIC PLAYER ---@"

ZeroText:
    db "000@"

NoteNames:
    db "- @C @C",198,"@D @D",198,"@E @F @F",198,"@G @G",198,"@A @A",198,"@B @XX@"
; ┌─┐│└┘
MPTilemap:
db "──┘ MUSIC PLAYER └──"
db "                    "
db "Song:               "
db "                    "
db "                    "
db "                    "
db "                    "
db "Composer:           "
db "                    "
db "                    "
db "Arranger:           "
db "                    "
db "                    "
db "─Ch1───Ch2───Ch3─Ch4"
db "     │     │     │  "
db "     │     │     │  "
db "     │     │     │  "
db "────────────────────"
MPTilemapEnd

BlankName:
	db " @"
SongInfo:
    db 001, "Title Screen@", 3, 1, 1
    db 002, "Route 1@", 3, 1, 1
    db 003, "Route 3@", 3, 1, 1
    db 004, "Route 11@", 3, 1, 1
    db 005, "Magnet Train@", 3, 1, 1
    db 006, "Vs. Kanto Gym Leader@", 3, 1, 1
    db 007, "Vs. Kanto Trainer@", 3, 1, 1
    db 008, "Vs. Kanto Wild@", 3, 1, 1
    db 009, "Pokémon Center@", 3, 1, 1
    db 010, "Spotted! Hiker@", 3, 1, 1
    db 011, "Spotted! Girl 1@", 3, 1, 1
    db 012, "Spotted! Boy 1@", 3, 1, 1
    db 013, "Heal Pokémon@", 3, 1, 1
    db 014, "Lavender Town@", 3, 1, 1
    db 015, "Viridian Forest@", 3, 1, 1
    db 016, "Kanto Cave@", 3, 1, 1
    db 017, "Follow Me!@", 3, 1, 1
    db 018, "Game Corner@", 3, 1, 1
    db 019, "Bicycle@", 3, 1, 1
    db 020, "Hall of Fame@", 3, 1, 1
    db 021, "Viridian City@", 3, 1, 1
    db 022, "Celedon City@", 3, 1, 1
    db 023, "Victory! Trainer@", 3, 1, 1
    db 024, "Victory! Wild@", 3, 1, 1
    db 025, "Victory! Champion@", 3, 1, 1
    db 026, "Mt. Moon@", 3, 1, 1
    db 027, "Gym@", 3, 1, 1
    db 028, "Pallet Town@", 3, 1, 1
    db 029, "Oak's Lab@", 3, 1, 1
    db 030, "Professor Oak@", 3, 1, 1
    db 031, "Rival Appears@", 3, 1, 1
    db 032, "Rival Departure@", 3, 1, 1
    db 033, "Surfing@", 3, 1, 1
    db 034, "Evolution@", 3, 1, 1
    db 035, "National Park@", 3, 1, 1
    db 036, "Credits@", 3, 1, 1
    db 037, "Azalea Town@", 3, 1, 1
    db 038, "Cherrygrove City@", 3, 1, 1
    db 039, "Spotted! Kimono Girl@", 3, 1, 1
    db 040, "Union Cave@", 3, 1, 1
    db 041, "Vs. Johto Wild@", 3, 1, 1
    db 042, "Vs. Johto Trainer@", 3, 1, 1
    db 043, "Route 30@", 3, 1, 1
    db 044, "Ecruteak City@", 3, 1, 1
    db 045, "Violet City@", 3, 1, 1
    db 046, "Vs. Johto Gym Leader@", 3, 1, 1
    db 047, "Vs. Champion@", 3, 1, 1
    db 048, "Vs. Rival@", 3, 1, 1
    db 049, "Vs. Rocket Grunt@", 3, 1, 1
    db 050, "Elm's Lab@", 3, 1, 1
    db 051, "Dark Cave@", 3, 1, 1
    db 052, "Route 29@", 3, 1, 1
    db 053, "Route 34@", 3, 1, 1
    db 054, "S.S. Aqua@", 3, 1, 1
    db 055, "Spotted! Boy 2@", 3, 1, 1
    db 056, "Spotted! Girl 2@", 3, 1, 1
    db 057, "Spotted! Team Rocket@", 3, 1, 1
    db 058, "Spotted! Suspicious@", 3, 1, 1
    db 059, "Spotted! Sage@", 3, 1, 1
    db 060, "New Bark Town@", 3, 1, 1
    db 061, "Goldenrod City@", 3, 1, 1
    db 062, "Vermilion City@", 3, 1, 1
    db 063, "Pokémon Channel@", 3, 1, 1
    db 064, "PokéFlute@", 3, 1, 1
    db 065, "Tin Tower@", 3, 1, 1
    db 066, "Sprout Tower@", 3, 1, 1
    db 067, "Burned Tower@", 3, 1, 1
    db 068, "Olivine Lighthouse@", 3, 1, 1
    db 069, "Route 42@", 3, 1, 1
    db 070, "Indigo Plateau@", 3, 1, 1
    db 071, "Route 38@", 3, 1, 1
    db 072, "Rocket Hideout@", 3, 1, 1
    db 073, "Dragon's Den@", 3, 1, 1
    db 074, "Vs. Johto Wild Night@", 3, 1, 1
    db 075, "Unown Radio@", 3, 1, 1
    db 076, "Captured Pokémon@", 3, 1, 1
    db 077, "Route 26@", 3, 1, 1
    db 078, "Mom@", 3, 1, 1
    db 079, "Victory Road@", 3, 1, 1
    db 080, "Pokémon Lullaby@", 3, 1, 1
    db 081, "Pokémon March@", 3, 1, 1
    db 082, "Opening 1@", 3, 1, 1
    db 083, "Opening 2@", 3, 1, 1
    db 084, "Load Game@", 3, 1, 1
    db 085, "Ruins of Alph Inside@", 3, 1, 1
    db 086, "Team Rocket@", 3, 1, 1
    db 087, "Dancing Hall@", 3, 1, 1
    db 088, "Bug Contest Ranking@", 3, 1, 1
    db 089, "Bug Contest@", 3, 1, 1
    db 090, "Rocket Radio@", 3, 1, 1
    db 091, "GameBoy Printer@", 3, 1, 1
    db 092, "Post Credits@", 3, 1, 1
    db 093, "Clair@", 4, 1, 1
    db 094, "Mobile Adapter Menu@", 4, 1, 1
    db 095, "Mobile Adapter@", 4, 1, 1
    db 096, "Buena's Password@", 4, 1, 1
    db 097, "Eusine@", 4, 1, 1
    db 098, "Opening@", 4, 1, 1
    db 099, "Battle Tower@", 4, 1, 1
    db 100, "Vs. Suicune@", 4, 1, 1
    db 101, "Battle Tower Lobby@", 4, 1, 1
    db 102, "Mobile Center@", 4, 1, 1
    db 103, "Opening@", 1, 1, 1
    db 104, "Opening@", 2, 1, 1
    db 105, "Title Screen@", 1, 1, 1
    db 106, "Introduction@", 1, 1, 1
    db 107, "Pallet Town@", 1, 1, 1
    db 108, "Professor Oak@", 1, 1, 1
    db 109, "Oak's Lab@", 1, 1, 1
    db 110, "Rival Appears@", 1, 1, 1
    db 111, "Rival Departure@", 1, 1, 1
    db 112, "Route 1@", 1, 1, 1
    db 113, "Viridian City@", 1, 1, 1
    db 114, "Pokémon Center@", 1, 1, 1
    db 115, "Heal Pokémon@", 1, 1, 1
    db 116, "Viridian Forest@", 1, 1, 1
    db 117, "Follow Me!@", 1, 1, 1
    db 118, "Gym@", 1, 1, 1
    db 119, "Jigglypuff Sings@", 1, 1, 1
    db 120, "Route 3@", 1, 1, 1
    db 121, "Mt. Moon@", 1, 1, 1
    db 122, "Jessie and James@", 2, 1, 1
    db 123, "Cerulean City@", 1, 1, 1
    db 124, "Vermilion City@", 1, 1, 1
    db 125, "S.S. Anne@", 1, 1, 1
    db 126, "Route 11@", 1, 1, 1
    db 127, "Lavender Town@", 1, 1, 1
    db 128, "Pokémon Tower@", 1, 1, 1
    db 129, "Celedon City@", 1, 1, 1
    db 130, "Game Corner@", 1, 1, 1
    db 131, "Rocket Hideout@", 1, 1, 1
    db 132, "Bicycle@", 1, 1, 1
    db 133, "Evolution@", 1, 1, 1
    db 134, "Surfing Pikachu@", 2, 1, 1
    db 135, "Silph Co.@", 1, 1, 1
    db 136, "Surfing@", 1, 1, 1
    db 137, "Cinnabar Island@", 1, 1, 1
    db 138, "Cinnabar Mansion@", 1, 1, 1
    db 139, "Indigo Plateau@", 1, 1, 1
    db 140, "Hall of Fame@", 1, 1, 1
    db 141, "Credits@", 1, 1, 1
    db 142, "Spotted! Boy@", 1, 1, 1
    db 143, "Spotted! Girl@", 1, 1, 1
    db 144, "Spotted! Rocket@", 1, 1, 1
    db 145, "Vs. Wild@", 1, 1, 1
    db 146, "Vs. Trainer@", 1, 1, 1
    db 147, "Vs. Gym Leader@", 1, 1, 1
    db 148, "Vs. Champion@", 1, 1, 1
    db 149, "Victory! Wild@", 1, 1, 1
    db 150, "Victory! Trainer@", 1, 1, 1
    db 151, "Victory! Champion@", 1, 1, 1
    db 152, "Unused@", 1, 1, 1
    db 153, "Unused@", 2, 1, 1
    db 154, "Vs. Wild@", 6, 1, 2
    db 155, "Vs. Trainer@", 6, 1, 2
    db 156, "Route 206@", 6, 1, 2
    db 157, "PokéRadar@", 6, 1, 2
    db 158, "Cerulean City@", 7, 1, 2
    db 159, "Cinnabar Island@", 7, 1, 2
    db 160, "Route 24@", 7, 1, 2
    db 161, "Shop@", 7, 1, 2
    db 162, "Pokéathelon Finals@", 7, 1, 2
    db 163, "Vs. Johto Trainer   GS Kanto Style Remix@", 3, 1, 2
    db 164, "Vs. Naljo Wild@", 11, 3, 2
    db 165, "Vs. Naljo Gym Leader@", 11, 4, 2
    db 166, "Vs. Pallet Patrol@", 11, 5, 2
    db -1
	
Origin:
	db 01, "Pokémon Red@"
	db 02, "Pokémon Yellow@"
	db 03, "Pokémon Gold@"
	db 04, "Pokémon Crystal@"
	db 05, "Pokémon Emerald@"
	db 06, "Pokémon Platinum@"
	db 07, "Pokémon HeartGold@"
	db 08, "Pokémon Black@"
	db 09, "Pokémon Black 2@"
	db 10, "Pokémon X and Y@"
	db 11, "Pokémon Prism@"
	db -1
	
Artist:
	db 01, "Junichi Masuda@"
	db 02, "FroggestSpirit@"
	db 03, "LevusBevus@"
	db 04, "GRonnoc@"
	db 05, "Cat333Pokémon@"
	db -1
