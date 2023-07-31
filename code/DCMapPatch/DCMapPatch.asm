; DC's Map Patch disassembly by ShadowOne333
; Original patch by DC from Metroid Construction
;----------------------------------------
LOROM
;----------------------------------------
org $809632	; 0x001632
	; EB E2 20 B8
	XBA
	SEP #$20
	CLV

org $809661	; 0x001661
	; 9C BD 05 70 07
	STZ $05BD
	BVS $07

org $80978E	; 0x00178E
	; AD BC 05
	LDA $05BC

org $80980A	; 0x00180A
	; AD BC 05
	LDA $05BC

org $809DBF	; 0x001DBF, HUD Digits tilemap
	; 2C00, 2C01, 2C02...
health:
	dw $2C00,$2C01,$2C02,$2C03
	dw $2C04,$2C05,$2C06,$2C07
	dw $2C08,$2C09
artillery:
	dw $2C00,$2C01,$2C02,$2C03
	dw $2C04,$2C05,$2C06,$2C07
	dw $2C08,$2C09
;----------------------------------------
org $80A0ED	; 0x0020ED, Start gameplay
	; 20 ED A2
	JSR $A2ED

org $80A214	; 0x002213, Queue clearing of layer 3
	; A9 0F 18
	LDA #$180F
;----------------------------------------
org $80A29D	; 0x00229D
	LDX #$0002	; A2 02
branch0:
	REP #$20	; C2 20
	LDA #$5880	; A9 80 58
	STA $2116	; 8D 16 21
	LDA $A2D3,X	; BD D3 A2
	STA $4310	; 8D 10 43
	LDA $A2D7,X	; BD D7 A2
branch1:
	STA $4312	; 8D 12 43
	LDA #$0080	; A9 80 00
	STA $4314	; 8D 14 43
	LDA #$0780	; A9 80 07
	STA $4315	; 8D 15 43
	SEP #$20	; E2 20
	LDA $A2DB,X	; BD DB A2
	STA $2115	; 8D 15 21
	LDA #$02	; A9 02
	STA $420B	; 8D 0B 42
	DEX		; CA
	DEX		; CA
	BPL branch0	; 10 CF
	PLP		; 28
	RTL		; 6B

	PHP		; 08
	ORA $1808,Y	; 19 08 18
	CPX #$A2	; E0 A2
	CMP $0080A2,X	; DF A2 80 00

Table:
	db $00,$00,$0F,$18
	db $FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF
	db $FF,$FF,$FF,$FF

	PHP		; 08
	LDX $05BC	; AE BC 05
	BPL branch2	; 10 05
	SEP #$60	; E2 60 
	JSR $9639	; 20 39 96
branch2:
	PLP		; 28
;----------------------------------------
org $818E35	; 0x008E35, Map data
	db $E0,$B8

;org $81A7AE	; 0x00A7AE
;	LDA #$000E	; A9 0F 28

org $81B14B	; 0x00B14B, Tilemap
	dw $2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2839,$283A,$28CC,$28C0,$28CF,$2801,$2801
	dw $2801,$2801,$2801,$2836,$6836,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2837,$2838,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2849,$284A,$28D2,$28C2,$28D1,$28CE,$28CB
	dw $28CB,$2801,$2801,$2846,$6846,$28D2,$28D3,$28C0
	dw $28D1,$28D3,$2801,$2801,$2847,$2848,$28C2,$28C0
	dw $28CD,$28C2,$28C4,$28CB,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
	dw $2801,$2801,$2801,$2801,$2801,$2801,$2801,$2801
;----------------------------------------
; Related to BG3 and BG2 loading during pause
; These two changes cause the pause graphical glitch during Kraid's fight
;org $828EBD	; 0x010EBD
;	LDA #$48	; Originally LDA #$40

;org $828ECF	; 0x010ECF
;	dl $9AC200	; Originally $9AB200
;	dw $1000	; Originally $2000

;----------------------------------------
; Numbers for tile IDs used for the Reserve Tanks
;org $828FB6	; 0x010FB6
;	ADC #$0800	; 69 00 08
;org $828FC1	; 0x010FC1
;	ADC #$0800	; 69 00 08
;org $828FCB	; 0x010FCB
;	ADC #$0800	; 69 00 08

;org $829580	; 0x011580
;	LDA #$000E

;----------------------------------------
org $82966F	; 0x01166F, Pointer to area maps (Crateria tilemap?)
	dw $2801,$2801,$38C2,$38D1,$38C0,$38D3,$38C4,$38D1
	dw $38C8,$28C0,$2801,$2801,$2801,$2801,$38C1,$38D1
	dw $38C8,$38CD,$38D2,$38D3,$38C0,$38D1,$2801,$2801
	dw $2801,$2801,$38CD,$38CE,$38D1,$38C5,$38C0,$38C8
	dw $38D1,$2801,$2801,$2801,$38D6,$38D1,$38C4,$38C2
	dw $38CA,$38C4,$38C3,$2801,$38D2,$38C7,$38C8,$38CF
	dw $2801,$2801,$38CC,$38C0,$38D1,$38C8,$38C3,$38C8
	dw $38C0,$2801,$2801,$2801,$2801,$2801,$38D3,$38CE
	dw $38D4,$38D1,$38C8,$38C0,$38CD,$2801,$2801,$2801
	dw $2801,$2801,$2801,$38C2,$38CE,$38CB,$38CE,$38CD
	dw $38D8,$2801,$2801,$2801

;----------------------------------------
;;; Equipment screen - Display reserve tank amount (Goes alongside the previous Numbers tile IDs code) ;;;
;org $82B3BB	; 0x0133BB
;	ADC #$0800	; 69 00 08
;org $82B3C6	; 0x0133C6
;	ADC #$0800	; 69 00 08
;org $82B3D0	; 0x0133D0
;	ADC #$0800	; 69 00 08


;----------------------------------------
;;; Equipment Screen Data Tilemaps ;;;
org $82BF14	; 0x013F14,Reserve Tanks
	dw $3EC8,$3EC9,$3ECA,$3ECB,$3ECC,$3ECD,$3ECE

org $82BF32	; 0x013F32
	dw $0AFF,$0AD8,$0AD9,$0ADA,$0AE7	; Charge Beam
	dw $0AFF,$0ADB,$0ADC,$0AD4,$0AD4	; Ice Beam
	dw $0AFF,$0ADD,$0ADE,$0ADF,$0AD4	; Wave Beam
	dw $0AFF,$0AE8,$0AE9,$0AEA,$0AEB	; Spazer Beam
	dw $0AFF,$0AEC,$0AED,$0AEE,$0AEF	; Plasma Beam
	; Varia Suit
	dw $0AFF,$0900,$0901,$0902,$0903,$0904,$0905,$0AD4,$0AD4
	; Gravity Suit
	dw $0AFF,$0AD0,$0AD1,$0AD2,$0AD3,$0903,$0904,$0905,$0AD4
	; Morphing Ball
	dw $0AFF,$0920,$0921,$0922,$0923,$0917,$0918,$090F,$091F
	; Bombs
	dw $0AFF,$0AD5,$0AD6,$0AD7,$0AD4,$0AD4,$0AD4,$0AD4,$0AD4
	; Spring Ball
	dw $0AFF,$0910,$0911,$0912,$0913,$0914,$0915,$0916,$0AD4
	; 0x013FBE
	dw $0000
	; Screw Attack (0x013FC0)
	dw $0AFF,$0AE0,$0AE1,$0AE2,$0AE3,$0AE4,$0AE5,$0AE6,$0AD4
	; Hi-Jump Boots
	dw $0AFF,$0930,$0931,$0932,$0933,$0934,$0935,$0936,$0AD4
	; Space Jump
	dw $0AFF,$0AF0,$0AF1,$0AF2,$0AF3,$0AF4,$0AF5,$0AD4,$0AD4
	; Speed Booster
	dw $0AFF,$0924,$0925,$0926,$0927,$0928,$0929,$092A,$092B
	; Hyper
	dw $0AFF,$0937,$0938,$0939,$092F,$0AD4,$0AD4,$0AD4,$0AD4
	; Empty?
;	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E


;----------------------------------------
;;; Samus Wireframe Tilemaps ;;;

; Power Suit
org $82D521	; 0x015521
	dw $001F,$001F,$001F,$25B3
	dw $65B3,$001F,$001F,$001F
org $82D555	; 0x015555
	dw $25DE	; $25DE (Why do I have this as $25EC?)
org $82D5B1	; 0x0155B1
	dw $001F
org $82D5BD	; 0x0155BD
	dw $001F,$001F,$001F,$001F
org $82D5CD	; 0x0155CD
	dw $001F,$001F,$001F,$001F
org $82D5DD	; 0x0155DD
	dw $001F,$001F,$001F,$001F
org $82D5ED	; 0x0155ED
	dw $001F,$001F,$001F,$001F
org $82D5FD	; 0x0155FD
	dw $001F,$001F,$001F,$001F
	dw $258F,$001F,$001F,$658F,$001F
org $82D617	; 0x015617
	dw $001F,$001F
org $82D627	; 0x015627
	dw $001F,$001F

; Hi-Jump Boots
org $82D631	; 0x015631
	dw $001F,$001F,$001F,$25B3
	dw $65B3,$001F,$001F,$001F
org $82D665	; 0x015665
	dw $25DE	; $25DE (Why do I have this as $25EC?)
org $82D6C1	; 0x0156C1
	dw $001F
org $82D6CD	; 0x0156CD
	dw $001F,$001F,$001F,$001F
org $82D6DD	; 0x0156DD
	dw $001F,$001F,$001F,$001F
org $82D6ED	; 0x0156ED
	dw $001F,$001F,$001F,$001F
org $82D6FD	; 0x0156FD
	dw $001F,$001F,$001F,$0579,$258C
	dw $05D7,$45D7,$658C,$4579,$001F
	dw $001F,$0589,$258A,$001F,$001F	; $001F,$001F,$001F
org $82D731	; 0x015731
	dw $25AD,$25AE,$25AF,$001F,$001F,$65AF,$25FE,$65AD

; Varia Suit
	dw $001F,$001F,$001F,$25B3,$65B3,$001F,$001F,$001F
org $82D7D1	; 0x0157D1
	dw $001F
org $82D7DD	; 0x0157DD
	dw $001F,$001F,$001F,$001F
org $82D7ED	; 0x0157ED
	dw $001F,$001F,$001F
org $82D7FF	; 0x0157FF
	dw $001F,$001F
org $82D80F	; 0x01580F
	dw $001F,$001F,$001F,$257B,$058D,$458D,$657B,$001F
	dw $001F,$001F,$001F,$258B,$001F,$001F,$658B,$001F
org $82D837	; 0x015837
	dw $001F,$001F
org $82D847	; 0x015847
	dw $001F,$001F,$65AF,$25FE,$65AD

; Varia + Boots
	dw $001F,$001F,$001F
	dw $25B3,$65B3,$001F,$001F,$001F
org $82D8E1	; 0x0158E1
	dw $001F
org $82D8ED	; 0x0158ED
	dw $001F,$001F,$001F,$001F
org $82D8FD	; 0x0158FD
	dw $001F,$001F,$001F
org $82D90F	; 0x01590F
	dw $001F,$001F
org $82D91F	; 0x01591F
	dw $001F,$001F,$2579,$257A,$058D,$458D,$657A,$6579
	dw $001F,$001F,$2589,$258A,$001F,$001F
org $82D951	; 0x015951
	dw $25AD,$25AE,$25AF,$001F,$001F,$65AF,$25FE,$65AD

;----------------------------------------
;;; BG Data ;;;
org $82E569	; 0x016569, Clear layer 3
	LDA #$180F	; A9 0F 18

;----------------------------------------
;;; Message Boxes ;;;

; Top/Bottom of Large Message Box Tilemap
;org $858006	; 0x028006
;	dw $000E,$000E,$000E,$000E,$000E,$000E
;org $858036	; 0x028036
;	dw $000E,$000E
;
;; Top/Bottom of Small Message Box Tilemap
;org $85804C	; 0x02804C
;	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
;	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
;	dw $000E,$000E,$000E

;----------------------------------------
;;; Message box routine ;;;
;org $858090	; 0x028090
;	JSR $9678	; Clear message box BG3 tilemap
;org $8580AA	; 0x0280AA
;	JSR $9650	; Clear message box BG3 tilemap
;org $8580E8	; 0x0280E8, BRANCH_GUNSHIP
;	JSR $9650	; Clear message box BG3 tilemap

; Tile numbers for button letters
;org $858426	; 0x028426
;	dw $28C0	; A Button
;	dw $3CC1	; B Button
;	dw $2CD7	; X Button
;	dw $38D8	; Y Button
;	dw $38BF	; Select Button
;	dw $38CB	; L Button
;	dw $38D1	; R Button
;	dw $000E	; Blank

;----------------------------------------
;;; Messages tilemaps ;;;
org $85878B	; 0x02878B, Energy Tank
	dw $000E,$000E,$000E,$000E
	dw $28C4,$28CD,$28C4,$28D1,$28C6,$28D8	; ENERGY
	dw $000E
	dw $28D3,$28C0,$28CD,$28CA	; TANK
	dw $000E,$000E,$000E,$000E

org $8587C5	; 0x0287C5, Missile
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E,$280E
	dw $28CC,$28C8,$28D2,$28D2,$28C8,$28CB,$28C4	; MISSILE
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
org $858805	; 0x028805
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858845	; 0x028845
	dw $000E,$000E,$000E,$000E,$000E,$000E
org $858857	; 0x028857
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E
org $858885	; 0x028885
	dw $000E,$000E
	dw $28E9,$28EA,$28EB	; ???
	dw $000E
org $858897	; 0x028897
	dw $000E
	dw $28F9	; ???
	dw $000E
	dw $28E0,$28E1,$28E2,$28F0,$28F1,$28F2,$28C0,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E,$000E

org $8588C5	; 0x0288C5, Super Missile
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $28D2,$28D4,$28CF,$28C4,$28D1	; SUPER
	dw $000E
	dw $28CC,$28C8,$28D2,$28D2,$28C8,$28CB,$28C4 ; MISSILE
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E
org $858905	; 0x028905
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858945	; 0x028945
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $3034,$7034
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E
org $858985	; 0x028985
	dw $000E,$000E,$000E
	dw $28E9,$28EA,$28EB
	dw $000E
	dw $3035,$7035
	dw $000E
	dw $28F9
	dw $000E
	dw $28E0,$28E1,$28E2,$28F0,$28F1,$28F2,$3CC1,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E,$000E

org $8589C5	; 0x0289C5, Power Bomb
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $28CF,$28CE,$28D6,$28C4,$28D1	; POWER
	dw $000E
	dw $28C1,$28CE,$28CC,$28C1	; BOMB
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
org $858A05	; 0x028A05
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858A45	; 0x028A45
	dw $000E,$000E,$000E,$000E,$000E
	dw $3036,$7036
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $858A85	; 0x028A85
	dw $000E
	dw $28E9,$28EA,$28EB
	dw $000E
	dw $3037,$7037
	dw $000E
	dw $28F9
	dw $000E
	dw $28F6,$28F7,$28F8
	dw $000E
	dw $28EE,$28EF,$28F0,$28F1,$28F2,$38D1,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E

org $858AC5	; 0x028AC5, Grappling Beam
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $28C6,$28D1,$28C0,$28CF,$28CF,$28CB,$28C8,$28CD,$28C6	; GRAPPLING
	dw $000E
	dw $28C1,$28C4,$28C0,$28CC	; BEAM
	dw $000E,$000E,$000E,$000E,$000E,$000E
org $858B05	; 0x028B05
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858B45	; 0x028B45
	dw $000E,$000E,$000E,$000E,$000E
	dw $3038,$7038
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $858B85	; 0x028B85
	dw $000E
	dw $28E9,$28EA,$28EB
	dw $000E
	dw $3039,$7039
	dw $000E
	dw $28E0,$28E1,$28E2
	dw $000E
	dw $28F9
	dw $000E
	dw $28E3,$28E4,$28F0,$28F1,$28F2,$38D8,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E

org $858BC5	; 0x028BC5, X-Ray Scope
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $28D7,$28BE,$28D1,$28C0,$28D8	; X-RAY
	dw $000E
	dw $28D2,$28C2,$28CE,$28CF,$28C4	; SCOPE
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E
org $858C05	; 0x028C05
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858C45	; 0x028C45
	dw $000E,$000E,$000E,$000E,$000E
	dw $303A,$703A
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $858C85	; 0x028C85
	dw $000E
	dw $28E9,$28EA,$28EB
	dw $000E
	dw $303B,$703B
	dw $000E
	dw $28E0,$28E1,$28E2
	dw $000E
	dw $28F9
	dw $000E
	dw $28E3,$28E4,$28F0,$28F1,$28F2,$38D7,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E

org $858CCB	; 0x028CCB, Varia Suit
	dw $000E,$000E,$000E,$000E
	dw $28D5,$28C0,$28D1,$28C8,$28C0	; VARIA
	dw $000E
	dw $28D2,$28D4,$28C8,$28D3	; SUIT
	dw $000E,$000E,$000E,$000E,$000E

org $858D0B	; 0x028D0B, Spring Ball
	dw $000E,$000E,$000E,$000E
	dw $28D2,$28CF,$28D1,$28C8,$28CD,$28C6	; SPRING
	dw $000E
	dw $28C1,$28C0,$28CB,$28CB	; BALL
	dw $000E,$000E,$000E,$000E

org $858D4B	; 0x028D4B, Morphing Ball
	dw $000E,$000E,$000E
	dw $28CC,$28CE,$28D1,$28CF,$28C7,$28C8,$28CD,$28C6	; MORPHING
	dw $000E
	dw $28C1,$28C0,$28CB,$28CB
	dw $000E,$000E,$000E

org $858D8B	; 0x028D8B, Screw Attack
	dw $000E,$000E,$000E
	dw $28D2,$28C2,$28D1,$28C4,$28D6	; SCREW
	dw $000E
	dw $28C0,$28D3,$28D3,$28C0,$28C2,$28CA	; ATTACK
	dw $000E,$000E,$000E,$000E

org $858DCB	; 0x028DCB, Hi-Jump Boots
	dw $000E,$000E,$000E
	dw $28C7,$28C8,$28BE,$28C9,$28D4,$28CC,$28CF	; HI-JUMP
	dw $000E
	dw $28C1,$28CE,$28CE,$28D3,$28D2	; BOOTS
	dw $000E,$000E,$000E

org $858E0B	; 0x028E0B, SPACE JUMP
	dw $000E,$000E,$000E,$000E
	dw $28D2,$28CF,$28C0,$28C2,$28C4	; SPACE
	dw $000E
	dw $28C9,$28D4,$28CC,$28CF	; JUMP
	dw $000E,$000E,$000E,$000E,$000E

org $858E45	; 0x028E45, Speed Booster
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $28D2,$28CF,$28C4,$28C4,$28C3	; SPEED
	dw $000E
	dw $28C1,$28CE,$28CE,$28D2,$28D3,$28C4,$28D1	; BOOSTER
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E
org $858E85	; 0x028E85
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858EC5	; 0x028EC5
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E
org $858F05	; 0x028F05
	dw $000E,$000E
	dw $28E0,$28E1,$28E2
	dw $000E
	dw $28F9
	dw $000E
	dw $28E3,$28E4,$28F0,$28F1,$28F2,$38BF,$28E5,$28E6,$28E7,$28E8
	dw $000E
	dw $28F3
	dw $000E
	dw $28EC,$28ED,$28FA
	dw $000E,$000E

org $858F4B	; 0x028F4B, Charge Beam
	dw $000E,$000E,$000E,$000E
	dw $28C2,$28C7,$28C0,$28D1,$28C6,$28C4	; CHARGE
	dw $000E
	dw $28C1,$28C4,$28C0,$28CC	; BEAM
	dw $000E,$000E,$000E,$000E

org $858F8B	; 0x028F8B, Ice Beam
	dw $000E,$000E,$000E,$000E,$000E
	dw $28C8,$28C2,$28C4	; ICE
	dw $000E
	dw $28C1,$28C4,$28C0,$28CC	; BEAM
	dw $000E,$000E,$000E,$000E,$000E,$000E

org $858FCB	; 0x028FCB, Wave Beam
	dw $000E,$000E,$000E,$000E,$000E
	dw $28D6,$28C0,$28D5,$28C4	; WAVE
	dw $000E
	dw $28C1,$28C4,$28C0,$28CC	; BEAM
	dw $000E,$000E,$000E,$000E,$000E

org $85900B	; 0x02900B, Spazer
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $28D2,$28CF,$28C0,$28D9,$28C4,$28D1	; SPAZER
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E

org $85904B	; 0x02904B, Plasma Beam
	dw $000E,$000E,$000E,$000E
	dw $28CF,$28CB,$28C0,$28D2,$28CC,$28C0	; PLASMA
	dw $000E
	dw $28C1,$28C4,$28C0,$28CC	; BEAM
	dw $000E,$000E,$000E,$000E

org $859085	; 0x029085, Bomb
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
	dw $28C1,$28CE,$28CC,$28C1	; BOMB
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $8590C5	; 0x0290C5
	dw $000E,$000E
	dw $38FC
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E
org $859105	; 0x029105
	dw $000E,$000E
	dw $3CFD,$3CFF
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E
org $859145	; 0x029145
	dw $000E,$000E
	dw $3CFE,$3CBC,$38BD,$3CFB
	dw $000E
	dw $28F9
	dw $000E
	dw $28F6,$28F7,$28F8
	dw $000E
	dw $28EE,$28EF,$28F0,$28F1,$28F2,$38CB,$28E5,$28E6,$28E7,$28E8,$28FA
	dw $000E,$000E

org $85918B	; 0x02918B, Map Data Access Completed
	dw $000E,$000E
	dw $3CCC,$3CC0,$3CCF	; MAP
	dw $000E
	dw $3CC3,$3CC0,$3CD3,$3CC0	; DATA
	dw $000E
	dw $3CC0,$3CC2,$3CC2,$3CC4,$3CD2,$3CD2	; ACCESS
	dw $000E,$000E
org $8591CB	; 0x0291CB
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $85920B	; 0x02920B
	dw $000E,$000E,$000E,$000E
	dw $3CC2,$3CCE,$3CCC,$3CCF,$3CCB,$3CC4,$3CD3,$3CC4,$3CC3,$3CDA	; COMPLETED.
	dw $000E,$000E,$000E,$000E,$000E

org $85924B	; 0x02924B, Energy Recharge Completed
	dw $000E,$000E
	dw $3CC4,$3CCD,$3CC4,$3CD1,$3CC6,$3CD8	; ENERGY
	dw $000E
	dw $3CD1,$3CC4,$3CC2,$3CC7,$3CC0,$3CD1,$3CC6,$3CC4	; RECHARGE
	dw $000E,$000E
org $85928B	; 0x02928B
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $8592CB	; 0x0292CB
	dw $000E,$000E,$000E,$000E
	dw $3CC2,$3CCE,$3CCC,$3CCF,$3CCB,$3CC4,$3CD3,$3CC4,$3CC3,$3CDA	; COMPLETED.
	dw $000E,$000E,$000E,$000E,$000E

org $85930B	; 0x02930B, Missile Reload Completed
	dw $000E,$000E
	dw $3CCC,$3CC8,$3CD2,$3CD2,$3CC8,$3CCB,$3CC4	; MISSILE
	dw $000E
	dw $3CD1,$3CC4,$3CCB,$3CCE,$3CC0,$3CC3	; RELOAD
	dw $000E,$000E,$000E
org $85934B	; 0x02934B
	dw $000E,$000E,$380F,$380F,$380F,$380F,$380F,$380F
	dw $380F,$380F,$380F,$380F,$380F,$380F,$380F,$380F
	dw $000E,$000E,$000E
org $85938B	; 0x02938B
	dw $000E,$000E,$380F,$380F
	dw $3CC2,$3CCE,$3CCC,$3CCF,$3CCB,$3CC4,$3CD3,$3CC4,$3CC3,$3CDA	; COMPLETED.
	dw $380F,$380F,$000E,$000E,$000E

org $8593CB	; 0x0293CB, Would you like to save? ->Yes No
	dw $000E,$000E
	dw $3CD6,$3CCE,$3CD4,$3CCB,$3CC3	; WOULD
	dw $000E
	dw $3CD8,$3CCE,$3CD4	; YOU
	dw $000E
	dw $3CCB,$3CC8,$3CCA,$3CC4	; LIKE
	dw $000E,$000E,$000E
org $85940B	; 0x02940B
	dw $000E,$000E
	dw $3CD3,$3CCE	; TO
	dw $000E
	dw $3CD2,$3CC0,$3CD5,$3CC4,$3CDE	; SAVE?
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
org $85944B	; 0x02944B
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E,$000E,$000E,$000E,$000E,$000E
	dw $000E,$000E,$000E
org $85948B	; 0x02948B
	dw $000E,$000E
	dw $38BC,$38BD,$3CD8,$3CC4,$3CD2	; ->YES
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $2CCD,$2CCE	; NO
	dw $000E,$000E,$000E,$000E

org $8594CB	; 0x0294CB, Save Completed
	dw $000E,$000E
	dw $3CD2,$3CC0,$3CD5,$3CC4	; SAVE
	dw $000E
	dw $3CC2,$3CCE,$3CCC,$3CCF,$3CCB,$3CC4,$3CD3,$3CC4,$3CC3,$3CDA	; COMPLETED.
	dw $000E,$000E

org $85950B	; 0x02950B, Reserve Tank
	dw $000E,$000E,$000E
	dw $28D1,$28C4,$28D2,$28C4,$28D1,$28D5,$28C4	; RESERVE
	dw $000E
	dw $28D3,$28C0,$28CD,$28CA	; TANK
	dw $000E,$000E,$000E,$000E

org $85954B	; 0x02954B, Gravity Suit
	dw $000E,$000E,$000E
	dw $28C6,$28D1,$28C0,$28D5,$28C8,$28D3,$28D8 ; GRAVITY
	dw $000E
	dw $28D2,$28D4,$28C8,$28D3	; SUIT
	dw $000E,$000E,$000E,$000E

org $85958D	; 0x02958D, ->Yes No (Unused)
	dw $000E,$000E
	dw $38BC,$38BD,$3CD8,$3CC4,$3CD2	; ->YES
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $2CCD,$2CCE	; NO
	dw $000E,$000E,$000E,$000E
org $8595CD	; 0x0295CD, ->Yes No
	dw $000E,$000E
	dw $38BC,$38BD,$3CD8,$3CC4,$3CD2	; ->YES
	dw $000E,$000E,$000E,$000E,$000E,$000E
	dw $2CCD,$2CCE	; NO
	dw $000E,$000E,$000E,$000E
org $85960D	; 0x02960D, Yes ->No
	dw $000E,$000E,$000E,$000E
	dw $2CD8,$2CC4,$2CD2	; YES
	dw $000E,$000E,$000E,$000E
	dw $38BC,$38BD,$3CCD,$3CCE	; ->NO
	dw $000E,$000E,$000E,$000E

;----------------------------------------
;;; Free space ;;;
; Custom code for Map patch at free space
org $859650	; 0x029650
	LDA $196E	; AD 6E 19
	BEQ branch3	; F0 5B
	CMP #$0026	; C9 26 00
	BEQ branch4	; F0 29
	CMP #$000C	; C9 0C 00
	BEQ branch5	; F0 1F
	BCS branch3	; B0 4F
	CMP #$0006	; C9 06 00
	BEQ branch4	; F0 1D
	LDX $1F17	; AE 17 1F
	DEX		; CA
	DEX		; CA
	LDA $870000,X	; BF 00 00 87
	STA $4302	; 8D 02 43
	LDX $1F3B	; AE 3B 1F
	CLC		; 18
	BRA branch6	; 80 14
	LDX #$00	; A2 00
	CPY #$38	; C0 38
	BRA branch7	; 80 08
branch5:
	LDX #$C400	; A2 00 C4
	BRA branch7	; 80 03
branch4:
	LDX #$C200	; A2 00 C2
branch7:
	STX $4302	; 8E 02 43
	LDX #$0200	; A2 00 02
branch6:
	STX $4305	; 8E 05 43
	LDX #$4700	; A2 00 47
	STX $2116	; 8E 16 21
	LDX #$1801	; A2 01 18
	STX $4300	; 8E 00 43
	SEP #$20	; E2 20
	LDA #$9A	; A9 9A
	BCS branch8	; B0 02
	LDA #$87	; A9 87
branch8:
	STA $4304	; 8D 04 43
	LDA #$80	; A9 80
	STA $2115	; 8D 15 21
	LDA #$01	; A9 01
	STA $420B	; 8D 0B 42
branch3:
	JSR $81F3	; 20 F3 81
	RTS		; 60	

;----------------------------------------
;;; Animated tiles ;;;
org $8782AF	; 0x0382AF, Lava tiles
	dw $4700
org $8782CD	; 0x0382CD,Acid tiles
	dw $4700
org $8782EB	; 0x0382EB,Rain tiles
	dw $4700
org $878301	; 0x038301,Spores tiles
	dw $4700

;----------------------------------------
;;; Load FX Header ;;;
org $89AC31	; 0x04AC31, Branch load
	JSR $AF00	; FX tilemap pointer = [$ABF0 + [FX type]]
; Pointer to new code / free space

;----------------------------------------
;;; Free space ;;;
; Custom code
org $89AF00	; 0x04AF00, pointer from 0x04AC31 points to here
	CMP #$0026	; C9 26 00
	BEQ branch9	; F0 11
	CMP #$000C	; C9 0C 00
	BEQ branch10	; F0 07
	CMP #$0006	; C9 06 00
	BEQ branch9	; F0 07
	BRA branch11	; 80 1D
branch10:
	LDA #$9AC4	; A9 C4 9A
	BRA branch12	; 80 03
branch9:
	LDA #$9AC2	; A9 C2 9A
branch12:
	STA $05C1	; 8D C1 05
	LDA #$0047	; A9 47 00
	STA $05BF	; 8D BF 05
	LDA #$0200	; A9 00 02
	STA $05C3	; 8D C3 05
	LDA #$0080	; A9 80 00
	STA $05BD	; 8D BD 05
branch11:
	LDA $ABF0,Y	; B9 F0 AB
	RTS		; 60

;----------------------------------------
;;; FX Tilemaps ;;;
org $8A8000	; $8A8000-8AB17E, 0x050000-0x05317E
	incbin 8Atilemap.bin
;----------------------------------------
;;; Menu tiles ;;;
org $8E8000	; $8E8000-8EDBFF, 0x070000-0x075BFF
	incbin 8Etiles.bin
;----------------------------------------
;;; Projectile and Map graphics ;;;
org $9AB200	; $9AB200-9AC5FF, 0x0D3200-0x0D45FF
	incbin 9Atiles.bin
;----------------------------------------
;;; Pause Screen graphics ;;;
org $B68000	; 0x1B0000-0x1B6FFF
	;incbin B6tiles.bin		; Graphics $B68000-B6DFFF
	;incbin B6tilemap.bin	; Tilemaps $B6E000-B6EFFF
;----------------------------------------
;;; Free space bank ;;;
org $B8E000	; 0x1C6000-0x176FFF
	incbin B8palettes.bin	; Palettes $B8E000-B8FFFF
;----------------------------------------
;
