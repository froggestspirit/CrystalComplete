INCLUDE "includes.asm"

SECTION "restoremusic", ROMX

SaveMusic::
	; back up old music state
	ld bc, CurMusic-MusicPlaying
	ld hl, MusicPlaying
	ld de, $d000
	ld a, $4
	di
	ld [rSVBK], a
	call CopyBytes
	ld a, $1
	ld [rSVBK], a
	ei
	ret

RestoreMusic::
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	
	ld bc, CurMusic-MusicPlaying
	ld de, MusicPlaying
	ld hl, $d000
	ld a, $4
	di
	ld [rSVBK], a
	call CopyBytes
	ld a, $1
	ld [rSVBK], a
	ei
	
	pop af
	pop bc
	pop de
	pop hl
	ret
