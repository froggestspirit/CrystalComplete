;Written by Sanqui
INCLUDE "includes.asm"

SECTION "Music_Player", ROMX, BANK[MUSIC_PLAYER]

NUMSONGS EQU 168

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
	jr z, .zerofix
    cp a, NUMSONGS
    jr c, .redraw
.zerofix
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
	ld a, " "
	hlcoord 5, 2
	ld bc, 95
	call ByteFill
	hlcoord 0, 8
	ld bc, 90
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
    ld a, [Channel1Pitch]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 0, 14
    call PlaceString
    ld a, [Channel1Octave]
    add $f6
    hlcoord 2, 14
    ld [hli], a
    
    ;hlcoord 0, 1
	;ld de, Channel1Tempo ;Maybe wait till we can get BPM
	;ld bc, $0103
	;call PrintNum
	
	
; CHANNEL 2
    ld a, [$c145]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 5, 14
    call PlaceString
    ld a, [$c146]
    add $f6
    hlcoord 7, 14
    ld [hli], a

; CHANNEL 3    
    ld a, [$c177]
    ld hl, NoteNames
    call GetNthString
    push hl
    pop de
    hlcoord 10, 14
    call PlaceString
    ld a, [$c178]
    add $f6
    hlcoord 12, 14
    ld [hli], a
    	
; CHANNEL 4
    ret

DrawSongInfo:
    ld a, [wSongSelection]
    ld b, a
	ld c, 0
    ld hl, SongInfo
.loop
	ld a, [hl]
    cp -1
    jr z, .noname
	inc c
    ld a, c
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
	call GetSongArtist2
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

GetSongArtist2:
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
	ld de, Additional
	hlcoord 0, 10
    call PlaceString
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
db "                    "
db "                    "
db "                    "
db "Ch1──Ch2──Wave─Noise"
db "    │    │    │     "
db "    │    │    │     "
db "    │    │    │     "
db "────────────────────"
MPTilemapEnd

Additional:
	db "Additional Credits:@"

BlankName:
	db " @"
SongInfo:
    db "Title Screen@", 3, 1, 0
    db "Route 1@", 3, 1, 0
    db "Route 3@", 3, 1, 0
    db "Route 11@", 3, 1, 0
    db "Magnet Train@", 3, 1, 0
    db "Vs. Kanto Gym Leader@", 3, 1, 0
    db "Vs. Kanto Trainer@", 3, 1, 0
    db "Vs. Kanto Wild@", 3, 1, 0
    db "Pokémon Center@", 3, 1, 0
    db "Spotted! Hiker@", 3, 1, 0
    db "Spotted! Girl 1@", 3, 1, 0
    db "Spotted! Boy 1@", 3, 1, 0
    db "Heal Pokémon@", 3, 1, 0
    db "Lavender Town@", 3, 1, 0
    db "Viridian Forest@", 3, 1, 0
    db "Kanto Cave@", 3, 1, 0
    db "Follow Me!@", 3, 1, 0
    db "Game Corner@", 3, 1, 0
    db "Bicycle@", 3, 1, 0
    db "Hall of Fame@", 3, 1, 0
    db "Viridian City@", 3, 1, 0
    db "Celedon City@", 3, 1, 0
    db "Victory! Trainer@", 3, 1, 0
    db "Victory! Wild@", 3, 1, 0
    db "Victory! Champion@", 3, 1, 0
    db "Mt. Moon@", 3, 1, 0
    db "Gym@", 3, 1, 0
    db "Pallet Town@", 3, 1, 0
    db "Oak's Lab@", 3, 1, 0
    db "Professor Oak@", 3, 1, 0
    db "Rival Appears@", 3, 1, 0
    db "Rival Departure@", 3, 1, 0
    db "Surfing@", 3, 1, 0
    db "Evolution@", 3, 1, 0
    db "National Park@", 3, 1, 0
    db "Credits@", 3, 1, 0
    db "Azalea Town@", 3, 1, 0
    db "Cherrygrove City@", 3, 1, 0
    db "Spotted! Kimono Girl@", 3, 1, 0
    db "Union Cave@", 3, 1, 0
    db "Vs. Johto Wild@", 3, 1, 0
    db "Vs. Johto Trainer@", 3, 1, 0
    db "Route 30@", 3, 1, 0
    db "Ecruteak City@", 3, 1, 0
    db "Violet City@", 3, 1, 0
    db "Vs. Johto Gym Leader@", 3, 1, 0
    db "Vs. Champion@", 3, 1, 0
    db "Vs. Rival@", 3, 1, 0
    db "Vs. Rocket Grunt@", 3, 1, 0
    db "Elm's Lab@", 3, 1, 0
    db "Dark Cave@", 3, 1, 0
    db "Route 29@", 3, 1, 0
    db "Route 34@", 3, 1, 0
    db "S.S. Aqua@", 3, 1, 0
    db "Spotted! Boy 2@", 3, 1, 0
    db "Spotted! Girl 2@", 3, 1, 0
    db "Spotted! Team Rocket@", 3, 1, 0
    db "Spotted! Suspicious@", 3, 1, 0
    db "Spotted! Sage@", 3, 1, 0
    db "New Bark Town@", 3, 1, 0
    db "Goldenrod City@", 3, 1, 0
    db "Vermilion City@", 3, 1, 0
    db "Pokémon Channel@", 3, 1, 0
    db "PokéFlute@", 3, 1, 0
    db "Tin Tower@", 3, 1, 0
    db "Sprout Tower@", 3, 1, 0
    db "Burned Tower@", 3, 1, 0
    db "Olivine Lighthouse@", 3, 1, 0
    db "Route 42@", 3, 1, 0
    db "Indigo Plateau@", 3, 1, 0
    db "Route 38@", 3, 1, 0
    db "Rocket Hideout@", 3, 1, 0
    db "Dragon's Den@", 3, 1, 0
    db "Vs. Johto Wild Night@", 3, 1, 0
    db "Unown Radio@", 3, 1, 0
    db "Captured Pokémon@", 3, 1, 0
    db "Route 26@", 3, 1, 0
    db "Mom@", 3, 1, 0
    db "Victory Road@", 3, 1, 0
    db "Pokémon Lullaby@", 3, 1, 0
    db "Pokémon March@", 3, 1, 0
    db "Opening 1@", 3, 1, 0
    db "Opening 2@", 3, 1, 0
    db "Load Game@", 3, 1, 0
    db "Ruins of Alph Inside@", 3, 1, 0
    db "Team Rocket@", 3, 1, 0
    db "Dancing Hall@", 3, 1, 0
    db "Bug Contest Ranking@", 3, 1, 0
    db "Bug Contest@", 3, 1, 0
    db "Rocket Radio@", 3, 1, 0
    db "GameBoy Printer@", 3, 1, 0
    db "Post Credits@", 3, 1, 0
    db "Clair@", 4, 1, 0
    db "Mobile Adapter Menu@", 4, 1, 0
    db "Mobile Adapter@", 4, 1, 0
    db "Buena's Password@", 4, 1, 0
    db "Eusine@", 4, 1, 0
    db "Opening@", 4, 1, 0
    db "Battle Tower@", 4, 1, 0
    db "Vs. Suicune@", 4, 1, 0
    db "Battle Tower Lobby@", 4, 1, 0
    db "Mobile Center@", 4, 1, 0
    db "Opening@",  1, 1, 0
    db "Opening@", 2, 1, 0
    db "Title Screen@",  1, 1, 0
    db "Introduction@",  1, 1, 0
    db "Pallet Town@",  1, 1, 0
    db "Professor Oak@",  1, 1, 0
    db "Oak's Lab@",  1, 1, 0
    db "Rival Appears@",  1, 1, 0
    db "Rival Departure@",  1, 1, 0
    db "Route 1@",  1, 1, 0
    db "Viridian City@",  1, 1, 0
    db "Pokémon Center@",  1, 1, 0
    db "Heal Pokémon@",  1, 1, 0
    db "Viridian Forest@",  1, 1, 0
    db "Follow Me!@",  1, 1, 0
    db "Gym@",  1, 1, 0
    db "Jigglypuff Sings@",  1, 1, 0
    db "Route 3@",  1, 1, 0
    db "Mt. Moon@",  1, 1, 0
    db "Jessie and James@", 2, 1, 0
    db "Cerulean City@",  1, 1, 0
    db "Vermilion City@",  1, 1, 0
    db "S.S. Anne@",  1, 1, 0
    db "Route 11@",  1, 1, 0
    db "Lavender Town@",  1, 1, 0
    db "Pokémon Tower@",  1, 1, 0
    db "Celedon City@",  1, 1, 0
    db "Game Corner@",  1, 1, 0
    db "Rocket Hideout@",  1, 1, 0
    db "Bicycle@",  1, 1, 0
    db "Evolution@",  1, 1, 0
    db "Surfing Pikachu@", 2, 1, 0
    db "Silph Co.@",  1, 1, 0
    db "Surfing@",  1, 1, 0
    db "Cinnabar Island@",  1, 1, 0
    db "Cinnabar Mansion@",  1, 1, 0
    db "Indigo Plateau@",  1, 1, 0
    db "Hall of Fame@",  1, 1, 0
    db "Credits@",  1, 1, 0
    db "Spotted! Boy@",  1, 1, 0
    db "Spotted! Girl@",  1, 1, 0
    db "Spotted! Rocket@",  1, 1, 0
    db "Vs. Wild@",  1, 1, 0
    db "Vs. Trainer@",  1, 1, 0
    db "Vs. Gym Leader@",  1, 1, 0
    db "Vs. Champion@",  1, 1, 0
    db "Victory! Wild@",  1, 1, 0
    db "Victory! Trainer@",  1, 1, 0
    db "Victory! Champion@",  1, 1, 0
    db "Unused@",  1, 1, 0
    db "Unused@", 2, 1, 0
    db "Vs. Wild@", 6, 1, 2
    db "Vs. Trainer@", 6, 1, 2
    db "Jubilife City@", 6, 1, 2
    db "Route 206@", 6, 1, 2
    db "PokéRadar@", 6, 1, 2
    db "Cerulean City@", 7, 1, 2
    db "Cinnabar Island@", 7, 1, 2
    db "Route 24@", 7, 1, 2
    db "Shop@", 7, 1, 2
    db "Pokéathelon Finals@", 7, 1, 2
    db "Vs. Johto Trainer   GS Kanto Style Remix@", 3, 1, 2
    db "Vs. Naljo Wild@", 11, 3, 2
    db "Vs. Naljo Gym Leader@", 11, 4, 2
    db "Vs. Pallet Patrol@", 11, 5, 2
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
