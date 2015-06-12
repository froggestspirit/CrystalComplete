Music_Oreburgh:
	dbw $C0, Music_Oreburgh_Ch1
	dbw $01, Music_Oreburgh_Ch2
	dbw $02, Music_Oreburgh_Ch3
	dbw $03, Music_Oreburgh_Ch4

Music_Oreburgh_Ch1:
	tempo $D0
	volume $77
	dutycycle 0
	tone $0001
Music_Oreburgh_Ch1_loop:
	notetype $C, $B2
	octave 3
	note A#, 3
	note A#, 1
	note A_, 1
	note A#, 2
	note A#, 2
	octave 4
	note D_, 2
	note D_, 1
	note C#, 1
	note D_, 2
	note D_, 1
	note C_, 3
	note C_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 2
	octave 3
	note E_, 1
	note D_, 2
	note D_, 1
	note D_, 2
	note D_, 2
	note D#, 3
	note E_, 2
	note C_, 4
	note E_, 1
	note E_, 2
	note D_, 3
	note C_, 2
	note F_, 1
	note F_, 2
	octave 4
	note C_, 2
	note C_, 3
	octave 3
	note A#, 1
	note A#, 2
	note G#, 2
	note G#, 3
	intensity $B3
	octave 4
	note D_, 3
	note D_, 3
	note C_, 4
	intensity $B1
	octave 3
	note B_, 2
	note B_, 4
	intensity $B3
	octave 4
	note C_, 3
	note C_, 3
	octave 3
	note A#, 4
	intensity $B1
	note G#, 2
	note G#, 6
	intensity $B3
	octave 2
	note A_, 2
	octave 3
	note C_, 6
	note D#, 2
	note G_, 6
	octave 2
	note G_, 2
	note A#, 2
	octave 3
	note E_, 2
	octave 4
	note C_, 1
	note C_, 1
	octave 3
	note B_, 1
	note B_, 1
	note A#, 1
	note A#, 1
	note A_, 1
	note A_, 1
	note C_, 1
	note C_, 2
	note C_, 2
	note D_, 1
	note C_, 2
	note C_, 1
	note C_, 2
	note C_, 2
	note D_, 1
	note C_, 2
	note C_, 1
	note C_, 2
	note C_, 2
	note D_, 1
	note C_, 1
	note G_, 1
	note E_, 1
	note E_, 2
	note A#, 2
	note A#, 3
	note A_, 1
	note A_, 2
	note A_, 2
	note A_, 3
	note A_, 1
	note A_, 2
	note A_, 2
	note A_, 2
	note A_, 1
	note G_, 2
	note G_, 3
	note G_, 3
	note E_, 3
	note G_, 5
	intensity $B1
	note G_, 2
	note G_, 3
	note G_, 3
	note E_, 3
	note G_, 2
	note E_, 1
	intensity $B3
	note C_, 4
	intensity $B1
	note F_, 1
	note F_, 2
	note D#, 3
	note D#, 1
	note D#, 2
	intensity $B3
	note C_, 7
	intensity $B1
	octave 2
	note G_, 2
	note G_, 1
	note G_, 3
	octave 3
	note G_, 2
	note G_, 1
	note G_, 3
	note G_, 2
	loopchannel 0, Music_Oreburgh_Ch1_loop

Music_Oreburgh_Ch2:
	tone $0001
	dutycycle 1
Music_Oreburgh_Ch2_loop:
	notetype $C, $C5
	octave 4
	note C_, 3
	note G_, 3
	note D_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 3
	note G_, 3
	note C_, 2
	note D#, 2
	note D_, 2
	note C_, 1
	note D_, 3
	note C_, 3
	note G_, 3
	note D_, 2
	note E_, 2
	note G_, 2
	octave 5
	note D_, 2
	note C_, 2
	octave 4
	note A_, 3
	note G_, 3
	note C_, 2
	note D#, 2
	note D_, 2
	note C_, 1
	note G#, 3
	intensity $C3
	note G_, 3
	note G_, 3
	note F#, 4
	intensity $C1
	note F_, 2
	note F_, 4
	intensity $C3
	note E_, 3
	note E_, 3
	note E_, 4
	intensity $C1
	note F_, 2
	note F_, 4
	intensity $C3
	note G_, 3
	note G_, 3
	octave 5
	note C_, 4
	note D_, 3
	note C_, 3
	octave 4
	note A#, 2
	note A_, 2
	note G_, 1
	note C_, 2
	note D_, 1
	note E_, 1
	note E_, 1
	note D#, 1
	note D#, 1
	note D_, 1
	note D_, 1
	note C#, 1
	note C#, 1
	intensity $C5
	note C_, 3
	octave 3
	note A_, 3
	octave 4
	note C_, 2
	note D_, 1
	note D_, 1
	note C_, 2
	note D#, 1
	note C_, 3
	note E_, 3
	note D#, 3
	note E_, 2
	note A#, 1
	note A#, 1
	note A_, 2
	note G#, 1
	note A_, 3
	note E_, 3
	octave 3
	note A_, 3
	octave 4
	note C_, 2
	note D#, 2
	note C_, 2
	note D_, 1
	note C_, 3
	intensity $C2
	note C_, 2
	note C_, 2
	note D_, 1
	note C_, 3
	octave 3
	note G_, 1
	octave 4
	note C_, 1
	note D_, 1
	intensity $C3
	note C_, 5
	intensity $C2
	note E_, 2
	note E_, 2
	note D#, 1
	note E_, 3
	octave 3
	note G_, 1
	octave 4
	note E_, 1
	note F_, 1
	note E_, 2
	note C_, 1
	octave 3
	note G_, 2
	note A_, 2
	note A_, 1
	octave 4
	note C_, 1
	note D_, 1
	note C_, 3
	note D#, 1
	note C_, 1
	note D_, 1
	note C_, 2
	note C_, 1
	note E_, 1
	note F_, 1
	note G_, 2
	note G_, 2
	octave 3
	note G_, 4
	octave 4
	note G_, 1
	note G_, 2
	octave 3
	note G_, 2
	note G_, 1
	note G_, 2
	loopchannel 0, Music_Oreburgh_Ch2_loop

Music_Oreburgh_Ch3:
Music_Oreburgh_Ch3_loop:
	notetype $C, $12
	octave 2
	note C_, 1
	note C_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	note G_, 1
	note A#, 1
	note G_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	note G_, 1
	note A#, 1
	note A#, 1
	octave 3
	note D_, 1
	octave 2
	note A#, 1
	note F_, 1
	note F_, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	note C_, 1
	note E_, 1
	note C_, 1
	octave 1
	note A#, 1
	note A#, 1
	octave 2
	note D_, 1
	note D_, 1
	note F_, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note C_, 1
	note C_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	note G_, 1
	note A#, 1
	note G_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	note G_, 1
	note A#, 1
	note A#, 1
	octave 3
	note D_, 1
	octave 2
	note A#, 1
	note F_, 1
	note F_, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	note C_, 1
	note E_, 1
	note C_, 1
	octave 1
	note A#, 1
	note A#, 1
	octave 2
	note D_, 1
	note D_, 1
	note F_, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note D_, 1
	note __, 2
	note D_, 1
	note __, 2
	note D_, 1
	note __, 3
	note G_, 1
	note __, 1
	note G_, 1
	note __, 3
	note C_, 1
	note __, 2
	note C_, 1
	note __, 2
	note C_, 1
	note __, 3
	note C#, 1
	note __, 1
	note C#, 1
	note __, 4
	note D_, 1
	note __, 1
	note D_, 1
	note D_, 1
	note __, 3
	note G_, 1
	note __, 1
	note G_, 1
	note G_, 1
	note __, 5
	note C_, 1
	note __, 1
	note C_, 1
	note C_, 1
	note __, 4
	note G_, 1
	note __, 2
	note A#, 1
	note __, 3
	note F_, 1
	note F_, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	note C_, 1
	note D_, 1
	note C_, 1
	octave 2
	note F#, 1
	note F#, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	note C_, 1
	note D_, 1
	note C_, 1
	octave 2
	note G_, 1
	note G_, 1
	octave 3
	note C_, 1
	note C_, 1
	note E_, 1
	note E_, 1
	note G_, 1
	note E_, 1
	octave 2
	note A_, 1
	note A_, 1
	octave 3
	note C#, 1
	note C#, 1
	note G_, 1
	note G_, 1
	note A#, 1
	note G_, 1
	octave 2
	note D_, 1
	note D_, 1
	note F_, 1
	note F_, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	octave 2
	note A_, 1
	note F_, 1
	note F_, 1
	note A_, 1
	note A_, 1
	octave 3
	note C_, 1
	note C_, 1
	note D#, 1
	note C_, 1
	note __, 1
	octave 2
	note C_, 1
	note __, 2
	note C_, 1
	note C_, 1
	note __, 2
	note C_, 1
	note __, 1
	note C_, 1
	note C_, 1
	note __, 5
	note C_, 1
	note __, 2
	note C_, 1
	note C_, 1
	note __, 2
	note C_, 1
	note __, 1
	note C_, 1
	note C_, 1
	note __, 5
	note F_, 1
	note __, 2
	note F_, 1
	note F_, 1
	note __, 2
	note F_, 1
	note __, 1
	note F_, 1
	note F_, 1
	note __, 5
	note C_, 1
	note __, 2
	note C_, 1
	note C_, 1
	note __, 2
	note G_, 1
	note __, 1
	note G_, 1
	note G_, 1
	note __, 4
	loopchannel 0, Music_Oreburgh_Ch3_loop

Music_Oreburgh_Ch4:
	togglenoise 3
Music_Oreburgh_Ch4_loop:
	notetype $C
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note C_, 2
	note E_, 1
	note C_, 2
	note E_, 1
	note C_, 2
	note E_, 2
	note C_, 2
	note C_, 2
	note E_, 2
	note C_, 2
	note E_, 1
	note C_, 2
	note E_, 1
	note C_, 2
	note E_, 2
	note C_, 2
	note C_, 2
	note E_, 2
	note C_, 2
	note E_, 1
	note C_, 2
	note E_, 1
	note C_, 2
	note C_, 1
	note G#, 2
	note C_, 1
	note C_, 2
	note G#, 1
	note C_, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note C_, 2
	note C_, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note A#, 1
	note G#, 1
	note C_, 1
	note G#, 1
	note C_, 1
	note G#, 2
	note A#, 1
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	note A#, 2
	note C_, 2
	note A#, 1
	note C_, 3
	loopchannel 0, Music_Oreburgh_Ch4_loop
