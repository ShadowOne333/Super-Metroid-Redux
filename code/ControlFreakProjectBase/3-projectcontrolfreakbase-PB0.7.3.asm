lorom

;apply project base, control freak, this patch

;;disable backflip?
org $91A6F0
	; 2 bytes
	db $FF,$FF

org $91A740
	; 2 bytes
	db $FF,$FF

;==========spinjump restart======================
org $90F63A	;clearing some pb spinjump leftovers
	db $FF,$FF,$FF,$FF,$FF,$FF

;Originally org $90F870
org $90F670	;$1E bytes for spinjump restart ; moved to freespace, default value was $90F670
	LDA $0A23
	AND #$00FF
	CMP #$0003
	BEQ ENDAIR
	CMP #$0002
	BEQ ENDAIR
	CMP #$0006
	BEQ ENDAIR
	CMP #$0014
	BEQ ENDAIR
	JSL $9098BC
ENDAIR:
	RTL

org $91FC99	;no idea, points to spinjump restart
	JSL $90F670 ; moved to freespace, default value was $90F670
	RTS
;-------------------------------------------

;==========animation table=====================
org $B8A000   	;is $919EE2 in probably every other rom
		;control freak has some other table
		;pretty much a repointed animation table
		;not even 1/4 the bank is being used

	DW T00,T01,T02,T03,T04,T05,T06,T07,T08,T09,T0A,T0B,T0C,T0D,T0E,T0F
	DW T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T1A,T1B,T1C,T1D,T1E,T1F
	DW T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T2A,T2B,T2C,T2D,T2E,T2F
	DW T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T3A,T3B,T3C,T3D,T3E,T3F
	DW T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T4A,T4B,T4C,T4D,T4E,T4F
	DW T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T5A,T5B,T5C,T5D,T5E,T5F
	DW T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T6A,T6B,T6C,T6D,T6E,T6F
	DW T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T7A,T7B,T7C,T7D,T7E,T7F
	DW T80,T81,T82,T83,T84,T85,T86,T87,T88,T89,T8A,T8B,T8C,T8D,T8E,T8F
	DW T90,T91,T92,T93,T94,T95,T96,T97,T98,T99,T9A,T9B,T9C,T9D,T9E,T9F
	DW TA0,TA1,TA2,TA3,TA4,TA5,TA6,TA7,TA8,TA9,TAA,TAB,TAC,TAD,TAE,TAF
	DW TB0,TB1,TB2,TB3,TB4,TB5,TB6,TB7,TB8,TB9,TBA,TBB,TBC,TBD,TBE,TBF
	DW TC0,TC1,TC2,TC3,TC4,TC5,TC6,TC7,TC8,TC9,TCA,TCB,TCC,TCD,TCE,TCF
	DW TD0,TD1,TD2,TD3,TD4,TD5,TD6,TD7,TD8,TD9,TDA,TDB,TDC,TDD,TDE,TDF
	DW TE0,TE1,TE2,TE3,TE4,TE5,TE6,TE7,TE8,TE9,TEA,TEB,TEC,TED,TEE,TEF
	DW TF0,TF1,TF2,TF3,TF4,TF5,TF6,TF7,TF8,TF9,TFA,TFB,TFC

;button press,button hold,table transition

;8000: B button
;4000: Y button
;2000: Select
;1000: Start
;0800: Up
;0400: Down
;0200: Left
;0100: Right
;0080: A button
;0040: X button
;0020: L
;0010: R

;-------------------------------------------------------------------------------------------------------
T00:	;= Facing forward, ala Elevator pose.
T9B:	;= Facing forward, ala Elevator pose... with the Varia and/or Gravity Suit.
DW $0000,$0100,$0026	;pb/cf	(hold [LEFT] standing left, turning right, to turn left)
DW $0000,$0200,$0025	;pb/cf	(hold [RIGHT] standing right, turning left, to turn right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T03:	;= Facing right, aiming up
TE0:	;= Landing from normal jump, facing right and aiming up
DW $0080,$0800,$0055	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0410,$0059	;cf	(press [A] & hold [R+DOWN] to jump aiming downright)
DW $0080,$0010,$0055	;cf	(press [A] & hold [R] to jump aiming up)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0400,$0010,$0005	;cf	(press [DOWN] & hold [R] to aim upright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to aim up) ($000D)
DW $0000,$0900,$000F	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$0011	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0210,$008B	;cf	(hold [R+LEFT] to turn left aiming up)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0000,$0010,$0003	;cf	(hold [R] to aim up)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T05:	;= Facing right, aiming upright
TE2:	;= Landing from normal jump, facing right and aiming upright
TCF:	;= Samus ran right into a wall, is still holding right and is now aiming diagonal up
DW $0880,$0010,$0055	;cf	(press [UP+A] & hold [R] to jump aiming up)
DW $0480,$0010,$0059	;cf	(press [DOWN+A] & hold [R] to jump aiming downright)
DW $0080,$0010,$0057	;cf	(press [A] & hold [R] to jump aiming upright)
DW $0080,$0800,$0055	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0400,$0010,$0007	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0800,$0110,$000F	;cf	(press [UP] & hold [R+RIGHT] to aim up) ($000D)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to aim upright)
DW $0800,$0100,$000F	;cf	(press [UP] & hold [RIGHT] to aim upright)
DW $0000,$0210,$009C	;cf	(hold [R+LEFT] to turn left aiming downleft)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0800,$0010,$0003	;cf	(press [UP] & hold [R] to aim up)
DW $0000,$0010,$0005	;cf	(hold [R] to aim upright)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T07:	;= Facing right, aiming downright
TD1:	;= Samus ran right into a wall, is still holding right and is now aiming diagonal down
;;;DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
;;;DW $0080,$8000,$0019	;pb	(press [A] & hold [B] to spinjump)
;;;DW $0080,$0000,$004B	;pb	(press [A] to jump)
;;;DW $0000,$0900,$000F	;pb	(hold [UP+RIGHT] to aim upright)
;;;DW $0000,$0500,$0011	;pb	(hold [DOWN+RIGHT] to aim downright)
;;;DW $0400,$0000,$0035	;pb	(press [DOWN] to crouch)
;;;DW $0000,$0220,$0078	;pb	(hold [L+LEFT] to moonwalk aiming downright)
;;;DW $0000,$0210,$0076	;pb	(hold [R+LEFT] to moonwalk aiming upleft)
;;;DW $0000,$0800,$0003	;pb	(hold [UP] to aim up)
;;;DW $0000,$0010,$0005	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$0007	;pb	(hold [L] to aim downright)
;;;DW $0000,$0200,$0025	;pb	(hold [LEFT] to turn left)
;;;DW $0000,$0100,$0009	;pb	(hold [RIGHT] to move right)
;;;DW $FFFF
TE4:	;= Landing from normal jump, facing right and aiming downright
DW $0080,$0800,$0055	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0010,$0059	;cf	(press [A] & hold [R] to jump aiming downright)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0400,$0010,$00F5	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to face right)
DW $0800,$0110,$000F	;cf	(press [UP] & hold [R+RIGHT] to aim upright)
DW $0000,$0110,$0011	;cf	(hold [R+RIGHT] to aim downright)
DW $0000,$0210,$008D	;cf	(hold [R+LEFT] to turn left aiming downleft)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0800,$0010,$0005	;cf	(press [UP] & hold [R] to aim upright)
DW $0000,$0010,$0007	;cf	(hold [R] to aim downright)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T01:	;= Facing right, normal
DW $0000,$4400,$0037	;pb	(hold [Y+Down] to morph)
TA4:	;= Landing from normal jump, facing right
TA6:	;= Landing from spin jump, facing right
TE6:	;= Landing from normal jump, facing right, firing
DW $0080,$0800,$0055	;pb	(press [A] & hold [UP] to jump off ground right aiming up)
DW $0080,$0010,$0057	;pb	(press [A] & hold [R] to jump off ground right aiming upright)
;;;DW $0080,$0020,$0059	;pb	(press [A] & hold [L] to Jump off ground right aiming downright)
;DW $0080,$8000,$0019	;pb	(press [A] & hold [B] to spinjump right) ;might want to disable for auto-run
DW $0080,$0000,$004B	;pb	(press [A] to jump off ground right)
;;;DW $0400,$0030,$00F1	;pb	(press [DOWN] & hold [L+R] to crouch right aiming up)
;;;DW $0400,$0010,$00F3	;pb	(press [DOWN] & hold [R] to crouch right aiming upright)
;;;DW $0400,$0020,$00F5	;pb	(press [DOWN] & hold [L] to crouch right aiming downright)
DW $0400,$0000,$0035	;pb	(press [DOWN] to crouch right)
;;;DW $0000,$0260,$0078	;pb	(hold [LEFT+(L+X)] to moonwalk facing right aiming downright)
;;;DW $0000,$0250,$0076	;pb	(hold [LEFT+(R+X)] to moonwalk facing right aiming upright)
;;;DW $0000,$0230,$0025	;pb	(hold [LEFT+(L+R)] to stand right, turning left)
;;;DW $0000,$0030,$0003	;pb	(hold [L+R] to aim up)
DW $0000,$0110,$000F	;pb	(hold [R+RIGHT] to aim upright)
;;;DW $0000,$0120,$0011	;pb	(hold [L+RIGHT] to aim downright)
DW $0000,$0900,$000F	;pb	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$0011	;pb	(hold [DOWN+RIGHT] to aim downright)
;;;DW $0000,$0240,$004A	;pb	(hold [LEFT+X] to moonwalk facing right)
DW $0000,$0200,$0025	;pb	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;pb	(hold [UP] to aim up)
DW $0000,$0010,$0005	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$0007	;pb	(hold [L] to aim downright)
DW $0000,$0100,$0009	;pb	(hold [RIGHT] to move right)
DW $FFFF
T89:	;= Ran into a wall on right (facing right)
DW $0080,$0800,$0055	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0410,$0059	;cf	(press [A] & hold [R+DOWN] to jump aiming downright)
DW $0080,$0010,$0057	;cf	(press [A] & hold [R] to jump aiming upright)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0400,$0010,$0007	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0000,$0910,$000D	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to aim upright)
DW $0000,$0900,$000F	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$0011	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0000,$0810,$0003	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$0007	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0010,$0005	;cf	(hold [R] to aim upright)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T04:	;= Facing left, aiming up
TE1:	;= Landing from normal jump, facing left and aiming up
DW $0080,$0800,$0056	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0410,$005A	;cf	(press [A] & hold [R+DOWN] to jump aiming downleft)
DW $0080,$0010,$0056	;cf	(press [A] & hold [R] to jump aiming up)
DW $0080,$0000,$004C	;cf	(press [A] to jump)
DW $0400,$0010,$0006	;cf	(press [DOWN] & hold [R] to aim upleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0000,$0210,$0010	;cf	(hold [R+LEFT] to aim up) ($000E)
DW $0000,$0A00,$0010	;cf	(hold [UP+LEFT] to move left, aiming upleft)
DW $0000,$0110,$008C	;cf	(hold [R+RIGHT] to turn right aiming up)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0000,$0010,$0004	;cf	(hold [R] to aim up)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T06:	;= Facing left, aiming upleft
TD0:	;= Samus ran left into a wall, is still holding left and is now aiming diagonal up
TE3:	;= Landing from normal jump, facing left and aiming upleft
DW $0880,$0010,$0056	;cf	(press [UP+A] & hold [R] to jump aiming up)
DW $0480,$0010,$005A	;cf	(press [DOWN+A] & hold [R] to Jump aiming downleft)
DW $0080,$0010,$0058	;cf	(press [A] & hold [R] to jump aiming upleft)
DW $0080,$0800,$0056	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0000,$004C	;cf	(press [A] to jump)
DW $0400,$0010,$0008	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0800,$0210,$0010	;cf	(press [UP] & hold [R+LEFT] to move left aiming up) ($000E)
DW $0000,$0210,$0010	;cf	(hold [R+LEFT] to move left aiming upleft)
DW $0800,$0200,$0010	;cf	(press [UP] & hold [LEFT] to move left aiming upleft)
DW $0000,$0110,$009D	;cf	(hold [R+RIGHT] to turn right aiming downright)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0800,$0010,$0004	;cf	(press [UP] & hold [R] to aim up)
DW $0000,$0010,$0006	;cf	(hold [R] to aim upleft)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TD2:	;= Samus ran left into a wall, is still holding left and is now aiming diagonal down
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
;DW $0080,$8000,$001A	;pb	(press [A] & hold [B] to spinjump) ;might want to disable for auto-run
DW $0080,$0000,$004C	;pb	(press [A] to jump)
DW $0000,$0A00,$0010	;pb	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$0012	;pb	(hold [DOWN+LEFT] to aim downleft)
DW $0400,$0000,$0036	;pb	(press [DOWN] to crouch)
;;;DW $0000,$0120,$0077	;pb	(hold [L+RIGHT] to moonwalk aiming downleft)
;;;DW $0000,$0110,$0075	;pb	(hold [R+RIGHT] to moonwalk aiming upleft)
;;;DW $0000,$0800,$0004	;pb	(hold [UP] to aim up)
;;;DW $0000,$0010,$0006	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0008	;pb	(hold [L] to aim downleft)
DW $0000,$0100,$0026	;pb	(hold [RIGHT] to turn right)
DW $0000,$0200,$000A	;pb	(hold [LEFT] to move left)
DW $FFFF
T08:	;= Facing left, aiming downleft
TE5:	;= Landing from normal jump, facing left and aiming downleft
DW $0880,$0810,$0058	;cf	(press [UP+A] & hold [R+UP] to jump aiming upleft)
;DW $0080,$8000,$001A	;pb	(press [A] & hold [B] to spinjump) ;might want to disable for auto-run
DW $0080,$0800,$0056	;cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0010,$005A	;cf	(press [A] & hold [R] to jump aiming downleft)
DW $0080,$0000,$004C	;cf	(press [A] to jump)
DW $0400,$0010,$00F6	;cf	(press [DOWN] & hold [R] to crouch aiming downleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0800,$0210,$0010	;cf	(press [UP] & hold [R+LEFT] to move left aiming upleft)
DW $0000,$0210,$0012	;cf	(hold [R+LEFT] to move left aiming downleft)
DW $0000,$0110,$008E	;cf	(hold [R+RIGHT] to turn right aiming downright)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0800,$0010,$0006	;cf	(press [UP] & hold [R] to aim upleft)
DW $0000,$0010,$0008	;cf	(hold [R] to aim downleft)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T02:	;= Facing left, normal
DW $0000,$4400,$0038	;pb	(hold [Y+Down] to morph)
T8A:	;= Ran into a wall on left (facing left)
TA5:	;= Landing from normal jump, facing left
TA7:	;= Landing from spin jump, facing left
TE7:	;= Landing from normal jump, facing left, firing
DW $0080,$0800,$0056	;pb/cf	(press [A] & hold [UP] to jump aiming up)
DW $0080,$0010,$0058	;pb/cf	(press [A] & hold [R] to jump aiming upleft)
;;;DW $0080,$0020,$005A	;pb	(press [A] & hold [L] to jump aiming downleft)
DW $0080,$0410,$005A	;cf	(press [A] & hold [R+DOWN] to jump aiming downleft)
;DW $0080,$8000,$001A	;pb	(press [A] & hold [B] to spinjump left) ;might want to disable for auto-run
DW $0080,$0000,$004C	;pb/cf	(press [A] to jump)
;;;DW $0400,$0030,$00F2	;pb	(press [DOWN] & hold [L+R] to crouch aiming up)
;;;DW $0400,$0010,$00F4	;pb	(press [DOWN] & hold [R] to crouch aiming upleft)
;;;DW $0400,$0020,$00F6	;pb	(press [DOWN] & hold [L] to crouch aiming downleft)
DW $0400,$0000,$0036	;pb/cf	(press [DOWN] to crouch)
;;;DW $0000,$0160,$0077	;pb	(hold [RIGHT+(L+X)] to moonwalk aiming downleft)
;;;DW $0000,$0150,$0075	;pb	(hold [RIGHT+(R+X)] to moonwalk aiming upleft)
;;;DW $0000,$0140,$0049	;pb	(hold [RIGHT+X] to moonwalk)
DW $0000,$0100,$0026	;pb/cf	(hold [RIGHT] to turn right)
;;;DW $0000,$0030,$0004	;pb	(hold [L+R] to aim up)
DW $0000,$0210,$0010	;pb/cf	(hold [R+LEFT] to aim upleft)
;;;DW $0000,$0220,$0012	;pb	(hold [L+LEFT] to aim downleft)
DW $0000,$0A00,$0010	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$0012	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0800,$0004	;pb/cf	(hold [UP] to aim up)
DW $0000,$0810,$0004	;cf	(hold [R+UP] to aim up)
DW $0000,$0010,$0006	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0008	;pb	(hold [L] to aim downleft)
DW $0000,$0410,$0008	;cf	(hold [R+DOWN] to aim downleft)
DW $0400,$0010,$0008	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0000,$0200,$000A	;pb/cf	(hold [LEFT] to move left)
DW $0000,$0A10,$000E	;cf	(hold [R+(UP+LEFT)] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T09:	;= Moving right, not aiming
DW $0400,$0110,$0011	;cf	(press [DOWN] & hold [R+RIGHT] to aim downright)
DW $0400,$0010,$0007	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0080,$0000,$0019	;cf	(press [A] to spinjump)
DW $0000,$0910,$000D	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$000F	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$0011	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to aim upright)
DW $0000,$0140,$000B	;cf	(hold [RIGHT+X] to extend gun forward)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0410,$0007	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0010,$0005	;cf	(hold [R] to aim upright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T0D:	;= Moving right, aiming straight up
DW $0400,$0110,$000F	;cf	(press [DOWN] & hold [R+RIGHT] to aim upright)
DW $0400,$0010,$0005	;cf	(press [DOWN] & hold [R] to aim upright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0080,$0010,$0055	;cf	(press [A] to jump)
DW $0080,$0000,$0019	;cf	(press [A] to spinjump)
DW $0000,$0910,$000D	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$000F	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to move right aiming up) ($000D)
DW $0000,$0140,$000B	;cf	(hold [RIGHT+X] to extend gun forward)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move right)
DW $0000,$0210,$008B	;cf	(hold [R+LEFT] to turn left aiming up)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $0000,$0010,$0003	;cf	(hold [R] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T0F:	;= Moving right, aiming upright
DW $0400,$0110,$0011	;cf	(press [DOWN] & hold [R+RIGHT] to aim downright)
DW $0400,$0010,$0007	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;cf	(press [DOWN] to crouch)
DW $0080,$0010,$0057	;cf	(press [A] & hold [R] to jump aiming upright)
DW $0080,$0000,$0019	;cf	(press [A] to spinjump)
DW $0800,$0110,$000F	;cf	(press [UP] & hold [R+RIGHT] to aim up) ($000D)
DW $0000,$0110,$000F	;cf	(hold [R+RIGHT] to move aiming upright)
DW $0000,$0900,$000F	;cf	(hold [UP+RIGHT] to move aiming upright)
DW $0000,$0140,$000B	;cf	(hold [RIGHT+X] to extend gun)
DW $0000,$0100,$0009	;cf	(hold [RIGHT] to move)
DW $0000,$0210,$009C	;cf	(hold [R+LEFT] to turn left)
DW $0000,$0010,$0005	;cf	(hold [R] to aim upright)
DW $0000,$0200,$0025	;cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;cf	(hold [UP] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T11:	;= Moving right, aiming downright
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to F)
DW $0400,$0010,$00F5	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0035	;pb/cf	(press [DOWN] to crouch)
DW $0080,$0000,$0019	;pb/cf	(press [A] to spinjump)
DW $0080,$0010,$0059	;cf	(press [A] & hold [R] to jump aiming downright)
;;;DW $0000,$0110,$000F	;pb	(hold [R+RIGHT] to move aiming upright)
DW $0800,$0110,$000F	;cf	(press [UP] & hold [R+RIGHT] to move aiming upright)
;;;DW $0000,$0120,$0011	;pb	(hold [L+RIGHT] to move aiming downright)
DW $0000,$0900,$000F	;pb/cf	(hold [UP+RIGHT] to move aiming upright)
DW $0000,$0500,$0011	;pb/cf	(hold [DOWN+RIGHT] to move aiming downright)
DW $0000,$0110,$0011	;cf	(hold [R+RIGHT] to move aiming downright)
DW $0000,$0140,$000B	;pb/cf	(hold [RIGHT+X] to extend gun)
DW $0000,$0100,$0009	;pb/cf	(hold [RIGHT] to move)
DW $0000,$0210,$008D	;cf	(hold [R+LEFT] to turn left)
DW $0000,$0200,$0025	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;pb/cf	(hold [UP] to aim up)
;;;DW $0000,$0010,$0005	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$0007	;pb	(hold [L] to aim downright)
DW $0000,$0010,$0007	;cf	(hold [R] to aim downright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T0A:	;= Moving left, not aiming
DW $0400,$0210,$0012	;cf	(press [DOWN] & hold [R+LEFT] to move aiming downleft)
DW $0400,$0010,$0008	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0080,$0000,$001A	;cf	(press [A] to spinjump)
DW $0000,$0A10,$000E	;cf	(hold R+(UP+LEFT)] to move aiming up)
DW $0000,$0A00,$0010	;cf	(hold [UP+LEFT] to move aiming upleft)
DW $0000,$0600,$0012	;cf	(hold [DOWN+LEFT] to move aiming downleft)
DW $0000,$0210,$0010	;cf	(hold [R+LEFT] to move aiming upleft)
DW $0000,$0240,$000C	;cf	(hold [LEFT+X] to extend gun)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $0000,$0410,$0008	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0010,$0006	;cf	(hold [R] to aim upleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T0E:	;= Moving left, aiming straight up
DW $0400,$0210,$0010	;cf	(press [DOWN] & hold [R+LEFT] to move aiming upleft)
DW $0400,$0010,$0006	;cf	(press [DOWN] & hold [R] to aim upleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0080,$0010,$0056	;cf	(press [A] & hold [R] to jump aiming up)
DW $0080,$0000,$001A	;cf	(press [A] to spinjump)
DW $0000,$0A10,$000E	;cf	(hold R+(UP+LEFT)] to move aiming up)
DW $0000,$0A00,$0010	;cf	(hold [UP+LEFT] to move aiming upleft)
DW $0000,$0210,$0010	;cf	(hold [R+LEFT] to move aiming up) ($000E)
DW $0000,$0240,$000C	;cf	(hold [LEFT+X] to extend gun)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move)
DW $0000,$0110,$008C	;cf	(hold [R+RIGHT] to turn right aiming up)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $0000,$0010,$0004	;cf	(hold [R] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T10:	;= Moving left, aiming upleft
DW $0400,$0210,$0012	;cf	(press [DOWN] & hold [R+LEFT] to move aiming downleft)
DW $0400,$0010,$0008	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0400,$0000,$0036	;cf	(press [DOWN] to crouch)
DW $0080,$0010,$0058	;cf	(press [A] & hold [R] to jump aiming upleft)
DW $0080,$0000,$001A	;cf	(press [A] to spinjump)
DW $0800,$0210,$0010	;cf	(press [UP] & hold [R+LEFT] to move aiming up) ($000E)
DW $0000,$0210,$0010	;cf	(hold [R+LEFT] to move aiming upleft)
DW $0000,$0A00,$0010	;cf	(hold [UP+LEFT] to move aiming upleft)
DW $0000,$0240,$000C	;cf	(hold [LEFT+X] to extend gun)
DW $0000,$0200,$000A	;cf	(hold [LEFT] to move)
DW $0000,$0110,$009D	;cf	(hold [R+RIGHT] to turn right aiming up)
DW $0000,$0010,$0006	;cf	(hold [R] to aim upleft)
DW $0000,$0100,$0026	;cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0004	;cf	(hold [UP] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T12:	;= Moving left, aiming downleft
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0400,$0010,$00F6	;cf	(press [DOWN] & hold [R] to crouch aiming downleft)
DW $0400,$0000,$0036	;pb/cf	(press [DOWN] to crouch)
DW $0080,$0010,$005A	;cf	(press [A] & hold [R] to jump aiming downleft)
DW $0080,$0000,$001A	;pb/cf	(press [A] to spinjump)
;;;DW $0000,$0210,$0010	;pb	(hold [R+LEFT] to move aiming upleft)
DW $0800,$0210,$0010	;cf	(press [UP] & hold [R+LEFT] to move aiming upleft)
DW $0000,$0210,$0012	;cf	(hold [R+LEFT] to move aiming downleft)
;;;DW $0000,$0220,$0012	;pb	(hold [L+LEFT] to move aiming downleft)
DW $0000,$0A00,$0010	;pb/cf	(hold [UP+LEFT] to move aiming upleft)
DW $0000,$0600,$0012	;pb/cf	(hold [DOWN+LEFT] to move aiming downleft)
DW $0000,$0240,$000C	;pb/cf	(hold [LEFT+X] to extend gun)
DW $0000,$0200,$000A	;pb/cf	(hold [LEFT] to move)
DW $0000,$0110,$008E	;cf	(hold [R+RIGHT] to turn right aiming downright)
DW $0000,$0100,$0026	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0004	;pb/cf	(hold [UP] to aim up)
;;;DW $0000,$0010,$0006	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0008	;pb	(hold [L] to aim downleft)
DW $0000,$0010,$0008	;cf	(hold [R] to aim downleft)
DW $FFFF

;-------------------------------------------------------------------------------------------------------
T0B:	;= Moving right, gun extended forward (not aiming)
DW $0400,$0000,$0035	;pb/cf	(press [DOWN] to crouch)
DW $0080,$0000,$0019	;pb/cf	(press [A] to spinjump)
DW $0000,$0910,$000D	;cf	(hold [R+(UP+RIGHT)] to move aiming up)
DW $0000,$0110,$000F	;pb/cf	(hold [R+RIGHT] to move aiming upright)
;;;DW $0000,$0120,$0011	;pb	(hold [L+RIGHT] to move aiming downright)
DW $0400,$0110,$0011	;cf	(press [DOWN] & hold [R+RIGHT] to move aiming downright)
DW $0400,$0010,$0007	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0000,$0900,$000F	;pb/cf	(hold [UP+RIGHT] to move aiming upright)
DW $0000,$0500,$0011	;pb/cf	(hold [DOWN+RIGHT] to move aiming downright)
DW $0000,$0100,$000B	;pb/cf	(hold [RIGHT] to move)
DW $0000,$0200,$0025	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0003	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$0005	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0007	;pb	(hold [L] to aim downleft)
DW $0000,$0410,$0007	;cf	(hold [R+DOWN] to aim downleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T0C:	;= Moving left, gun extended forward (not aiming)
DW $0400,$0000,$0036	;pb/cf	(press [DOWN] to crouch)
DW $0080,$0000,$001A	;pb/cf	(press [A] to spinjump)
DW $0000,$0210,$0010	;pb/cf	(hold [R+LEFT] to move aiming upleft)
;;;DW $0000,$0220,$0012	;pb	(hold [L+LEFT] to move aiming downleft)
DW $0400,$0210,$0012	;cf	(press [DOWN] & hold [R+LEFT] to move aiming downleft)
DW $0400,$0010,$0008	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0000,$0A10,$000E	;cf	(hold [R+(UP+LEFT)] to move aiming up)
DW $0000,$0A00,$0010	;pb/cf	(hold [UP+LEFT] to move aiming upleft)
DW $0000,$0600,$0012	;pb/cf	(hold [DOWN+LEFT] to move aiming downleft)
DW $0000,$0200,$000C	;pb/cf	(hold [LEFT] to move)
DW $0000,$0100,$0026	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0004	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$0006	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0008	;pb	(hold [L] to aim downleft)
DW $0000,$0410,$0008	;cf	(hold [R+DOWN] to aim downleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T13:	;= Normal jump facing right, gun extended, not aiming or moving
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0910,$0015	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$0069	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006B	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0190,$0069	;pb/cf	(hold [R+(RIGHT+A)] to aim upright)
;;;DW $0000,$01A0,$006B	;pb	(hold [L+(RIGHT+A)] to aim downright)
DW $0000,$0200,$002F	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0010,$0069	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
DW $0000,$0100,$0051	;pb/cf	(hold [RIGHT] to move)
DW $0000,$0040,$0013	;pb/cf	(hold [X] to extend gun)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T14:	;= Normal jump facing left, gun extended, not aiming or moving
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A10,$0016	;cf	(hold [R+(UP+LEFT)] to aim up)
DW $0000,$0A00,$006A	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$006C	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0290,$006A	;pb/cf	(hold [R+(LEFT+A)] to aim upleft)
;;;DW $0000,$02A0,$006C	;pb	(hold [L+(LEFT+A)] to aim downleft)
DW $0000,$0100,$0030	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006A	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downright)
DW $0000,$0200,$0052	;pb/cf	(hold [LEFT] to move)
DW $0000,$0040,$0014	;pb/cf	(hold [X] to extend gun)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T15:	;= Normal jump facing right, aiming up
;conflict? DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0910,$0015	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$0069	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0190,$0015	;cf	(hold [R+(RIGHT+A)] to jump aiming up)
DW $0000,$0200,$002F	;cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0015	;cf	(hold [UP] to aim up)
DW $0400,$0010,$0069	;cf	(press [DOWN] & hold [R] to aim upright)
DW $0000,$0010,$0015	;cf	(hold [R] to aim up)
DW $0000,$0500,$006B	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0400,$0017	;cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0051	;cf	(hold [RIGHT] to move)
DW $0000,$00C0,$0013	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004D	;cf	(hold [A] to jump)
DW $0000,$0040,$0013	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T4D:	;= Normal jump facing right, gun not extended, not aiming, not moving
T51:	;= Normal jump facing right, moving forward (gun extended)
DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0910,$0015	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$0069	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006B	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0190,$0069	;cf	(hold [R+(RIGHT+A)] to aim upright)
DW $0000,$0200,$002F	;cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0015	;cf	(hold [UP] to aim up)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0400,$0017	;cf	(hold [DOWN] to aim down)
DW $0000,$0010,$0069	;cf	(hold [R] to aim upright)
DW $0000,$0100,$0051	;cf	(hold [RIGHT] to move)
DW $0000,$00C0,$0013	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004D	;cf	(hold [A] to jump)
DW $0000,$0040,$0013	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T69:	;= Normal jump facing right, aiming upright. Moving optional
;conflict? DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0200,$002F	;cf	(hold [LEFT] to turn left)
DW $0800,$0010,$0015	;cf	(press [UP] & hold [R] to aim up)
DW $0400,$0010,$006B	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0000,$0010,$0069	;cf	(hold [R] to aim upright)
DW $0000,$0900,$0069	;cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006B	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0800,$0015	;cf	(hold [UP] to aim up)
DW $0000,$0400,$0017	;cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0051	;cf	(hold [RIGHT] to move)
DW $0000,$00C0,$0013	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004D	;cf	(hold [A] to jump)
DW $0000,$0040,$0013	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6B:	;= Normal jump facing right, aiming downright. Moving optional
;;;DW $0000,$0420,$0037	;pb	(hold [L+DOWN] to morph)
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
;conflict? DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0900,$0069	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0800,$0010,$0069	;cf	(press [UP] & hold [R] to aim upright)
DW $0000,$0500,$006B	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
;;;DW $0000,$0190,$0069	;pb	(hold [R+(RIGHT+A)] to aim upright)
;;;DW $0000,$01A0,$006B	;pb	(hold [L+(RIGHT+A)] to aim downright)
DW $0000,$0200,$002F	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0010,$006B	;cf	(hold [R] to aim downright)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
;;;DW $0000,$0010,$0069	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
DW $0000,$0100,$0051	;pb/cf	(hold [RIGHT] to move)
DW $0000,$00C0,$0013	;pb/cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004D	;pb/cf	(hold [A] to jump)
DW $0000,$0040,$0013	;pb/cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T16:	;= Normal jump facing left, aiming up
;conflict? DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A10,$0016	;cf	(hold [R+(UP+LEFT)] to aim up)
DW $0000,$0A00,$006A	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0290,$0016	;cf	(hold [R+(LEFT+A)] to jump aiming up)
DW $0000,$0100,$0030	;cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0016	;cf	(hold [UP] to aim up)
DW $0400,$0010,$006A	;cf	(press [DOWN] & hold [R] to aim upleft)
DW $0000,$0010,$0016	;cf	(hold [R] to aim up)
DW $0000,$0600,$006C	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0400,$0018	;cf	(hold [DOWN] to aim down)
DW $0000,$0200,$0052	;cf	(hold [LEFT] to move)
DW $0000,$00C0,$0014	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004E	;cf	(hold [A] to jump)
DW $0000,$0040,$0014	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T4E:	;= Normal jump facing left, gun not extended, not aiming, not moving
T52:	;= Normal jump facing left, moving forward (gun extended)
DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A10,$0016	;cf	(hold [R+(UP+LEFT)] to aim up)
DW $0000,$0A00,$006A	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$006C	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0290,$006A	;cf	(hold [R+(LEFT+A)] to aim upleft)
DW $0000,$0100,$0030	;cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0016	;cf	(hold [UP] to aim up)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0400,$0018	;cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006A	;cf	(hold [R] to aim upleft)
DW $0000,$0200,$0052	;cf	(hold [LEFT] to move)
DW $0000,$00C0,$0014	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004E	;cf	(hold [A] to jump)
DW $0000,$0040,$0014	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6A:	;= Normal jump facing left, aiming upleft. Moving optional
;conflict? DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0100,$0030	;cf	(hold [RIGHT] to turn right)
DW $0800,$0010,$0016	;cf	(press [UP] & hold [R] to aim up)
DW $0400,$0010,$006C	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0000,$0010,$006A	;cf	(hold [R] to aim upleft)
DW $0000,$0A00,$006A	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$006C	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0400,$0018	;cf	(hold [DOWN] to aim down)
DW $0000,$0800,$0016	;cf	(hold [UP] to aim up)
DW $0000,$0200,$0052	;cf	(hold [LEFT] to move)
DW $0000,$00C0,$0014	;cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004E	;cf	(hold [A] to jump)
DW $0000,$0040,$0014	;cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6C:	;= Normal jump facing left, aiming downleft. Moving optional
;;;DW $0000,$0420,$0038	;pb	(hold [L+DOWN] to morph)
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
;conflict? DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A00,$006A	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0800,$0010,$006A	;cf	(press [UP] & hold [R] to aim upleft)
DW $0000,$0600,$006C	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
;;;DW $0000,$0290,$006A	;pb	(hold [R+(LEFT+A)] to aim upleft)
;;;DW $0000,$02A0,$006C	;pb	(hold [L+(LEFT+A)] to aim downleft)
DW $0000,$0100,$0030	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0010,$006C	;cf	(hold [R] to aim downleft)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
;;;DW $0000,$0010,$006A	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downleft)
DW $0000,$0200,$0052	;pb/cf	(hold [LEFT] to move)
DW $0000,$00C0,$0014	;pb/cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$004E	;pb/cf	(hold [A] to jump)
DW $0000,$0040,$0014	;pb/cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T17:	;= Normal jump facing right, aiming down
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
;conflict? DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0400,$0000,$0037	;pb/cf	(press [DOWN] to morph)
DW $0000,$0910,$0015	;cf	(hold [R+(UP+RIGHT)] to aim up)
DW $0000,$0900,$0069	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006B	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0190,$0069	;pb/cf	(hold [R+(RIGHT+A)] to jump aiming upright)
;;;DW $0000,$01A0,$006B	;pb	(hold [L+(RIGHT+A)] to jump aiming downright)
DW $0000,$0200,$002F	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
;;;DW $0000,$0010,$0069	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
DW $0000,$0010,$006B	;cf	(hold [R] to aim downright)
DW $0000,$0100,$0051	;pb/cf	(hold [RIGHT] to move)
DW $0000,$00C0,$0013	;pb/cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$0017	;pb/cf	(hold [A] to jump)
DW $0000,$0040,$0013	;pb/cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T18:	;= Normal jump facing left, aiming down
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
;conflict? DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0400,$0000,$0038	;pb/cf	(press [DOWN] to morph)
DW $0000,$0A10,$0016	;cf	(hold [R+(UP+LEFT)] to aim up)
DW $0000,$0A00,$006A	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$006C	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0290,$006A	;pb/cf	(hold [R+(LEFT+A)] to jump aiming upleft)
;;;DW $0000,$02A0,$006C	;pb	(hold [L+(LEFT+A)] to jump aiming downleft)
DW $0000,$0100,$0030	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
;;;DW $0000,$0010,$006A	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downleft)
DW $0000,$0010,$006C	;cf	(hold [R] to aim downleft)
DW $0000,$0200,$0052	;pb/cf	(hold [LEFT] to move)
DW $0000,$00C0,$0014	;pb/cf	(hold [A+X] to fire while jumping)
DW $0000,$0080,$0018	;pb/cf	(hold [A] to jump)
DW $0000,$0040,$0014	;pb/cf	(hold [X] to fire)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T19:	;= Spin Jump right
DW $0040,$0000,$0013	;pb/cf	(press [X] to fire)
DW $0040,$0400,$0017	;cf	(press [X] & hold [DOWN] to fire aiming down)
DW $0040,$0900,$0069	;cf	(press [X] & hold [UP+RIGHT] to fire aiming upright)
DW $0040,$0500,$006B	;cf	(press [X] & hold [DOWN+RIGHT] to fire aiming downright)
;;;DW $0000,$0840,$0015	;pb	(hold [UP+X] to fire aiming up)
;;;DW $0000,$0440,$0017	;pb	(hold [DOWN+X] to fire aiming down)
DW $0000,$0810,$0015	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
;;;DW $0000,$0050,$0069	;pb	(hold [R+X] to fire aiming upright)
;;;DW $0000,$0060,$006B	;pb	(hold [L+X] to fire aiming downright)
DW $0000,$0180,$0019	;pb	(hold [RIGHT+A] to spinjump)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$0069	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
;not in the original DW $0000,$4400,$0031	;pb	(hold [DOWN+Y] to morph (midair no springball???))
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0019	;pb/cf	(hold [RIGHT] to spinjump)
DW $0000,$0200,$001A	;pb/cf	(hold [LEFT] to spinjump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T1A:	;= Spin Jump left
DW $0040,$0000,$0014	;pb/cf	(press [X] to fire)
DW $0040,$0400,$0018	;cf	(press [X] & hold [DOWN] to fire aiming down)
DW $0040,$0A00,$006A	;cf	(press [X] & hold [UP+LEFT] to fire aiming upleft)
DW $0040,$0600,$006C	;cf	(press [X] & hold [DOWN+LEFT] to fire aiming downleft)
;;;DW $0000,$0840,$0016	;pb	(hold [UP+X] to fire aiming up)
;;;DW $0000,$0440,$0018	;pb	(hold [DOWN+X] to fire aiming down)
;;;DW $0000,$0050,$006A	;pb	(hold [R+X] to fire aiming upleft)
;;;DW $0000,$0060,$006C	;pb	(hold [L+X] to fire aiming downleft)
DW $0000,$0280,$001A	;pb	(hold [LEFT+A] to spinjump)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$006A	;pb/cf	(hold [R] to aim upleft)
DW $0000,$0810,$0016	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downleft)
; not in the original DW $0000,$4400,$0032	;pb	(hold [DOWN+Y] to morph (midair no springball???))
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0200,$001A	;pb/cf	(hold [LEFT] to spinjump)
DW $0000,$0100,$0019	;pb/cf	(hold [RIGHT] to spinjump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T1B:	;= Space jump right
DW $0040,$0000,$0013	;pb/cf	(press [X] to fire)
DW $0040,$0900,$0069	;cf	(press [X] & hold [UP+RIGHT] to fire aiming upright)
DW $0040,$0500,$006B	;cf	(press [X] & hold [DOWN+RIGHT] to fire aiming downright)
DW $0040,$0400,$0017	;cf	(press [X] & hold [DOWN] to fire aiming down)
;;;DW $0000,$0840,$0015	;pb	(hold [UP+X] to fire aiming up)
;;;DW $0000,$0440,$0017	;pb	(hold [DOWN+X] to fire aiming down)
;not in the original DW $0000,$4400,$0031	;pb	(hold [DOWN+Y] to morph (midair no springball???))
;;;DW $0000,$0050,$0069	;pb	(hold [R+X] to fire aiming upright)
;;;DW $0000,$0060,$006B	;pb	(hold [L+X] to fire aiming downright)
DW $0000,$0180,$001B	;pb	(hold [RIGHT+A] to space jump)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$0069	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$001B	;pb/cf	(hold [RIGHT] to space jump)
DW $0000,$0200,$001C	;pb/cf	(hold [LEFT] to space jump)
DW $0000,$0810,$0015	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T1C:	;= Space jump left
DW $0040,$0000,$0014	;pb/cf	(press [X] to fire)
DW $0040,$0A00,$006A	;cf	(press [X] & hold [UP+LEFT] to fire aiming upleft)
DW $0040,$0600,$006C	;cf	(press [X] & hold [DOWN+LEFT] to fire aiming downleft)
DW $0040,$0400,$0018	;cf	(press [X] & hold [DOWN] to fire aiming down)
;;;DW $0000,$0840,$0016	;pb	(hold [UP+X] to fire aiming up)
;;;DW $0000,$0440,$0018	;pb	(hold [DOWN+X] to fire aiming down)
;not in the originalDW $0000,$4400,$0032	;pb	(hold [DOWN+Y] to morph (midair no springball???))
;;;DW $0000,$0050,$006A	;pb	(hold [R+X] to fire aiming upleft)
;;;DW $0000,$0060,$006C	;pb	(hold [L+X] to fire aiming downleft)
DW $0000,$0280,$001C	;pb	(hold [LEFT+A] to space jump)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$006A	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downleft)
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0200,$001C	;pb/cf	(hold [LEFT] to space jump)
DW $0000,$0100,$001B	;pb/cf	(hold [RIGHT] to space jump)
DW $0000,$0810,$0016	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T1D:	;= Facing right as morphball, no springball
T1E:	;= Moving right as a morphball on ground without springball
DW $0800,$0000,$003D	;pb/cf	(press [UP] to demorph)
;DW $0080,$8000,$0019	;pb	(press [A] & hold [B] to spinjump) ;might want to disable for auto-run
DW $0080,$0000,$003D	;pb/cf	(press [A] to demorph)
T1F:	;= Moving left as a morphball on ground without springball
T41:	;= Staying still with morphball, facing left, no springball
DW $0800,$0000,$003E	;pb/cf	(press [UP] to demorph)
;DW $0080,$8000,$001A	;pb	(press [A] & hold [B] to spinjump) ;might want to disable for auto-run
DW $0080,$0000,$003E	;pb/cf	(press [A] to demorph)
DW $0000,$0100,$001E	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$001F	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T20:	;= Spinjump right. Unused?
T21:	;= Spinjump right. Unused?
T22:	;= Spinjump right. Unused?
T23:	;= Spinjump right. Unused?
T24:	;= Spinjump right. Unused?
T2F:	;= Starting with normal jump facing right, turning left
;DW $0000,$0280,$0050	;pb	(hold [LEFT+A] to roll back)
;DW $FFFF
T30:	;= Starting with normal jump facing left, turning right
;DW $0000,$0180,$004F	;pb	(hold [RIGHT+A] to roll back)
;DW $FFFF
;-------------------------------------------------------------------------------------------------------
T33:	;= Spinjump right. Unused?
T34:	;= Spinjump right. Unused?
T35:	;= Crouch transition, facing right
T36:	;= Crouch transition, facing left
T37:	;= Morphing into ball, facing right. Ground and mid-air
T38:	;= Morphing into ball, facing left. Ground and mid-air
T39:	;= Midair morphing into ball, facing right?
T3A:	;= Midair morphing into ball, facing left?
T3B:	;= Standing from crouching, facing right
T3C:	;= Standing from crouching, facing left
T3D:	;= Demorph while facing right. Mid-air and on ground
T3E:	;= Demorph while facing left. Mid-air and on ground
T3F:	;= Some transition with morphball, facing right.
T40:	;= Some transition with morphball, facing left.
T42:	;= Spinjump right. Unused?
T43:	;= Starting from crouching right, turning left
T44:	;= Starting from crouching left, turning right
T47:	;= Standing, facing right. Unused?
T48:	;= Standing, facing left. Unused?
T4B:	;= Normal jump transition from ground (standing or crouching), facing right
;DW $0000,$0280,$0050	;pb	(hold [LEFT+A] to roll back)
;DW $FFFF
T4C:	;= Normal jump transition from ground (standing or crouching), facing left
;DW $0000,$0180,$004F	;pb	(hold [RIGHT+A] to roll back)
;DW $FFFF
;-------------------------------------------------------------------------------------------------------
T55:	;= Normal jump transition from ground, facing right and aiming up
T56:	;= Normal jump transition from ground, facing left and aiming up
T57:	;= Normal jump transition from ground, facing right and aiming upright
T58:	;= Normal jump transition from ground, facing left and aiming upleft
T59:	;= Normal jump transition from ground, facing right and aiming downright
T5A:	;= Normal jump transition from ground, facing left and aiming downleft
T5B:	;= Something for grapple (wall jump?), probably unused
T5C:	;= Something for grapple (wall jump?), probably unused
T5D:	;= Broken grapple? Facing clockwise, maybe unused
T5E:	;= Broken grapple? Facing clockwise, maybe unused
T5F:	;= Broken grapple? Facing clockwise, maybe unused
T60:	;= Better broken grapple. Facing clockwise, maybe unused
T61:	;= Nearly normal grapple. Facing clockwise, maybe unused
T62:	;= Nearly normal grapple. Facing counterclockwise, maybe unused
T63:	;= Facing left on grapple blocks, ready to jump. Unused?
T64:	;= Facing right on grapple blocks, ready to jump. Unused?
T65:	;= Glitchy jump, facing left. Used by unused grapple jump?
T66:	;= Glitchy jump, facing right. Used by unused grapple jump?
T87:	;= Turning from right to left while falling
T88:	;= Turning from left to right while falling
T8F:	;= Turning around from right to left while aiming straight up in midair
T90:	;= Turning around from left to right while aiming straight up in midair
T91:	;= Turning around from right to left while aiming down or diagonal down in midair
T92:	;= Turning around from left to right while aiming down or diagonal down in midair
T93:	;= Turning around from right to left while aiming straight up while falling
T94:	;= Turning around from left to right while aiming straight up while falling
T95:	;= Turning around from right to left while aiming down or diagonal down while falling
T96:	;= Turning around from left to right while aiming down or diagonal down while falling
T97:	;= Turning around from right to left while aiming straight up while crouching
T98:	;= Turning around from left to right while aiming straight up while crouching
T99:	;= Turning around from right to left while aiming diagonal down while crouching
T9A:	;= Turning around from left to right while aiming diagonal down while crouching
T9C:	;= Turning around from right to left while aiming diagonal up while standing
T9D:	;= Turning around from left to right while aiming diagonal up while standing
T9E:	;= Turning around from right to left while aiming diagonal up in midair
T9F:	;= Turning around from left to right while aiming diagonal up in midair
TA0:	;= Turning around from right to left while aiming diagonal up while falling
TA1:	;= Turning around from left to right while aiming diagonal up while falling
TA2:	;= Turn around from right to left while aiming diagonal up while crouching
TA3:	;= Turn around from left to right while aiming diagonal up while crouching
TA8:	;= Just standing, facing right. Unused? (Grapple movement)
TA9:	;= Just standing, facing left. Unused? (Grapple movement)
TAA:	;= Just standing, facing right aiming downright. Unused? (Grapple movement)
TAB:	;= Just standing, facing left aiming downleft. Unused? (Grapple movement)
TAC:	;= Jumping, facing right, gun extended. Unused? (Grapple movement)
TAD:	;= Jumping, facing left, gun extended. Unused? (Grapple movement)
TAE:	;= Jumping, facing right, aiming down. Unused? (Grapple movement)
TAF:	;= Jumping, facing left, aiming down. Unused? (Grapple movement)
TB0:	;= Jumping, facing right, aiming downright. Unused? (Grapple movement)
TB1:	;= Jumping, facing left, aiming downleft. Unused? (Grapple movement)
TB2:	;= Grapple, facing clockwise
TB3:	;= Grapple, facing counterclockwise
TB4:	;= Crouching, facing right. Unused? (Grapple movement)
TB5:	;= Crouching, facing left. Unused? (Grapple movement)
TB6:	;= Crouching, facing right, aiming downright. Unused? (Grapple movement)
TB7:	;= Crouching, facing left, aiming downleft. Unused? (Grapple movement)
TB8:	;= Grapple, attached to a wall on right, facing left
TB9:	;= Grapple, attached to a wall on left, facing right
TC5:	;= Morph ball, facing right. Unused? (Grabbed by Draygon movement)
TC6:	;= Morph ball, facing left. Unused? (Grabbed by Draygon movement)
TC9:	;= Horizontal super jump, right
TCA:	;= Horizontal super jump, left
TCB:	;= Vertical super jump, facing right
TCC:	;= Vertical super jump, facing left
TCD:	;= Diagonal super jump, right
TCE:	;= Diagonal super jump, left
TD3:	;= Crystal flash, facing right
TD4:	;= Crystal flash, facing left
TD5:	;= X-raying right, standing
TD6:	;= X-raying left, standing
TD7:	;= Crystal flash ending, facing right
TD8:	;= Crystal flash ending, facing left
TD9:	;= X-raying right, crouching
TDA:	;= X-raying left, crouching
TDB:	;= Standing transition to morphball, facing right? Unused?
TDC:	;= Standing transition to morphball, facing left? Unused?
TDD:	;= Morphball transition to standing, facing right? Unused?
TDE:	;= Morphball transition to standing, facing left? Unused?
TE8:	;= Samus exhausted(Metroid drain, MB attack), facing right
TE9:	;= Samus exhausted(Metroid drain, MB attack), facing left
TEA:	;= Samus exhausted, looking up to watch Metroid attack MB, facing right
TEB:	;= Samus exhausted, looking up to watch Metroid attack MB, facing left
TF1:	;= Crouch transition, facing right and aiming up
TF2:	;= Crouch transition, facing left and aiming up
TF3:	;= Crouch transition, facing right and aiming upright
TF4:	;= Crouch transition, facing left and aiming upleft
TF5:	;= Crouch transition, facing right and aiming downright
TF6:	;= Crouch transition, facing left and aiming downleft
TF7:	;= Crouching to standing, facing right and aiming up
TF8:	;= Crouching to standing, facing left and aiming up
TF9:	;= Crouching to standing, facing right and aiming upright
TFA:	;= Crouching to standing, facing left and aiming upleft
TFB:	;= Crouching to standing, facing right and aiming downright
TFC:	;= Crouching to standing, facing left and aiming downleft
T49:	;= Moonwalk, facing left
T75:	;= Moonwalk, facing left aiming upleft
T77:	;= Moonwalk, facing left aiming downleft
;;;DW $0400,$0000,$0036	;pb	(press [DOWN] to crouch)
;;;DW $0080,$0000,$00C0	;pb	(press [A] to turn right)
;;;DW $0000,$0160,$0077	;pb	(hold [R+(RIGHT+X)] to aim upleft)
;;;DW $0000,$0150,$0075	;pb	(hold [L+(RIGHT+X)] to aim downleft)
;;;DW $0000,$0140,$0049	;pb	(hold [RIGHT+X] to moonwalk)
;;;DW $0000,$0200,$000A	;pb	(hold [LEFT] to move left)
;;;DW $0000,$0100,$0026	;pb	(hold [RIGHT] to turn right)
;;;DW $FFFF
T4A:	;= Moonwalk, facing right
T76:	;= Moonwalk, facing right aiming upright
T78:	;= Moonwalk, facing right aiming downright
;;;DW $0400,$0000,$0035	;pb	(press [DOWN] to crouch)
;;;DW $0080,$0000,$00BF	;pb	(press [A] to turn left)
;;;DW $0000,$0250,$0076	;pb	(hold [R+(LEFT+X)] to aim upright)
;;;DW $0000,$0260,$0078	;pb	(hold [L+(LEFT+X)] to aim downright)
;;;DW $0000,$0240,$004A	;pb	(hold [LEFT+X] to moonwalk)
;;;DW $0000,$0100,$0009	;pb	(hold [RIGHT] to move right)
;;;DW $0000,$0200,$0025	;pb	(hold [LEFT] to turn left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T25:	;= Starting standing right, turning left
DW $0000,$0280,$001A	;pb	(hold [LEFT+A] to spinjump)
DW $0080,$0000,$004C	;pb/cf	(press [A] to jump)
DW $0000,$0200,$0025	;pb/cf	(hold [LEFT] to turn left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T26:	;= Starting standing left, turning right
DW $0000,$0180,$0019	;pb	(hold [RIGHT+A] to spinjump)
DW $0080,$0000,$004B	;pb/cf	(press [A] to jump)
DW $0000,$0100,$0026	;pb/cf	(hold [RIGHT] to turn right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T27:	;= Crouching, facing right
DW $0800,$0010,$0085	;cf	(press [UP] & hold [R] to aim up)
DW $0800,$0000,$003B	;cf	(press [UP] to stand)
DW $0200,$0000,$0043	;cf	(press [LEFT] to turn left)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0000,$0410,$0073	;cf	(hold [R+DOWN] to aim downright)
DW $0400,$0000,$0037	;cf	(press [DOWN] to morph)
DW $0000,$0110,$0005	;cf	(hold [R+RIGHT] to aim upright)
DW $0000,$0100,$0001	;cf	(hold [RIGHT] to move)
DW $0000,$0010,$0071	;cf	(hold [R] to aim upright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T71:	;= Standing to crouching, facing right and aiming upright
DW $0800,$0010,$0085	;cf	(press [UP] & hold [R] to aim up)
DW $0800,$0000,$003B	;cf	(press [UP] to stand)
DW $0200,$0000,$0043	;cf	(press [LEFT] to turn left)
DW $0080,$0000,$0057	;cf	(press [A] to jump)
DW $0400,$0010,$0073	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0400,$0000,$0037	;cf	(press [DOWN] to morph)
DW $0000,$0110,$0005	;cf	(hold [R+RIGHT] to aim upright)
DW $0000,$0100,$0001	;cf	(hold [RIGHT] to move)
DW $0000,$0010,$0071	;cf	(hold [R] to aim upright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T73:	;= Standing to crouching, facing right and aiming downright
DW $0800,$0010,$0071	;cf	(press [UP] & hold [R] to aim upright)
DW $0800,$0000,$003B	;cf	(press [UP] to stand)
DW $0200,$0000,$0043	;cf	(press [LEFT] to turn left)
DW $0080,$0000,$004B	;cf	(press [A] to jump)
DW $0400,$0000,$0037	;cf	(press [DOWN] to morph)
DW $0000,$0110,$0007	;cf	(hold [R+RIGHT] to aim downright)
DW $0000,$0100,$0001	;cf	(hold [RIGHT] to move)
DW $0000,$0010,$0073	;cf	(hold [R] to aim downright)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T85:	;= Crouching, facing right aiming up
;;;DW $0800,$0030,$00F7	;pb	(press [UP] & hold [L+R] to stand aiming up)
DW $0800,$0000,$00F7	;cf	(press [UP] to stand aiming up)
;;;DW $0800,$0010,$00F9	;pb	(press [UP] & hold [R] to stand aiming upright)
;;;DW $0800,$0020,$00FB	;pb	(press [UP] & hold [L] to stand aiming downright)
;;;DW $0800,$0000,$003B	;pb	(press [UP] to stand)
DW $0200,$0000,$0043	;pb/cf	(press [LEFT] to turn left)
DW $0400,$0010,$0071	;cf	(press [DOWN] & hold [R] to aim upright)
DW $0400,$0000,$0037	;pb/cf	(press [DOWN] to morph)
DW $0000,$8080,$0050	;pb	(hold [B+A] to roll back)
DW $0080,$0000,$004B	;pb/cf	(press [A] to jump)
;;;DW $0000,$0030,$0085	;pb	(hold [L+R] to aim up)
DW $0000,$0110,$0003	;cf	(hold [R+RIGHT] to aim up)
DW $0000,$0100,$0001	;pb/cf	(hold [RIGHT] to move)
;;;DW $0000,$0010,$0071	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$0073	;pb	(hold [L] to aim downright)
DW $0000,$0010,$0085	;cf	(hold [R] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T28:	;= Crouching, facing left
DW $0800,$0010,$0086	;cf	(press [UP] & hold [R] to aim up)
DW $0800,$0000,$003C	;cf	(press [UP] to stand)
DW $0100,$0000,$0044	;cf	(press [RIGHT] to turn right)
DW $0080,$0000,$004C	;cf	(press [A] to jump)
DW $0000,$0410,$0074	;cf	(hold [R+DOWN] to aim downleft)
DW $0400,$0000,$0038	;cf	(press [DOWN] to morph)
DW $0000,$0210,$0006	;cf	(hold [R+LEFT] to aim upleft)
DW $0000,$0200,$0002	;cf	(hold [LEFT] to move)
DW $0000,$0010,$0072	;cf	(hold [R] to aim upleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T72:	;= Standing to crouching, facing left and aiming upleft
DW $0800,$0010,$0086	;cf	(press [UP] & hold [R] to aim up)
DW $0800,$0000,$003C	;cf	(press [UP] to stand)
DW $0100,$0000,$0044	;cf	(press [RIGHT] to turn right)
DW $0080,$0000,$0058	;cf	(press [A] to jump)
DW $0400,$0010,$0074	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0400,$0000,$0038	;cf	(press [DOWN] to morph)
DW $0000,$0210,$0006	;cf	(hold [R+LEFT] to aim upleft)
DW $0000,$0200,$0002	;cf	(hold [LEFT] to move)
DW $0000,$0010,$0072	;cf	(hold [R] to aim upleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T74:	;= Standing to crouching, facing left and aiming downleft
DW $0800,$0010,$0072	;cf	(press [UP] & hold [R] to aim upleft)
DW $0800,$0000,$003C	;cf	(press [UP] to stand)
DW $0100,$0000,$0044	;cf	(press [RIGHT] to turn right)
DW $0080,$0000,$004C	;cf	(press [A] to jump)
DW $0400,$0000,$0038	;cf	(press [DOWN] to morph)
DW $0000,$0210,$0008	;cf	(hold [R+LEFT] to aim downleft)
DW $0000,$0200,$0002	;cf	(hold [LEFT] to move)
DW $0000,$0010,$0074	;cf	(hold [R] to aim downleft)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T86:	;= Crouching, facing left aiming up
;;;DW $0800,$0030,$00F8	;pb	(press [UP] & hold [L+R] to stand aiming up)
DW $0800,$0000,$00F8	;cf	(press [UP] to stand aiming up)
;;;DW $0800,$0010,$00FA	;pb	(press [UP] & hold [R] to stand aiming upleft)
;;;DW $0800,$0020,$00FC	;pb	(press [UP] & hold [L] to stand aiming downleft)
;;;DW $0800,$0000,$003C	;pb	(press [UP] to stand)
DW $0100,$0000,$0044	;pb/cf	(press [RIGHT] to turn right)
DW $0400,$0010,$0072	;cf	(press [DOWN] & hold [R] to stand aiming upleft)
DW $0400,$0000,$0038	;pb/cf	(press [DOWN] to morph)
DW $0000,$8080,$004F	;pb	(hold [B+A] to roll back)
DW $0080,$0000,$004C	;pb/cf	(press [A] to jump)
;;;DW $0000,$0030,$0086	;pb	(hold [L+R] to aim up)
DW $0000,$0210,$0004	;cf	(hold [R+LEFT] to aim up)
DW $0000,$0200,$0002	;pb/cf	(hold [LEFT] to move)
;;;DW $0000,$0010,$0072	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0074	;pb	(hold [L] to aim downleft)
DW $0000,$0010,$0086	;cf	(hold [R] to aim up)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T2D:	;= Falling facing right, aiming down
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0400,$0000,$0037	;pb/cf	(press [DOWN] to morph)
DW $0000,$0810,$002B	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$006F	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0010,$006F	;cf	(hold [R] to aim downright)
DW $0000,$0900,$006D	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006F	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0800,$002B	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002D	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0200,$0087	;pb/cf	(hold [LEFT] to turn left)
;;;DW $0000,$0010,$006D	;pb	(hold [R] to aim upright)
;;;DW $0000,$0020,$006F	;pb	(hold [L] to aim downright)
DW $0000,$0040,$0067	;pb/cf	(hold [X] to fire)
DW $0000,$0100,$0029	;pb/cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T29:	;= Falling facing right, normal pose
DW $0080,$0000,$0019
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0200,$0087	;cf	(hold [LEFT] to turn left)
DW $0000,$0810,$002B	;cf	(hold [R+UP] to aim up)
DW $0000,$0900,$006D	;cf	(hold [UP+LEFT] to aim upright)
DW $0000,$0500,$006F	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0800,$002B	;cf	(hold [UP] to aim up)
DW $0000,$0410,$006F	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0400,$002D	;cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006D	;cf	(hold [R] to aim upright)
DW $0000,$0040,$0067	;cf	(hold [X] to fire)
DW $0000,$0100,$0029	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6D:	;= Falling facing right, aiming upright
DW $0080,$0000,$0019
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0200,$0087	;cf	(hold [LEFT] to turn left)
DW $0800,$0010,$002B	;cf	(press [UP] & hold [R] to aim up)
DW $0400,$0010,$006F	;cf	(press [DOWN] & hold [R] to aim downright)
DW $0000,$0010,$006D	;cf	(hold [R] to aim upright)
DW $0000,$0900,$006D	;cf	(hold [UP+LEFT] to aim upright)
DW $0000,$0500,$006F	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0800,$002B	;cf	(hold [UP] to aim up)
DW $0000,$0400,$002D	;cf	(hold [DOWN] to aim down)
DW $0000,$0040,$0067	;cf	(hold [X] to fire)
DW $0000,$0100,$0029	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T2B:	;= Falling facing right, aiming up
DW $0080,$0000,$0019
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0200,$0087	;cf	(hold [LEFT] to turn left)
DW $0400,$0010,$006D	;cf	(press [DOWN] & hold [R] to aim upright)
DW $0000,$0010,$002B	;cf	(hold [R] to aim up)
DW $0000,$0900,$006D	;cf	(hold [UP+LEFT] to aim upright)
DW $0000,$0500,$006F	;cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0800,$002B	;cf	(hold [UP] to aim up)	
DW $0000,$0400,$002D	;cf	(hold [DOWN] to aim down)
DW $0000,$0040,$0067	;cf	(hold [X] to fire)
DW $0000,$0100,$0029	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6F:	;= Falling facing right, aiming downright
;;;DW $0000,$0420,$0037	;pb	(hold [L+DOWN] to morph)
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$0019	;pb	(hold [A] to spinjump)
DW $0000,$0900,$006D	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006F	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0200,$0087	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0800,$002B	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002D	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006D	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006F	;pb	(hold [L] to aim downright)
DW $0000,$0010,$006F	;cf	(hold [R] to aim downright)
DW $0000,$0040,$0067	;pb/cf	(hold [X] to fire)
DW $0000,$0080,$0019	;pb	(hold [A] to spinjump)
;;;DW $0000,$8100,$0029	;pb	(hold [RIGHT+B] to move right)
DW $0000,$0100,$0029	;cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T2E:	;= Falling facing left, aiming down
DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0400,$0000,$0038	;pb/cf	(press [DOWN] to morph)
DW $0000,$0810,$002C	;cf	(hold [R+UP] to aim up)
DW $0000,$0410,$0070	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0010,$0070	;cf	(hold [R] to aim downleft)
DW $0000,$0A00,$006E	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$0070	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0800,$002C	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002E	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0088	;pb/cf	(hold [RIGHT] to turn right)
;;;DW $0000,$0010,$006E	;pb	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0070	;pb	(hold [L] to aim downleft)
DW $0000,$0040,$0068	;pb/cf	(hold [X] to fire)
DW $0000,$0200,$002A	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T2A:	;= Falling facing left, normal pose
DW $0080,$0000,$001A
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0100,$0088	;cf	(hold [RIGHT] to turn right)
DW $0000,$0810,$002C	;cf	(hold [R+UP] to aim up)
DW $0000,$0A00,$006E	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$0070	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0800,$002C	;cf	(hold [UP] to aim up)
DW $0000,$0410,$0070	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0400,$002E	;cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006E	;cf	(hold [R] to aim downright)
DW $0000,$0040,$0068	;cf	(hold [X] to fire)
DW $0000,$0200,$002A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T6E:	;= Falling facing left, aiming upleft
DW $0080,$0000,$001A
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0100,$0088	;cf	(hold [RIGHT] to turn right)
DW $0800,$0010,$002C	;cf	(press [UP] & hold [R] to aim up)
DW $0400,$0010,$0070	;cf	(press [DOWN] & hold [R] to aim downleft)
DW $0000,$0010,$006E	;cf	(hold [R] to aim upleft)
DW $0000,$0A00,$006E	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0800,$002C	;cf	(hold [UP] to aim up)
DW $0000,$0600,$0070	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0400,$002E	;cf	(hold [DOWN] to aim down)
DW $0000,$0040,$0068	;cf	(hold [X] to fire)
DW $0000,$0200,$002A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T2C:	;= Falling facing left, aiming up
DW $0080,$0000,$001A
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0000,$0100,$0088	;cf	(hold [RIGHT] to turn right)
DW $0000,$0010,$002C	;cf	(hold [R] to aim up)
DW $0400,$0010,$006E	;cf	(press [DOWN] & hold [R] to aim upleft)
DW $0000,$0A00,$006E	;cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0800,$002C	;cf	(hold [UP] to aim up)
DW $0000,$0600,$0070	;cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0400,$002E	;cf	(hold [DOWN] to aim down)
DW $0000,$0040,$0068	;cf	(hold [X] to fire)
DW $0000,$0200,$002A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T70:	;= Falling facing left, aiming downleft
;;;DW $0000,$0420,$0038	;pb	(hold [L+DOWN] to morph)
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0800,$0010,$006E	;cf	(press [UP] & hold [R] to aim upleft)
DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A00,$006E	;pb/cf	(hold [UP+LEFT] to aim upleft)
DW $0000,$0600,$0070	;pb/cf	(hold [DOWN+LEFT] to aim downleft)
DW $0000,$0100,$0088	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0800,$002C	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002E	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0010,$006E	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$0070	;pb	(hold [L] to aim downleft)
DW $0000,$0010,$0070	;cf	(hold [R] to aim downleft)
DW $0000,$0040,$0068	;pb/cf	(hold [X] to fire)
DW $0000,$0080,$001A	;pb	(hold [A] to spinjump)
;;;DW $0000,$8200,$002A	;pb	(hold [LEFT+B] to move left)
DW $0000,$0200,$002A	;cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T31:	;= Midair morphball facing right without springball
DW $0800,$0000,$003D	;pb/cf	(press [UP] to demorph)
DW $0080,$0000,$003D	;pb/cf	(press [A] to demorph)
T32:	;= Midair morphball facing left without springball
DW $0800,$0000,$003E	;pb/cf	(press [UP] to demorph)
DW $0080,$0000,$003E	;pb/cf	(press [A] to demorph)
DW $0000,$0100,$0031	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0032	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T45:	;= Running, facing right, shooting left. Unused? (Fast moonwalk)
DW $0000,$0240,$0045	;pb/cf	(hold [LEFT+X] to fast moonwalk)
DW $0000,$0100,$0009	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0025	;pb/cf	(hold [LEFT] to turn left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T46:	;= Running, facing left, shooting right. Unused? (Fast moonwalk)
DW $0000,$0140,$0046	;pb/cf	(hold [RIGHT+X] to fast moonwalk)
DW $0000,$0200,$000A	;pb/cf	(hold [LEFT] to move left)
DW $0000,$0100,$0026	;pb/cf	(hold [RIGHT] to turn right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T4F:	;= Hurt roll back, moving right/facing left
;;;DW $0000,$0080,$004F	;pb	(hold [A] to roll back)
DW $0000,$0180,$004F	;cf	(hold [RIGHT+A] to roll back)
DW $0000,$0280,$0052	;pb/cf	(hold [LEFT+A] to jump w/gun extended)
DW $0000,$0080,$004E	;pb/cf	(hold [A] to jump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T50:	;= Hurt roll back, moving left/facing right
;;;DW $0000,$0080,$0050	;pb	(hold [A] to roll back)
DW $0000,$0280,$0050	;cf	(hold [LEFT+A] to roll back)
DW $0000,$0180,$0051	;pb/cf	(hold [RIGHT+A] to jump w/gun extended)
DW $0000,$0080,$004D	;pb/cf	(hold [A] to jump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T53:	;= Hurt, facing right
DW $0000,$0280,$0050	;pb/cf	(hold [LEFT+A] to roll back)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T54:	;= Hurt, facing left
DW $0000,$0180,$004F	;pb/cf	(hold [RIGHT+A] to roll back)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T67:	;= Facing right, falling, fired a shot
DW $0000,$4400,$0037	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$0019	;pb	(press [A] to spinjump)
DW $0000,$0900,$006D	;pb/cf	(hold [UP+RIGHT] to aim upright)
DW $0000,$0500,$006F	;pb/cf	(hold [DOWN+RIGHT] to aim downright)
DW $0000,$0410,$006F	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0800,$002B	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002D	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0200,$0087	;pb/cf	(hold [LEFT] to turn left)
DW $0000,$0010,$006D	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006F	;pb	(hold [L] to aim downright)
DW $0000,$0040,$0067	;pb/cf	(hold [X] to fire)
DW $0000,$0100,$0067	;pb/cf	(hold [RIGHT] to move right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T68:	;= Facing left, falling, fired a shot
DW $0000,$4400,$0038	;pb	(hold [DOWN+Y] to morph)
DW $0080,$0000,$001A	;pb	(press [A] to spinjump)
DW $0000,$0A00,$006E	;pb/cf	(hold [UP+LEFT) to aim upleft)
DW $0000,$0600,$0070	;pb/cf	(hold [DOWN+LEFT) to aim downleft)
DW $0000,$0410,$0070	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0800,$002C	;pb/cf	(hold [UP] to aim up)
DW $0000,$0400,$002E	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0088	;pb/cf	(hold [RIGHT] to turn right)
DW $0000,$0010,$006E	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$0070	;pb	(hold [L] to aim downright)
DW $0000,$0040,$0068	;pb/cf	(hold [X] to fire)
DW $0000,$0200,$0068	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T79:	;= Spring ball on ground, facing right
T7B:	;= Spring ball on ground, moving right
DW $0800,$0000,$003D	;pb/cf	(press [UP] to demorph)
DW $0080,$0000,$007F	;pb/cf	(press [A] to jump)
T7A:	;= Spring ball on ground, facing left
T7C:	;= Spring ball on ground, moving left
DW $0800,$0000,$003E	;pb/cf	(press [UP] to demorph)
DW $0080,$0000,$0080	;pb/cf	(press [A] to jump)
DW $0000,$0100,$007B	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$007C	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T7D:	;= Spring ball falling, facing/moving right
DW $0800,$0000,$003D	;pb/cf (press [UP] to demorph)
T7E:	;= Spring ball falling, facing/moving left
DW $0800,$0000,$003E	;pb/cf	(press [UP] to demorph)
DW $0000,$0100,$007D	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$007E	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T7F:	;= Spring ball jump in air, facing/moving right
DW $0800,$0000,$003D	;pb/cf	(press [UP] to demorph)
T80:	;= Spring ball jump in air, facing/moving left
DW $0800,$0000,$003E	;pb/cf	(press [UP] to demorph)
DW $0000,$0100,$007F	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0080	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T81:	;= Screw attack right
DW $0040,$0000,$0013	;pb/cf	(press [X] to extend gun)
DW $0040,$0900,$0069	;cf	(press [X] & hold [UP+RIGHT] to aim upright)
DW $0040,$0500,$006B	;cf	(press [X] & hold [DOWN+RIGHT] to aim downright)
DW $0040,$0400,$0017	;cf	(press [X] & hold [DOWN] to aim down)
;;;DW $0000,$0840,$0015	;pb	(hold [UP+X] to aim up)
DW $0000,$0810,$0015	;cf	(hold [R+UP] to aim up)
;;;DW $0000,$0440,$0017	;pb	(hold [DOWN+X] to fire aiming down)
;not in the original DW $0000,$4400,$0031	;pb	(hold [DOWN+Y] to morph)
;;;DW $0000,$0050,$0069	;pb	(hold [R+X] to aim upright)
;;;DW $0000,$0060,$006B	;pb	(hold [L+X] to aim downright)
DW $0000,$0180,$0081	;pb	(hold [RIGHT+A] to screw attack)
DW $0000,$0800,$0015	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$0069	;pb/cf	(hold [R] to aim upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to aim downright)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0400,$0017	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0081	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0082	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T82:	;= Screw attack left
DW $0040,$0000,$0014	;pb/cf	(press [X] to extend gun)
DW $0040,$0A00,$006A	;cf	(press [X] & hold [UP+LEFT] to aim upleft)
DW $0040,$0600,$006C	;cf	(press [X] & hold [DOWN+LEFT] to aim downleft)
DW $0040,$0400,$0018	;cf	(press [X] & hold [DOWN] to aim down)
;;;DW $0000,$0840,$0016	;pb	(hold [UP+X] to aim up)
DW $0000,$0810,$0016	;cf	(hold [R+UP] to aim up)
;;;DW $0000,$0440,$0018	;pb	(hold [DOWN+X] to fire aiming down)
;not in the original DW $0000,$4400,$0032	;pb	(hold [DOWN+Y] to morph)
;;;DW $0000,$0050,$006A	;pb	(hold [R+X] to aim upleft)
;;;DW $0000,$0060,$006C	;pb	(hold [L+X] to aim downleft)
DW $0000,$0280,$0082	;pb	(hold [LEFT+A] to screw attack)
DW $0000,$0800,$0016	;pb/cf	(hold [UP] to aim up)
DW $0000,$0010,$006A	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to aim downleft)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0400,$0018	;pb/cf	(hold [DOWN] to aim down)
DW $0000,$0100,$0081	;pb/cf	(hold [RIGHT] to move right)
DW $0000,$0200,$0082	;pb/cf	(hold [LEFT] to move left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T83:	;= Walljump right
DW $0400,$0000,$0037	;pb/cf	(press [DOWN] to morph facing right)
;;;DW $0400,$0000,$0019	;pb	(press [DOWN] to spinjump right)
DW $0000,$0200,$001A	;pb/cf	(hold [LEFT] to spinjump left)
DW $0000,$0810,$0015	;cf	(hold [R+UP] to jump right aiming up)
DW $0000,$0010,$0069	;pb/cf	(hold [R] to jump right aiming upright)
;;;DW $0000,$0020,$006B	;pb	(hold [L] to jump right aiming downright)
DW $0000,$0410,$006B	;cf	(hold [R+DOWN] to jump right aiming downright)
DW $0000,$0040,$0013	;pb/cf	(hold [X] to jump right)
DW $0000,$0080,$0083	;pb/cf	(hold [A] to walljump right)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T84:	;= Walljump left
DW $0400,$0000,$0038	;pb/cf	(press [DOWN] to morph facing left)
;;;DW $0400,$0000,$001A	;pb	(press [DOWN] to spinjump left)
DW $0000,$0100,$0019	;pb/cf	(hold [RIGHT] to spinjump right)
DW $0000,$0810,$0016	;cf	(hold [R+UP] to jump left aiming up)
DW $0000,$0010,$006A	;pb/cf	(hold [R] to jump left aiming upleft)
;;;DW $0000,$0020,$006C	;pb	(hold [L] to jump left aiming downleft)
DW $0000,$0410,$006C	;cf	(hold [R+DOWN] to jump left aiming downleft)
DW $0000,$0040,$0014	;pb/cf	(hold [X] to jump left)
DW $0000,$0080,$0084	;pb/cf	(hold [A] to walljump left)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T8B:	;= Turning around from right to left while aiming straight up while standing
T8D:	;= Turn around from right to left while aiming diagonal down while standing
TBF:	;= Jump/Turn right to left while moonwalking.
TC1:	;= Jump/Turn right to left while moonwalking and aiming diagonal up.
TC3:	;= Jump/Turn right to left while moonwalking and aiming diagonal down.
DW $0080,$0200,$001A	;pb/cf	(press [A] & hold [LEFT] to spinjump)
DW $0080,$0000,$004C	;pb/cf	(press [A] to jump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
T8C:	;= Turning around from left to right while aiming straight up while standing
T8E:	;= Turn around from left to right while aiming diagonal down while standing
TC0:	;= Jump/Turn left to right while moonwalking.
TC2:	;= Jump/Turn left to right while moonwalking and aiming diagonal up.
TC4:	;= Jump/Turn left to right while moonwalking and aiming diagonal down.
DW $0080,$0100,$0019	;pb/cf	(press [A] & hold [RIGHT] to spinjump)
DW $0080,$0000,$004B	;pb/cf	(press [A] to jump)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TBD:	;= Grabbed by Draygon, facing left aiming downleft, not moving
DW $0000,$0810,$00BB	;cf	(hold [R+UP] to aim upleft)
DW $0000,$0010,$00BD	;cf	(hold [R] to aim downleft)
TBA:	;= Grabbed by Draygon, facing left, not moving
TBB:	;= Grabbed by Draygon, facing left aiming upleft, not moving
TBC:	;= Grabbed by Draygon, facing left and firing
TBE:	;= Grabbed by Draygon, facing left, moving
DW $0000,$0A40,$00BB	;pb/cf	(hold [X+(UP+LEFT)] to aim upleft)
DW $0000,$0640,$00BD	;pb/cf	(hold [X+(DOWN+LEFT)] to aim downleft)
DW $0000,$0410,$00BD	;cf	(hold [R+DOWN] to aim downleft)
DW $0000,$0240,$00BC	;pb	(hold [LEFT+X] to fire)
DW $0000,$0010,$00BB	;pb/cf	(hold [R] to aim upleft)
;;;DW $0000,$0020,$00BD	;pb	(hold [L] to aim downleft)
DW $0000,$0040,$00BC	;pb/cf	(hold [X] to fire)
DW $0000,$0200,$00BE	;pb/cf	(hold [LEFT] to move)
DW $0000,$0100,$00BE	;pb/cf	(hold [RIGHT] to move)
DW $0000,$0800,$00BE	;pb/cf	(hold [UP] to move)
DW $0000,$0400,$00BE	;pb/cf	(hold [DOWN] to move)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TC7:	;= Super jump wind-up, facing right
DW $0200,$0000,$00CA	;pb	(press [LEFT] to shine horizontal)
DW $0000,$0880,$00CB	;pb/cf	(hold [UP+A] to shine vertical)
DW $0000,$0010,$00CD	;pb	(hold [R] to shine diagonal)
DW $0000,$0090,$00CD	;cf	(hold [R+A] to shine diagonal)
DW $0000,$0100,$00C9	;pb	(hold [RIGHT] to shine horizontal)
DW $0000,$0180,$00C9	;cf	(hold [RIGHT+A] to shine horizontal)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TC8:	;= Super jump wind-up, facing left
DW $0100,$0000,$00C9	;pb	(press [RIGHT] to shine horizontal)
DW $0000,$0880,$00CC	;pb/cf	(hold [UP+A] to shine vertical)
DW $0000,$0010,$00CE	;pb	(hold [R] to shine diagonal)
DW $0000,$0090,$00CE	;cf	(hold [R+A] to shine diagonal)
DW $0000,$0200,$00CA	;pb	(hold [LEFT] to shine horizontal)
DW $0000,$0280,$00CA	;cf	(hold [LEFT+A] to shine horizontal)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TDF:	;= Samus is facing left as a morphball. Unused? (Grabbed by Draygon movement)
DW $0800,$0000,$00DE	;pb/cf (press [UP] to unmorph)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
TEF:	;= Grabbed by Draygon, facing right aiming downright. Not moving
DW $0000,$0810,$00ED	;pb/cf	(hold [R+UP] to aim upright)
DW $0000,$0010,$00EF	;pb/cf	(hold [R] to aim downright)
TEC:	;= Grabbed by Draygon, facing right. Not moving
TED:	;= Grabbed by Draygon, facing right aiming upright. Not moving
TEE:	;= Grabbed by Draygon, facing right and firing.
TF0:	;= Grabbed by Draygon, facing right. Moving
DW $0000,$0940,$00ED	;pb/cf	(hold [X+(UP+RIGHT)] to aim upright)
DW $0000,$0010,$00ED	;pb/cf	(hold [R] to aim upright)
DW $0000,$0540,$00EF	;pb/cf	(hold [X+(DOWN+RIGHT)] to aim downright)
DW $0000,$0410,$00EF	;cf	(hold [R+DOWN] to aim downright)
DW $0000,$0140,$00EE	;pb	(hold [RIGHT+X] to fire)
DW $0000,$0040,$00EE	;pb/cf	(hold [X] to fire)
;;;DW $0000,$0020,$00EF	;pb	(hold [L] to aim downright)
DW $0000,$0200,$00F0	;pb/cf	(hold [LEFT] to move)
DW $0000,$0100,$00F0	;pb/cf	(hold [RIGHT] to move)
DW $0000,$0800,$00F0	;pb/cf	(hold [UP] to move)
DW $0000,$0400,$00F0	;pb/cf	(hold [DOWN] to move)
DW $FFFF
;-------------------------------------------------------------------------------------------------------
