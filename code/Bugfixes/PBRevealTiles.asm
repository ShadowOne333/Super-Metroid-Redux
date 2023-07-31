;;; Power Bombs reveal hidden tiles ;;;
; A9 01 00 22 FA 81 80 60

org $84CF70
	JSR jump1	; $FFB0
org $84CFA9
	JSR jump2	; $FFDF

org $84FFB0
jump1:
	PHA
	BEQ +
	CMP #$0200
	BEQ ++
org $84FFB7
jump2:
	ASL A
	CMP #$0500
	BEQ +++
	CMP #$0300
	BEQ +++
++	PLA
	RTS
+++	PLA
	LDA #$0000
	RTS
+	PLA
	LDA #$0001
	RTS 
