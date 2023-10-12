;----------------------------------------------------------;
;		Message Boxes
;----------------------------------------------------------;

;----------------------------------------------------------;
;	Include Font Table for Text
;----------------------------------------------------------;
incsrc "Text.tbl",ltr

;----------------------------------------------------------;
;		Macro for Save messages
;----------------------------------------------------------;
macro prompt(word0, word1)
	for i = 0..stringlength("<word0>")
		dw char("<word0>",!i)|<word1>
	endfor
endmacro

;----------------------------------------------------------;

; Large message box top/bottom border tilemap
; Clears out the message box borders
org $858000
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E

; Tile numbers for button letters
org $858426	; 0x028426
	dw $000E	; A
	dw $000E	; B
	dw $000E	; X
	dw $000E	; Y
	dw $000E	; Select
	dw $000E	; L
	dw $000E	; R
	dw $000E	; Blank

;----------------------------------------------------------;
;		Message tilemaps
;----------------------------------------------------------;

org $85877F	; 0x02877F
; Energy Tank
	fillword $000E : fill 20
	;dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	;dw $000E,$000E
	dw "ENERGY TANK"
	fillword $000E : fill 22

; Missile, $8587BF
	fillword $000E : fill 26
	dw "MISSILE"
	padword $000E : pad $85881F : dw $3049
	padword $000E : pad $85885F : dw $304A
	padword $000E : pad $8588BF

; Super Missile, $8588BF
	fillword $000E : fill 18
	dw "SUPER MISSILE"
	padword $000E : pad $85891B : dw $3034,$7034
	padword $000E : pad $85895B : dw $3035,$7035
	padword $000E : pad $8589BF

; Power Bomb, $8589BF
	fillword $000E : fill 22
	dw "POWER BOMB"
	padword $000E : pad $858A1D : dw $3036,$7036
	padword $000E : pad $858A5D : dw $3037,$7037
	padword $000E : pad $858ABF

; Grappling Beam, $858BBF
	fillword $000E : fill 18
	dw "GRAPPLING BEAM"
	padword $000E : pad $858B1D : dw $3038,$7038
	padword $000E : pad $858B5D : dw $3039,$7039
	padword $000E : pad $858BBF

; X-Ray Scope, $858CBF
	fillword $000E : fill 22
	dw "X-RAY SCOPE"
	padword $000E : pad $858C1D : dw $303A,$703A
	padword $000E : pad $858C5D : dw $303B,$703B
	padword $000E : pad $858CBF

; Varia Suit, $858DBF
	fillword $000E : fill 20
	dw "VARIA SUIT"
	padword $000E : pad $858D13
	dw "SPRING BALL"
	padword $000E : pad $858D55
	dw "MORPH BALL"
	padword $000E : pad $858D91
	dw "SCREW ATTACK"
	padword $000E : pad $858DD1
	dw "HI-JUMP BOOTS"
	padword $000E : pad $858E13
	dw "SPACE JUMP"
	padword $000E : pad $858E51
	dw "SPEED BOOSTER"
	padword $000E : pad $858F53
	dw "CHARGE BEAM"
	padword $000E : pad $858F95
	dw "ICE BEAM"
	padword $000E : pad $858FD5
	dw "WAVE BEAM"
	padword $000E : pad $859017
	dw "SPAZER BEAM"
	padword $000E : pad $859053
	dw "PLASMA BEAM"
	padword $000E : pad $85909B
	dw "BOMB"
	padword $000E : pad $85918F
	dw "MAP DATA ACCESS"
	padword $000E : pad $859215
	dw "COMPLETED."
	padword $000E : pad $85924F
	dw "ENERGY RECHARGE"
	padword $000E : pad $8592D5
	dw "COMPLETED."
	padword $000E : pad $85930F
	dw "WEAPONS RELOAD"
	padword $000E : pad $859393
	dw "COMPLETED."
	padword $000E : pad $8593CF
	dw "WOULD YOU LIKE"
	padword $000E : pad $85940F
	dw "TO SAVE?"
	padword $000E : pad $85948F
	; Commented out until Asar is updated to properly recognize TBL entries through macros instead of just detecting ASCII chars
	; dw "=>" : %prompt("YES", $1400)	; D8 3C C4 3C D2 3C
	dw "=>",'Y'|$1400,'E'|$1400,'S'|$1400
	padword $000E : pad $8594A5
	;%prompt("NO", $0400)		; CD 2C CE 2C
	dw 'N'|$0400,'O'|$0400
	padword $000E : pad $8594CF
	;%prompt("SAVE COMPLETED.", $1400)
	dw 'S'|$1400,'A'|$1400,'V'|$1400,'E'|$1400," ",'C'|$1400,'O'|$1400,'M'|$1400,'P'|$1400,'L'|$1400,'E'|$1400,'T'|$1400,'E'|$1400,'D'|$1400,'.'|$1400
	padword $000E : pad $859511
	dw "RESERVE TANK"
	padword $000E : pad $859551
	dw "GRAVITY SUIT"
	padword $000E : pad $85957F
	dw $0000	
	padword $000E : pad $859591
	;dw "=>" : %prompt("YES", $1400)	; Unused
	dw "=>",'Y'|$1400,'E'|$1400,'S'|$1400
	padword $000E : pad $8595A7
	;%prompt("NO", $0400)
	dw 'N'|$0400,'O'|$0400
	padword $000E : pad $8595D1
	;dw "=>" : %prompt("YES", $1400)
	dw "=>",'Y'|$1400,'E'|$1400,'S'|$1400
	padword $000E : pad $8595E7
	;%prompt("NO", $0400)
	dw 'N'|$0400,'O'|$0400
	padword $000E : pad $859615
	;%prompt("YES", $0400)
	dw 'Y'|$0400,'E'|$0400,'S'|$0400
	padword $000E : pad $859623
	;dw "=>" : %prompt("NO", $1400)
	dw "=>",'N'|$1400,'O'|$1400
	padword $000E : pad $859641

warnpc $859643	; 0x029643



