; Game Boy hardware interrupts

SECTION "vblank",ROM0[$40]
	jp VBlank

SECTION "lcd",ROM0[$48]
	jp _LCD

SECTION "timer",ROM0[$50]
	jp Timer

SECTION "serial",ROM0[$58]
	jp Serial

SECTION "joypad",ROM0[$60]
	jp JoypadInt

SECTION "hack_LCD",ROM0[$70]
_LCD:
    push af
    ld a,[hMPState]
    and a
    jr nz, .mp
    ld a, [hLCDStatCustom]
    and a
    jr z, .done

; At this point it's assumed we're in WRAM bank 5!
    push bc
    ld a, [rLY]
    ld c, a
    ld b, LYOverrides >> 8
    ld a, [bc]
    ld b, a
    ld a, [hLCDStatCustom]
    ld c, a
    ld a, b
    ld [$ff00+c], a
    pop bc

.done
    pop af
    reti

.mp
    ld a, [rLY]
    cp 144 - 8
    jr nc, .donemp

    push hl

    ld l, a
    add $11
    ld [$fe00], a
    ld [$fe04], a
    ld [$fe08], a

    ld a, [hMPState]
    dec a
    add 2 + 8
    add l
    jr nc, .ok
    sub 144
.ok

    ld h, 0
    ld l, a
    add hl, hl
    add hl, hl

if 0 ; if wMPNotes % $100
    ld a, l
    add wMPNotes % $100
    ld l, a
    ld a, h
    adc wMPNotes / $100
    ld h, a
else
    ld a, h
    add wMPNotes / $100
    ld h, a
endc

    ld a, [hli]
    ld [$fe01], a
    ld a, [hli]
    ld [$fe05], a
    ld a, [hli]
    ld [$fe09], a
    pop hl

.donemp
    pop af
    reti
