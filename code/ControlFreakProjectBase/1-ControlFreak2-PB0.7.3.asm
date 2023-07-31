;Super Metroid Control Freak:
;Autorun unless Walk is held - DONE
;X-ray scope on a button (old item cancel) - DONE
;Aim down becomes seperate fire button - DONE
;will have a new hack allowing any buttons to anything - DONE
;Redo control menu tiles too - DONE

;Check charge beam to see if it works acceptably. - It's a bit abusable and ugly. Will fix failed-shot release palette, but leave in. - DONE
;Actually make the Special Settings options work. - DONE

;Intro movies need to be fixed. Demo movies too, maybe? - DONE

;Run routine will change branch on Run - DONE
;Change demos to Walk instead of Run - DONE
;Transitions will change to act as if Run were held - er. Actually no transitions check this. DONE
;X-Ray scope checks for Item Cancel - DONE

;Remove other cases of Item Cancel - DONE
;Select cycles, otherwise no movement - DONE
;Empty items selectable - DONE
;Aim down becomes toggle to selected - DONE

;Remove old Item Cancel checks - DONE

;Redo transition table for aim up/down - DONE. A few breaks but they're acceptable
;[22:04] <Kejardon> getting hit breaks aim-lock, that one makes sense though. It'd also be nigh-impossible to fix without an overarching aim-lock code though.
;Maybe fix spin/space jump aiming - DONE

;81B339 is part of new game initialization, probably leave alone.
;8BBC08 inits controls for new game demos, I guess. I think I should leave it alone. Next routine returns controls
;Noteworthy BITs: 90C4BF, 90C4CB, 91822B, 91826B, 918299
;91882D inits controls for title screen demos
;8180E1 loads controls
;82F241 restores defaults
;82F558 writes to controls after controls menu (uses 82F54A)
;82F4DC loads from controls for controls menu (uses 82F54A)

;UPDATE: 8/17/09
;Adding power-bomb-always when Brandish is pressed.

lorom
;Powerbomb checks Brandish instead of selected item. I would like this to take $12 bytes
org $90BFA0
	LDA $008B	;So I don't need a NOP
	BIT $09B2
	BEQ LayNothing
	BIT $09BC	;Check Brandish, not selected item
	BEQ LayBomb
	LDA $09CE	;Whoops... fix a nasty bug that was in the original CF I think
	BNE LayPB
;org $90BFB2
LayNothing:

org $90BFCA
LayBomb:

org $90C01C
LayPB:

;Stupid powerbomb bug fixes. NINTENDO WHY DO YOU MAKE SILLY CODE
org $90C04C
	LDA #$0003
org $90C099
	BRA PBCheck
org $90C0A1
PBCheck:


org $8BBC08
	LDA $09B2
	STA $0D82
	LDA $09B4
	STA $0D84
	LDA $09B6
	STA $0D86
	LDA $09B8
	STA $0D88
	LDA $09BA
	STA $0D8A
	LDA $09BC
	STA $0D8C
	LDA $09BE
	STA $0D8E
	LDA $09E4
	STA $0D90
	LDA #$0040
	STA $09B2
	LDA #$0080
	STA $09B4
	LDA #$8000
	STA $09B6
	LDA #$4000
	STA $09B8
	LDA #$2000
	STA $09BA
	LDA #$0020
	STA $09BC
	LDA #$0010
	STA $09BE
	STZ $09E4
	RTS
Restore:
	LDA $0D90
	STA $09E4
	LDA $0D82
	STA $09B2
	LDA $0D84
	STA $09B4
	LDA $0D86
	STA $09B6
	LDA $0D88
	STA $09B8
	LDA $0D8A
	STA $09BA
	LDA $0D8C
	STA $09BC
	LDA $0D8E
	STA $09BE
	RTS

org $8BB769
	JSR Restore

org $82F5CA
	RTS	;Show aim and brandish button graphics

;Old item cancel checks
org $91822E
	DB $80
org $91826E
	DB $80
org $91829C
	DB $80


org $90DDCA
	BIT $09B8	;Item Cancel is now X-Ray scope

org $91CAE3
	BIT $09B8	;Item Cancel is now X-Ray scope

org $888737
	BIT $09B8	;Item Cancel is now X-Ray scope

org $888759
	BIT $09B8	;Item Cancel is now X-Ray scope

org $8887B0
	BIT $09B8	;Item Cancel is now X-Ray scope

;org $90DD3D	;Handle currently selected item. I'll just do everything in the selection routine, so skipping this.
;	PHP
;	REP #$30
;	LDA $0D32
;	CMP #$C4F0
;	BEQ +
;	LDX #$0008
;	BRA ++
;+
;	LDA $0A78
;	BEQ +
;	LDX #$000A
;	BRA ++
;+
;	LDA $09D2
;	ASL A
;	TAX    
;++
;	JSR ($DD61, X)  ;  $85D61 IN ROM
;	PLP
;	RTS

org $90BF20
	PLP	;Skip one-shot and depleted cancel checks for missiles
	RTS

org $90C08C
	PLP	;Skip one-shot and depleted cancel checks for powerbombs
	RTS

org $809C55
	LDA $0A04	;Use new value instead of 09D2

org $809C6C
	LDA $0A04
	
org $90C4EC
	LDA $0A04	;Use new value instead of 09D2

org $9BC8B9
	RTS	;Skip one-shot for grapple

org $9BC9AE
	RTS	;Skip one-shot for grapple

org $9BCA59
	RTS	;Skip one-shot for grapple

org $9BCBEF
	RTS	;Skip one-shot for grapple

org $888A97
	PLP	;Skip one-shot for x-ray
	RTS

org $809C96
	BRA $12	;Skip graphic effect of one-shot

org $90AD70
	STZ $0A04
	JSR SelectionHack

org $90FB90 ;; moved to freespace, default value was $90F640
SelectionHack:
	LDA $8F
	PHA
	LDA $09BA
	STA $8F
	JSR $C4B5
	PLA
	STA $8F
	RTS

AutoRunCheck:
	AND $09B6
	PHX
	LDX $09E4
	BEQ +
	EOR $09B6
+
	PLX
	BIT $09B6	
	RTS

SuitPallete:
	JSL $91DEBA
	LDA $0DC2
	RTS	
	

org $90B98B
	JSR SuitPallete

org $90C4B5	;Select routine. Need to add all my features into this.
	PHP
	REP #$30
	LDA $09D2
	STA $12
	LDA $8F
	BIT $09BA
	BEQ +
	LDA $0A04
	INC
	CMP #$0005
	BNE ++
	LDA #$0001
++
-
	STA $0A04
	ASL
	TAX
	SEC
	JSR (SelectionTests-2,X)
	BCC +
	LDA $0A04
	INC
	BRA -
+
	LDA $8B
	BIT $09B8
	BEQ +
	LDA $09A2
	BPL +
	LDA #$0005
	STA $09D2
	PLP
	RTS
+
	STZ $09D2
	BIT $09BC
	BEQ +
	LDA $0A04
	STA $09D2
+
	LDA $09D2
	CMP $12
	BNE +
	LDA $0AAA
	INC A
	CMP #$0003
	BMI ++
	LDA #$0002
++
	STA $0AAA
	PLP
	RTS
+
	LDA #$0001
	STA $0AAA
	PLP
	RTS

SelectionTests:
	DW MissileST,SuperST,PBST,GrappleST,NoneST

MissileST:
	LDA $09C8
	BEQ +
	CLC
+
	RTS
SuperST:
	LDA $09CC
	BEQ +
	CLC
+
	RTS
PBST:
	LDA $09D0
	BEQ +
	CLC
+
	RTS
GrappleST:
	LDA $09A2
	BIT #$4000
	BEQ +
	CLC
+
	RTS
NoneST:
	STZ $0A04
	LDA $09C8
	BNE +
	LDA $09CC
	BNE +
	LDA $09D0
	BNE +
	LDA $09A2
	BIT #$4000
	BNE +
	CLC
+
	RTS

org $9181A9
	PHB
	PEA $B8B8
	PLB
	PLB
	LDA $8B
	BEQ +
	JSR KeySetup
	LDA $0A1C
	ASL A
	TAX
	LDY $A000, X
	LDA $0000, Y
	INC A
	BEQ ++
-
	DEC A
	BEQ +++
	AND $12
	BNE $07	;++++
+++
	LDA $0002, Y
	AND $14
	BEQ +++
;++++
	TYA
	CLC
	ADC #$0006
	TAY
	LDA $0000, Y
	INC A
	BNE -
+
	STZ $0A18
	JSL $9182D9  ;  $882D9 IN ROM
++
-
	CLC
	PLB
	RTS

+++
	LDA $0004, Y
	CMP $0A1C
	BEQ -
	STA $0A28
	STZ $0A56
	SEC
	PLB
	RTS

KeySetup:
	LDA $8F
	AND #$0F00
	STA $12
	LDA $8B
	AND #$0F00
	STA $14
	LDY $8F
	TYA
	BIT $09B2
	BEQ +
	LDA #$0040
	TSB $12
	TYA
+
	BIT $09B4
	BEQ +
	LDA #$0080
	TSB $12
	TYA
+
	BIT $09B6
	BEQ +
	LDA #$8000
	TSB $12
	TYA
+
	BIT $09B8
	BEQ +
	LDA #$4000
	TSB $12
	TYA
+
	BIT $09BE
	BEQ +
	LDA #$0010
	TSB $12
+
	LDA $12
	EOR #$FFFF
	STA $12
	LDY $8B
	TYA
	BIT $09B2
	BEQ +
	LDA #$0040
	TSB $14
	TYA
+
	BIT $09B4
	BEQ +
	LDA #$0080
	TSB $14
	TYA
+
	BIT $09B6
	BEQ +
	LDA #$8000
	TSB $14
	TYA
+
	BIT $09B8
	BEQ +
	LDA #$4000
	TSB $14
	TYA
+
	BIT $09BE
	BEQ +
	LDA #$0010
	TSB $14
+
	LDA $14
	EOR #$FFFF
	STA $14
	RTS

org $92DF30
	DW $1600
org $92DF34
	DW $1600
org $92DF38
	DW $1600
org $92DF44
	DW $1600
org $92DF48
	DW $1600
org $92DF4C
	DW $1600
org $92DF58
	DW $1700
org $92DF5C
	DW $1700
org $92DF60
	DW $1700
org $92DF6C
	DW $1700
org $92DF70
	DW $1700
org $92DF74
	DW $1700

org $91E8FE
	LDX $0A1C
	LDA.l FallTransitions,X
	AND #$00FF
	STA $0A28
	LDA #$0005
	STA $0A2E
	RTS

org $919EE2
FallTransitions:	;29, 2A, 31, 32, 33, 34, 7D, 7E
	;Adding 2B, 6D, 6F
	DB $29,$29,$2A,$2B,$2C,$6D,$6E,$6F,$70,$29,$2A,$29,$2A,$2B,$2C,$6D
	DB $6E,$6F,$70,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$31,$31,$32
	DB $33,$33,$33,$34,$33,$FF,$FF,$29,$2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$32,$34,$FF,$FF,$29,$2A,$29,$2A,$29,$2A,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$29,$2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$29,$2A,$29
	DB $2A,$FF,$FF,$29,$2A,$29,$2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$6D,$6E,$6F,$70,$6D,$6E,$6F,$70,$7D,$7E,$7D,$7E,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$2B,$2C,$FF,$FF,$29,$2A,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$29,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$29,$2A,$29,$2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$6D
	DB $6E,$6F,$70,$FF,$FF,$29,$2A,$29,$2A,$29,$2A,$FF,$FF,$FF,$FF,$FF
	DB $2B,$2C,$6D,$6E,$6F,$70,$29,$2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

org $9284CF
;Need to copy pattern from other running tilemaps(904F7 and 9050B) and apply to 97FF and 981A bases
;5798 5798 E39C B29D E39C 5798 5798 E39C B29D E39C
;7298 7298 FE9C CD9D FE9C 7298 7298 FE9C CD9D FE9C
DW $97FF,$97FF,RAimUpFrame2,RAimUpFrame3,RAimUpFrame2,$97FF,$97FF,RAimUpFrame2,RAimUpFrame3,RAimUpFrame2
DW $981A,$981A,LAimUpFrame2,LAimUpFrame3,LAimUpFrame2,$981A,$981A,LAimUpFrame2,LAimUpFrame3,LAimUpFrame2

;97FF
;0500
;F901 F9 0228
;F901 F1 0328
;FE01 E1 0428
;FE01 E9 0528
;F9C3 F1 0028

;Originally org $92EE10
org $92EDF4 ;; moved to freespace, default value was $92EDF4
RAimUpFrame2:
DB $05,$00
DB $F9,$01,$F7,$02,$28
DB $F9,$01,$EF,$03,$28
DB $FE,$01,$E0,$04,$28
DB $FE,$01,$E8,$05,$28
DB $F9,$C3,$F0,$00,$28

RAimUpFrame3:
DB $05,$00
DB $F9,$01,$F7,$02,$28
DB $F9,$01,$EF,$03,$28
DB $FE,$01,$DF,$04,$28
DB $FE,$01,$E7,$05,$28
DB $F9,$C3,$EF,$00,$28

;981A
;0500
;FF01 F9 0228
;FF01 F1 0328
;FA01 E1 0468
;F7C3 F1 0028
;FA01 E9 0568

LAimUpFrame2:
DB $05,$00
DB $FF,$01,$F7,$02,$28
DB $FF,$01,$EF,$03,$28
DB $FA,$01,$E0,$04,$68
DB $F7,$C3,$F0,$00,$28
DB $FA,$01,$E8,$05,$68

LAimUpFrame3:
DB $05,$00
DB $FF,$01,$F7,$02,$28
DB $FF,$01,$EF,$03,$28
DB $FA,$01,$DF,$04,$68
DB $F7,$C3,$EF,$00,$28
DB $FA,$01,$E7,$05,$68





;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $97FF
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A
;	DW $981A


org $9183DF
	JSR ToggleWalk

;Originally 919F90
org $91FFEE ; moved to freespace, default value was $91FFEE
ToggleWalk:
	LDA $0A86
	EOR #$0020
	STA $0A86
	LDA $0A84
	EOR #$0020
	RTS

org $8BAF44
	STA $0A04

org $908542
	JSR AutoRunCheck
	BNE $03
	
org $909781
	JSR AutoRunCheck
	BNE $03

org $B8A000 ; moved to freespace, default value was $B88000


; CONTROL FREAK

; START GAME

; ENGLISH TEXT
; JAPANESE TEXT (ASFLKJ)

; BUTTON CONFIGURATION

; SPECIAL SETTINGS


; BUTTON CONFIGURATION

; FIRE
; JUMP
; WALK/RUN
; SELECT ITEM
; X-RAY SCOPE
; AIM LOCK
; READY ITEM
; END
; RESTORE DEFAULTS


; SPECIAL SETTINGS

; ITEM RESET  DOOR   MANUAL
;(REVERTS TO MISSILES
; WHEN ENTERING DOORS)
; AUTO RUN     ON      OFF

; END

org $978DF4
incbin CMenu1.bin

org $978FCD
incbin CMenu2.bin

org $97938D
incbin CMenu3.bin


org $82F70F
FreeSpace:

org $82F480
	DW OptionsSprites

org $82F488
	DW OptionsSprites

org $82F490
	DW ControllerSprites

org $82F498
	DW ControllerSprites

;org $82F4A0
;	DW SpecialSprites

;org $82F4A8
;	DW SpecialSprites

org $82D24B
OptionsSprites:
DB $22,$00
DB $CC,$01,$08,$FA,$3E
DB $D4,$01,$08,$FA,$3E
DB $DC,$01,$08,$FA,$3E
DB $E4,$01,$08,$FA,$3E
DB $EC,$01,$08,$FA,$3E
DB $F4,$01,$08,$FA,$3E
DB $FC,$01,$08,$FA,$3E
DB $04,$00,$08,$FA,$3E
DB $0C,$00,$08,$FA,$3E
DB $14,$00,$08,$FA,$3E
DB $1C,$00,$08,$FA,$3E
DB $24,$00,$08,$FA,$3E
DB $2C,$00,$08,$FA,$3E

DB $34,$00,$08,$FD,$3E
DB $34,$00,$00,$ED,$3E
DB $34,$00,$F8,$ED,$3E
DB $34,$00,$F0,$FB,$3E

DB $2C,$00,$F0,$FA,$3E
DB $24,$00,$F0,$FA,$3E
DB $1C,$00,$F0,$FA,$3E
DB $14,$00,$F0,$FA,$3E
DB $0C,$00,$F0,$FA,$3E
DB $04,$00,$F0,$FA,$3E
DB $FC,$01,$F0,$FA,$3E
DB $F4,$01,$F0,$FA,$3E
DB $EC,$01,$F0,$FA,$3E
DB $E4,$01,$F0,$FA,$3E
DB $DC,$01,$F0,$FA,$3E
DB $D4,$01,$F0,$FA,$3E
DB $CC,$01,$F0,$FA,$3E

DB $C4,$01,$F0,$F9,$3E
DB $C4,$01,$F8,$ED,$3E
DB $C4,$01,$00,$ED,$3E
DB $C4,$01,$08,$FC,$3E

ControllerSprites:
;DB $30,$00
;DB $B4,$01,$08,$FA,$3E
;DB $BC,$01,$08,$FA,$3E
;DB $C4,$01,$08,$FA,$3E
;DB $CC,$01,$08,$FA,$3E
;DB $D4,$01,$08,$FA,$3E
;DB $DC,$01,$08,$FA,$3E
;DB $E4,$01,$08,$FA,$3E
;DB $EC,$01,$08,$FA,$3E
;DB $F4,$01,$08,$FA,$3E
;DB $FC,$01,$08,$FA,$3E
;DB $04,$00,$08,$FA,$3E
;DB $0C,$00,$08,$FA,$3E
;DB $14,$00,$08,$FA,$3E
;DB $1C,$00,$08,$FA,$3E
;DB $24,$00,$08,$FA,$3E
;DB $2C,$00,$08,$FA,$3E
;DB $34,$00,$08,$FA,$3E
;DB $3C,$00,$08,$FA,$3E
;DB $44,$00,$08,$FA,$3E
;DB $4C,$00,$08,$FA,$3E
;
;DB $54,$00,$08,$FD,$3E
;DB $54,$00,$00,$ED,$3E
;DB $54,$00,$F8,$ED,$3E
;DB $54,$00,$F0,$FB,$3E
;
;DB $4C,$00,$F0,$FA,$3E
;DB $44,$00,$F0,$FA,$3E
;DB $3C,$00,$F0,$FA,$3E
;DB $34,$00,$F0,$FA,$3E
;DB $2C,$00,$F0,$FA,$3E
;DB $24,$00,$F0,$FA,$3E
;DB $1C,$00,$F0,$FA,$3E
;DB $14,$00,$F0,$FA,$3E
;DB $0C,$00,$F0,$FA,$3E
;DB $04,$00,$F0,$FA,$3E
;DB $FC,$01,$F0,$FA,$3E
;DB $F4,$01,$F0,$FA,$3E
;DB $EC,$01,$F0,$FA,$3E
;DB $E4,$01,$F0,$FA,$3E
;DB $DC,$01,$F0,$FA,$3E
;DB $D4,$01,$F0,$FA,$3E
;DB $CC,$01,$F0,$FA,$3E
;DB $C4,$01,$F0,$FA,$3E
;DB $BC,$01,$F0,$FA,$3E
;DB $B4,$01,$F0,$FA,$3E
;
;DB $AC,$01,$F0,$F9,$3E
;DB $AC,$01,$F8,$ED,$3E
;DB $AC,$01,$00,$ED,$3E
;DB $AC,$01,$08,$FC,$3E

;org $82D41B
;SpecialSprites:
;DB $28,$00
;
;DB $C0,$01,$08,$FA,$3E
;DB $C8,$01,$08,$FA,$3E
;DB $D0,$01,$08,$FA,$3E
;DB $D8,$01,$08,$FA,$3E
;DB $E0,$01,$08,$FA,$3E
;DB $E8,$01,$08,$FA,$3E
;DB $F0,$01,$08,$FA,$3E
;DB $F8,$01,$08,$FA,$3E
;DB $00,$00,$08,$FA,$3E
;DB $08,$00,$08,$FA,$3E
;DB $10,$00,$08,$FA,$3E
;DB $18,$00,$08,$FA,$3E
;DB $20,$00,$08,$FA,$3E
;DB $28,$00,$08,$FA,$3E
;DB $30,$00,$08,$FA,$3E
;DB $38,$00,$08,$FA,$3E
;
;DB $40,$00,$08,$FD,$3E
;DB $40,$00,$00,$ED,$3E
;DB $40,$00,$F8,$ED,$3E
;DB $40,$00,$F0,$FB,$3E
;
;DB $38,$00,$F0,$FA,$3E
;DB $30,$00,$F0,$FA,$3E
;DB $28,$00,$F0,$FA,$3E
;DB $20,$00,$F0,$FA,$3E
;DB $18,$00,$F0,$FA,$3E
;DB $10,$00,$F0,$FA,$3E
;DB $08,$00,$F0,$FA,$3E
;DB $00,$00,$F0,$FA,$3E
;DB $F8,$01,$F0,$FA,$3E
;DB $F0,$01,$F0,$FA,$3E
;DB $E8,$01,$F0,$FA,$3E
;DB $E0,$01,$F0,$FA,$3E
;DB $D8,$01,$F0,$FA,$3E
;DB $D0,$01,$F0,$FA,$3E
;DB $C8,$01,$F0,$FA,$3E
;DB $C0,$01,$F0,$FA,$3E
;
;DB $B8,$01,$F0,$F9,$3E
;DB $B8,$01,$F8,$ED,$3E
;DB $B8,$01,$00,$ED,$3E
;DB $B8,$01,$08,$FC,$3E
