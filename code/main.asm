;----------------------------------------------------------;
;	Main assembly file for Super Metroid Redux
; All of the assembly files get linked together and compiled here.
;----------------------------------------------------------;

;----------------------------------------------------------;
;			Rom info
;----------------------------------------------------------;
arch snes.cpu		; Set processor architecture (SNES)
lorom			; Switch to LoROM mapping mode

;----------------------------------------------------------;
;		Global compilation flags
;----------------------------------------------------------;
; This patch is only for Super Metroid (SNES) ROM
; Check title/header "Super Metroid" at 0x7FC0

!heavy = 0		; Heavy Physics
!demos = 0		; Original Demos on Title Screen
!dualsuit = 0		; Proper Power Suit for Samus
!redesigned = 0		; Redesigned Samus Suits
!splazma = 0		; Enable combining Spazer+Plasma 

;----------------------------------------------------------;

;----------------------------------------------------------;
;		Internal ROM Header
;----------------------------------------------------------;
org $808000

org $80FFC0	; 0x007FC0-0x007FFF
Internal_Rom_Header:
{
	db "Super Metroid        "
	db $30		; ROM layout / Map mode ($30 for FastROM)
	db $02		; Chipset: ROM+RAM+SRAM
	db $0C		; ROM size: 400000h bytes = 4 MiB
	db $03		; SRAM size: 2000h bytes = 8 KiB
	db $00		; Country code: Japan
	db $01		; Developer code: Nintendo
	db $00		; Version number
	
	; Checksums, not necessary since Asar regenerates them
	;dw $0720	; Checksum complement
	;dw $F8DF	; Checksum

	skip 4		; Skip the Checksum bytes from Header code
	
	; Native interrupt vectors
	dw $8573,$8573,$8573,$8573,$8573,$9583,$8573,$986A
	; Emulation interrupt vectors
	dw $8573,$8573,$8573,$8573,$8573,$8573,$841C,$8573
}

warnpc $818000

;----------------------------------------------------------;
;			Main Code
;----------------------------------------------------------;

incsrc "Animations/Animations.asm"
incsrc "Backflip/Backflip.asm"
incsrc "Blackout Speedups/Door Transition Speed.asm"
incsrc "Bugfixes/Fireflea_Xray.asm"
incsrc "Bugfixes/MissileStationEnhancer.asm"
incsrc "Bugfixes/PBRevealTiles.asm"
incsrc "Bugfixes/ReserveTank_Bugfixes_by_Nodever2.asm"
incsrc "Bugfixes/ScrewAttackFrozenEnemis.asm"
incsrc "Bugfixes/vanillabugfixes.asm"
incsrc "ControlFreakProjectBase/1-ControlFreak2-PB0.7.3.asm"
incsrc "ControlFreakProjectBase/2-ControlFreak2-PB0.7.3-UIUpdate.asm"
incsrc "ControlFreakProjectBase/3-projectcontrolfreakbase-PB0.7.3.asm"
incsrc "Custom Credits/Custom Credits.asm"
incsrc "Demos/Demos.asm"
incsrc "DCMapPatch/DCMapPatch.asm"
incsrc "Ending Suit Palette/Ending Suit Palette.asm"
incsrc "Ending Suit Palette Copy/Ending Suit Palette Copy.asm"
incsrc "Ending Time/XxYyZz END TIME.asm"
incsrc "Ending Totals/endingtotals.asm"
incsrc "EnemyChanges/Enemies.asm"
incsrc "Equipment Percentage Display/Equipment-Percentage-Display.asm"
incsrc "Equipment Screen Timer/Equipment-Screen-Timer.asm"
incsrc "Graphics/Graphics.asm"
incsrc "Hard Mode Compatibility Hack/no.asm"
incsrc "Hard Mode Compatibility Hack/spikes.asm"
incsrc "Instant Bomb Explosion/Instant Bomb Explosion.asm"
incsrc "IntroSkip/IntroSkip.asm"
incsrc "InstructionLists/InstructionLists.asm"
incsrc "ItemCircles/newitemcircles.asm"
incsrc "ItemSounds/itemsounds.asm"
incsrc "KraidFixes/kraid-pause-fix.asm"
incsrc "KraidFixes/postkraid-graphic-fix.asm"
incsrc "Maps/LevelData.asm"
incsrc "Maps/Tilemaps.asm"
incsrc "Menu Colored Samus/Menu Colored Samus.asm"
incsrc "MessageBoxes/Messages.asm"
incsrc "Morph Roll Animation/MorphRoll.asm"
incsrc "MSU-1/MSU1.asm"
incsrc "PLMs/PLMs.asm"
incsrc "Save Load Map/Save Load Map.asm"
incsrc "SaveLoad/saveload.asm"
incsrc "Skip Bomb Jump/Skip Bomb Jump.asm"
incsrc "Smooth Landing/Smooth Landing.asm"
incsrc "Spark Restart/Spark Restart.asm"
incsrc "Super Missile Fix/Super Missile Fix.asm"
incsrc "Super Missile Recoil/Super Missile Recoil.asm"
incsrc "TourianEvent/CutscenePLM.asm"
incsrc "Tractor Beam/TractorBeam.asm"
incsrc "misc.asm"

;----------------------------------------------------------;
;		Optional patches
; 	Uncomment the desired Optional patches
;----------------------------------------------------------;

; Implement optional patches
;incsrc "optional.asm"


