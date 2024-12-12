;Single-Use-Gates
;-------------------
;Special gate topper that sets an event when used & cannot be used again.
;Gate top and body included.
;Event given should match between the two PLMs 

;PATCH WILL BREAK IF VANILLA GATE BODY PLM IS REPOINTED
;if so, make sure to update the jump in SingleUseGateBody_setup
;also contains some orgs to fix the vanilla PB Gate draw instructions.

;For the topper:
;Room Arg is RTEE
;R = 8 for right facing gate; else left 
;T = 0-3 gate type
;	0 - Blue
;	1 - Pink
;	2 - Green
;	3 - Yellow
;EE event to set.

;For the gate body:
;Room arg is 00EE
;EE event to look for.
lorom
!84Free = $84F110

org $949EA6 ;entire PLM table for shot block tile type. $B62F for "Don't Make PLM". Gate reaction is $3F.
;  0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F
dw $D064,$D068,$D06C,$D070,$D074,$D078,$D07C,$D080,$D084,$D088,$D08C,$D090,$B62F,$B62F,$B62F,$B62F
dw $B974,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F
dw $B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F
dw $B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,$B62F,PlmHeaders_SingleUseGateTop_reactionGeneric
dw $C8A2,$C8A8,$C8AE,$C8B4,$C83E,$EED3,$C816,$C81A,$C80E,$C812,$C806,$C80A,$C81E,$C822,$B62F,$B9C1

;Orgs in $84 for fixing PB Gate draw instruction
{
org $84A613
dw $0001, $80D6
db $FF, $00
dw $0001, $C0DC
dw $0000

org $84A61F
dw $0002, $80D6, $C4DC
dw $0000
}

org !84Free
PlmHeaders:
{
print pc, " - SingleUseGateTop Topper"
.SingleUseGateTop
dw SingleUseGateTop_setup, SingleUseGateTop_inst
..reactionGeneric
dw SingleUseGateTop_shotReaction_setup_generic, SingleUseGateTop_shotReaction_inst
print pc, " - SingleUseGateTop Body"
.SingleUseGateBody
dw SingleUseGateBody_setup, $BC3A
}

SingleUseGateTop:
{
.setup
LDA $1DC7,y : AND #$00FF : JSL $808233 ;check if event set
BCC +
;If event set then go to used inst lists
	LDA $1DC7,y : BMI ++
	LDA #.inst_usedLeft : BRA +++
	++
	LDA #.inst_usedRight
	+++
	STA $1D27,y
	RTS
+
TDC : TAX
LDA $1DC7,y : BPL +
INX : INX
+
STX $14
LDA ..leftBlockTable,x        
BEQ +        ;Skip the replacement if the table reads 0000
LDX $1C87,y        
DEX : DEX                
JSR $82B4    ;Set [X] tile index to [A] tile type and BTS
+
LDX $14           
LDA ..rightBlockTable,x        
BEQ +
LDX $1C87,y        
INX : INX          
JSR $82B4          
+
;add 4*(roomArg && 0F00)XBA to $14
LDA $1DC7,y : AND #$0F00 : XBA : TAX : BEQ +
-
LDA $14 : CLC : ADC #$0004 : STA $14
DEX : BNE -
+
LDX $14
LDA ..instructionTable,x : STA $1D27,y
RTS
..instructionTable
dw .inst_blueLeft, .inst_blueRight, .inst_pinkLeft, .inst_pinkRight, .inst_greenLeft, .inst_greenRight, .inst_yellowLeft, .inst_yellowRight
..leftBlockTable
dw $C03F, $0000
..rightBlockTable
dw $0000, $C03F
.inst
;Needs custom insts for gate topper because vanilla deletes the PLM.
..blueLeft
dw $0001, $A5D7
dw $8724, ..leftGate

..blueRight
dw $0001, $A5E3
dw $8724, ..rightGate

..pinkLeft
dw $0001, $A5EB
dw $8724, ..leftGate

..pinkRight
dw $0001, $A5F7
dw $8724, ..rightGate

..greenLeft
dw $0001, $A5FF
dw $8724, ..leftGate

..greenRight
dw $0001, $A60B
dw $8724, ..rightGate

..yellowLeft
dw $0001, $A613
dw $8724, ..leftGate

..yellowRight
dw $0001, $A61F
dw $8724, ..rightGate

..leftGate
dw .rout_movePLM_left
dw $86B4
..rightGate
dw .rout_movePLM_right
dw $86B4


..usedLeft
dw $0001, .draw_usedLeft
dw $86BC
..usedRight
dw $0001, .draw_usedRight
dw $86BC
.rout
..movePLM
;Right one is already a vanilla instruction at $ABD6 but i wanted consistent code.
...left
DEC $1C87,x
DEC $1C87,x
RTS
...right
INC $1C87,x
INC $1C87,x
RTS

.draw
;starts drawing on top of gate.
..usedLeft
dw $0001, $80D6
db $FF, $00
dw $0001, $80D8
dw $0000
..usedRight
dw $0002, $80D6, $84D8
dw $0000

.shotReaction
..setup
...generic
;version that looks at the PLM for all its direction and shot information
JSR ...findPLMontop ;Returns [X] PLM index found and PLM room arg in [$12]
STX $14
;do shot checks here based on PLM room arg
LDX $0DDE	;projectile index
PHY
LDA $12 : AND #$0F00 : BEQ ....openGate	;if gate arg was 0 then skip all checks
XBA : ASL : TAY : LDA $0C18,x : AND #$0F00
CMP ....damageTable1,y : BEQ ....openGate
CMP ....damageTable2,y : BEQ ....openGate
PLY
TYX
STZ $1C37,x
RTS
....openGate
PLY
LDX $14 : STZ $1C37,x ;kill found PLM
LDA $12 : AND #$00FF 
JSL $8081FA						  ;|Mark event from found PLM
LDX #$0000                        ;|
LDA $12 : BPL +                   ;|
	INX : INX                     ;|
+                                 ;|-Trigger PLM in correct direction to PLM
PHX
LDA $1C37,y : PHA                 ;|
JSR (....triggerDirectionTable,x) ;|
PLA : STA $1C37,y                 ;|-Also branch to correct instruction list.
PLX
LDA ....instructionListTable,x : STA $1D27,y

LDX $1C87,y : LDA $7F0002,x : AND #$0FFF : ORA #$8000 : STA $7F0002,x
RTS
....triggerDirectionTable
;pointers to vanilla trigger right/left routines
dw $C63F,$C647
....instructionListTable ;only needs to draw used graphics; colored gate ones are drawn by topper PLM.
dw ..inst_left,..inst_right
....damageTable1
;  filler missl  supr   pb
dw $0000, $0100, $0200, $0300
....damageTable2
dw $FFFF, $0200, $FFFF, $FFFF
...findPLMontop
;Look for PLM with same tile indices as this one and read room arg for event
;returns the found PLM in [X] and the room arg in [$12]

LDA $1C87,y
LDX #$004E 
-
CMP $1C87,x
BEQ ....found 
....resume
DEX : DEX        
BPL -
BRA ....notFound
....found
;If it found itself, get back in the loop. 
;This happens if a PLM earlier on in the room set deletes itself, which will cause the reaction to spawn in an index lower than the topper. Finds itself first.
;Else, store the found room argument to [$12].
STX $12 : CPY $12 : BEQ ....resume
LDA $1DC7,x : STA $12
RTS
....notFound
RTS

..inst
...left
dw .rout_movePLM_right ;draw on top of the gate top
dw $0001, .draw_usedLeft
dw $86BC
...right
dw .rout_movePLM_left 
dw $0001, .draw_usedRight
dw $86BC
}
SingleUseGateBody:
{
.setup
;check for an event and then jump to normal gate instructions and setup.
LDA $1DC7,y : AND #$00FF : JSL $808233 ;check if event set
BCC +
;If event set then delete
	TDC : STA $1C37,y
	RTS
+
JMP $C6BE	;vanilla downward closed gate setup
}