INCLUDE "includes.asm"


SECTION "Audio", ROMX, BANK[AUDIO]

INCLUDE "audio/engine.asm"

; What music plays when a trainer notices you
INCLUDE "audio/trainer_encounters.asm"

MusicMT:
INCLUDE "audio/music_pointers_music_test.asm"

Music:
INCLUDE "audio/music_pointers.asm"

Music2:
INCLUDE "audio/music_pointers2.asm"

INCLUDE "audio/music/nothing.asm"

Cries:
INCLUDE "audio/cry_pointers.asm"

SFX:
INCLUDE "audio/sfx_pointers.asm"



SECTION "Songs 1", ROMX, BANK[SONGS_1]

INCLUDE "audio/music/route36.asm"
INCLUDE "audio/music/rivalbattle.asm"
INCLUDE "audio/music/rocketbattle.asm"
INCLUDE "audio/music/elmslab.asm"
INCLUDE "audio/music/darkcave.asm"
INCLUDE "audio/music/johtogymbattle.asm"
INCLUDE "audio/music/championbattle.asm"
INCLUDE "audio/music/ssaqua.asm"
INCLUDE "audio/music/newbarktown.asm"
INCLUDE "audio/music/goldenrodcity.asm"
INCLUDE "audio/music/vermilioncity.asm"
INCLUDE "audio/music/titlescreen.asm"
INCLUDE "audio/music/ruinsofalphinterior.asm"
INCLUDE "audio/music/lookpokemaniac.asm"
INCLUDE "audio/music/trainervictory.asm"


SECTION "Songs 2", ROMX, BANK[SONGS_2]

INCLUDE "audio/music/route1.asm"
INCLUDE "audio/music/route3.asm"
INCLUDE "audio/music/route12.asm"
INCLUDE "audio/music/kantogymbattle.asm"
INCLUDE "audio/music/kantowildbattle.asm"
INCLUDE "audio/music/pokemoncenter.asm"
INCLUDE "audio/music/looklass.asm"
INCLUDE "audio/music/lookofficer.asm"
INCLUDE "audio/music/route2.asm"
INCLUDE "audio/music/mtmoon.asm"
INCLUDE "audio/music/showmearound.asm"
INCLUDE "audio/music/gamecorner.asm"
INCLUDE "audio/music/bicycle.asm"
INCLUDE "audio/music/looksage.asm"
INCLUDE "audio/music/pokemonchannel.asm"
INCLUDE "audio/music/lighthouse.asm"
INCLUDE "audio/music/lakeofrage.asm"
INCLUDE "audio/music/indigoplateau.asm"
INCLUDE "audio/music/route37.asm"
INCLUDE "audio/music/rockethideout.asm"
INCLUDE "audio/music/dragonsden.asm"
INCLUDE "audio/music/ruinsofalphradio.asm"
INCLUDE "audio/music/lookbeauty.asm"
INCLUDE "audio/music/route26.asm"
INCLUDE "audio/music/ecruteakcity.asm"
INCLUDE "audio/music/lakeofragerocketradio.asm"
INCLUDE "audio/music/magnettrain.asm"
INCLUDE "audio/music/lavendertown.asm"
INCLUDE "audio/music/dancinghall.asm"
INCLUDE "audio/music/contestresults.asm"
INCLUDE "audio/music/route30.asm"


SECTION "Songs 3", ROMX, BANK[SONGS_3]

INCLUDE "audio/music/violetcity.asm"
INCLUDE "audio/music/route29.asm"
INCLUDE "audio/music/halloffame.asm"
INCLUDE "audio/music/healpokemon.asm"
INCLUDE "audio/music/evolution.asm"
INCLUDE "audio/music/printer.asm"


SECTION "Songs 4", ROMX, BANK[SONGS_4]

INCLUDE "audio/music/viridiancity.asm"
INCLUDE "audio/music/celadoncity.asm"
INCLUDE "audio/music/wildpokemonvictory.asm"
INCLUDE "audio/music/successfulcapture.asm"
INCLUDE "audio/music/gymleadervictory.asm"
INCLUDE "audio/music/mtmoonsquare.asm"
INCLUDE "audio/music/gym.asm"
INCLUDE "audio/music/pallettown.asm"
INCLUDE "audio/music/profoakspokemontalk.asm"
INCLUDE "audio/music/profoak.asm"
INCLUDE "audio/music/lookrival.asm"
INCLUDE "audio/music/aftertherivalfight.asm"
INCLUDE "audio/music/surf.asm"
INCLUDE "audio/music/nationalpark.asm"
INCLUDE "audio/music/azaleatown.asm"
INCLUDE "audio/music/cherrygrovecity.asm"
INCLUDE "audio/music/unioncave.asm"
INCLUDE "audio/music/johtowildbattle.asm"
INCLUDE "audio/music/johtowildbattlenight.asm"
INCLUDE "audio/music/johtotrainerbattle.asm"
INCLUDE "audio/music/lookyoungster.asm"
INCLUDE "audio/music/tintower.asm"
INCLUDE "audio/music/sprouttower.asm"
INCLUDE "audio/music/burnedtower.asm"
INCLUDE "audio/music/mom.asm"
INCLUDE "audio/music/victoryroad.asm"
INCLUDE "audio/music/pokemonlullaby.asm"
INCLUDE "audio/music/pokemonmarch.asm"
INCLUDE "audio/music/goldsilveropening.asm"
INCLUDE "audio/music/goldsilveropening2.asm"
INCLUDE "audio/music/lookhiker.asm"
INCLUDE "audio/music/lookrocket.asm"
INCLUDE "audio/music/rockettheme.asm"
INCLUDE "audio/music/mainmenu.asm"
INCLUDE "audio/music/lookkimonogirl.asm"
INCLUDE "audio/music/pokeflutechannel.asm"
INCLUDE "audio/music/bugcatchingcontest.asm"


SECTION "Songs 5", ROMX, BANK[SONGS_5]

INCLUDE "audio/music/mobileadaptermenu.asm"
INCLUDE "audio/music/buenaspassword.asm"
INCLUDE "audio/music/lookmysticalman.asm"
INCLUDE "audio/music/crystalopening.asm"
INCLUDE "audio/music/battletowertheme.asm"
INCLUDE "audio/music/suicunebattle.asm"
INCLUDE "audio/music/battletowerlobby.asm"
INCLUDE "audio/music/mobilecenter.asm"
INCLUDE "audio/music/kantotrainerbattle.asm"


SECTION "Extra Songs 1", ROMX, BANK[EXTRA_SONGS_1]

INCLUDE "audio/music/credits.asm"
INCLUDE "audio/music/clair.asm"
INCLUDE "audio/music/mobileadapter.asm"

SECTION "Extra Songs 2", ROMX, BANK[EXTRA_SONGS_2]

INCLUDE "audio/music/postcredits.asm"


SECTION "RBY Songs 1", ROMX, BANK[RBY_SONGS_1]

INCLUDE "audio/music/RBY/bikeriding.asm"
INCLUDE "audio/music/RBY/dungeon1.asm"
INCLUDE "audio/music/RBY/gamecorner.asm"
INCLUDE "audio/music/RBY/titlescreen.asm"
INCLUDE "audio/music/RBY/dungeon2.asm"
INCLUDE "audio/music/RBY/dungeon3.asm"
INCLUDE "audio/music/RBY/cinnabarmansion.asm"
INCLUDE "audio/music/RBY/oakslab.asm"
INCLUDE "audio/music/RBY/pokemontower.asm"
INCLUDE "audio/music/RBY/silphco.asm"
INCLUDE "audio/music/RBY/meeteviltrainer.asm"
INCLUDE "audio/music/RBY/meetfemaletrainer.asm"
INCLUDE "audio/music/RBY/meetmaletrainer.asm"
INCLUDE "audio/music/RBY/introbattle.asm"
INCLUDE "audio/music/RBY/surfing.asm"
INCLUDE "audio/music/RBY/jigglypuffsong.asm"
INCLUDE "audio/music/RBY/halloffame.asm"
INCLUDE "audio/music/RBY/credits.asm"
INCLUDE "audio/music/RBY/gymleaderbattle.asm"
INCLUDE "audio/music/RBY/trainerbattle.asm"
INCLUDE "audio/music/RBY/wildbattle.asm"
INCLUDE "audio/music/RBY/finalbattle.asm"

SECTION "RBY Songs 2", ROMX, BANK[RBY_SONGS_2]

INCLUDE "audio/music/RBY/defeatedtrainer.asm"
INCLUDE "audio/music/RBY/defeatedwildmon.asm"
INCLUDE "audio/music/RBY/defeatedgymleader.asm"
INCLUDE "audio/music/RBY/pkmnhealed.asm"
INCLUDE "audio/music/RBY/routes1.asm"
INCLUDE "audio/music/RBY/routes2.asm"
INCLUDE "audio/music/RBY/routes3.asm"
INCLUDE "audio/music/RBY/routes4.asm"
INCLUDE "audio/music/RBY/indigoplateau.asm"
INCLUDE "audio/music/RBY/pallettown.asm"
INCLUDE "audio/music/RBY/unusedsong.asm"
INCLUDE "audio/music/RBY/cities1.asm"
INCLUDE "audio/music/RBY/museumguy.asm"
INCLUDE "audio/music/RBY/meetprofoak.asm"
INCLUDE "audio/music/RBY/meetrival.asm"
INCLUDE "audio/music/RBY/ssanne.asm"
INCLUDE "audio/music/RBY/cities2.asm"
INCLUDE "audio/music/RBY/celadon.asm"
INCLUDE "audio/music/RBY/cinnabar.asm"
INCLUDE "audio/music/RBY/vermilion.asm"
INCLUDE "audio/music/RBY/lavender.asm"
INCLUDE "audio/music/RBY/safarizone.asm"
INCLUDE "audio/music/RBY/gym.asm"
INCLUDE "audio/music/RBY/pokecenter.asm"
INCLUDE "audio/music/RBY/yellowintro.asm"
INCLUDE "audio/music/RBY/surfingpikachu.asm"
INCLUDE "audio/music/RBY/meetjessiejames.asm"
INCLUDE "audio/music/RBY/yellowunusedsong.asm"

SECTION "Custom Songs 1", ROMX, BANK[CUSTOM_SONGS_1]

INCLUDE "audio/music/custom/johtoGSC.asm"
INCLUDE "audio/music/custom/ceruleanGSC.asm"
INCLUDE "audio/music/custom/cinnabarGSC.asm"
INCLUDE "audio/music/custom/nuggetbridge.asm"
INCLUDE "audio/music/custom/shop.asm"
INCLUDE "audio/music/custom/pokeathelonfinal.asm"

SECTION "Custom Songs 2", ROMX, BANK[CUSTOM_SONGS_2]

INCLUDE "audio/music/custom/naljowildbattle.asm"
INCLUDE "audio/music/custom/naljogymbattle.asm"
INCLUDE "audio/music/custom/palletbattle.asm"
INCLUDE "audio/music/custom/cinnabarremix.asm"
INCLUDE "audio/music/custom/kantogymleaderremix.asm"

SECTION "DPPt Songs 1", ROMX, BANK[DPPT_SONGS_1]

INCLUDE "audio/music/DPPt/pokeradar.asm"
INCLUDE "audio/music/DPPt/sinnohtrainer.asm"
INCLUDE "audio/music/DPPt/sinnohwild.asm"
INCLUDE "audio/music/DPPt/route206.asm"
INCLUDE "audio/music/DPPt/jubilifecity.asm"

SECTION "TCG Songs 1", ROMX, BANK[TCG_SONGS_1]
INCLUDE "audio/music/TCG/titlescreen.asm"
INCLUDE "audio/music/TCG/battletheme1.asm"
INCLUDE "audio/music/TCG/battletheme2.asm"
INCLUDE "audio/music/TCG/battletheme3.asm"
INCLUDE "audio/music/TCG/pausemenu.asm"
INCLUDE "audio/music/TCG/pcmainmenu.asm"
INCLUDE "audio/music/TCG/deckmachine.asm"
INCLUDE "audio/music/TCG/cardpop.asm"
INCLUDE "audio/music/TCG/overworld.asm"
INCLUDE "audio/music/TCG/pokemondome.asm"
INCLUDE "audio/music/TCG/challengehall.asm"
INCLUDE "audio/music/TCG/club1.asm"
INCLUDE "audio/music/TCG/club2.asm"
INCLUDE "audio/music/TCG/club3.asm"

SECTION "TCG Songs 2", ROMX, BANK[TCG_SONGS_2]
INCLUDE "audio/music/TCG/ronald.asm"
INCLUDE "audio/music/TCG/imakuni.asm"
INCLUDE "audio/music/TCG/hallofhonor.asm"
INCLUDE "audio/music/TCG/credits.asm"
INCLUDE "audio/music/TCG/matchstart1.asm"
INCLUDE "audio/music/TCG/matchstart2.asm"
INCLUDE "audio/music/TCG/matchstart3.asm"
INCLUDE "audio/music/TCG/matchvictory.asm"
INCLUDE "audio/music/TCG/matchloss.asm"
INCLUDE "audio/music/TCG/darkdiddly.asm"
INCLUDE "audio/music/TCG/boosterpack.asm"
INCLUDE "audio/music/TCG/medal.asm"

SECTION "Sound Effects", ROMX, BANK[SOUND_EFFECTS]

INCLUDE "audio/sfx.asm"


SECTION "Crystal Sound Effects", ROMX, BANK[CRYSTAL_SOUND_EFFECTS]

INCLUDE "audio/sfx_crystal.asm"



SECTION "Cries", ROMX, BANK[CRIES]

CryHeaders:: INCLUDE "audio/cry_headers.asm"

INCLUDE "audio/cries.asm"


