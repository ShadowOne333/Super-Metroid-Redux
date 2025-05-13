lorom

; This patch enables x-ray in fireflea rooms
; Fireflea rooms are notable for having all the level design drawn on layer 2 (except for elements that aren't affected by darkness, such as doors)
; So aside from from removing the fireflea FX check and reverting the fireflea colour math changes during x-ray,
; this patch draws both layer 1 and layer 2 blocks onto the (pre-revealed) x-ray tilemap

; This only applies for rooms that have a custom layer 2 that scrolls at the same speed as layer 1,
; but this condition (start of `BuildXrayBg2Tilemap_TransferXrayTilemap_Screen0`) could be changed to check for [FX type] = fireflea instead (though this would require writing the check in free space ^^;)
; if it turns out to be problematic to apply this solution so generally

; Even though I had to add code for drawing the layer 2 tilemap onto the x-ray tilemap and added some checks for empty tiles,
; no free space is used

; Notes
{
; During x-ray:
;     BG2 is a revealed copy of BG1
;     BG1/BG3 is disabled inside window 2
;     BG2 is disabled outside window 2
;     Colour math is disabled inside windows
;     Halved colour math is enabled

; In fireflea rooms:
;     The level graphics are on BG2
;     Colour math only affects BG2/backdrop
;     Colour math only applies subscreen backdrop
;     Subtractive colour math is enabled
}

; Handle layer blending x-ray - fireflea room
org $8881DB
{
JSR $8075 ; Initialise layer blending
JSR $817B ; Handle layer blending x-ray - can show blocks
RTS

; Well we freed up some space, lets make use of it
ClearXrayTilemap:
{
; Clear the x-ray tilemap in advance to compensate for the skipping of blank tiles when building the x-ray tilemap
LDA #$0338
LDX #$4000
LDY #$1000
JSL $8083F6

PLB : PLP : SEC : RTL ; Overwritten by hijack
}

warnpc $8881FE
}

; X-ray setup stage 4 - build x-ray BG2 tilemap, read BG2 tilemap - 1st screen
org $91CB8E
{
; This section of the code is fairly aggressively optimised to fit here without spilling to free space

; Split this out from stage 4 into its own stage
ReadBg2Tilemap_Screen0:
{
LDX $0360
LDA.b $59-1 : AND.w #$00FC<<8 : STA $0340,x
LDA #$3981 : STA $0342,x
LDA #$5000 : STA $0344,x
LDA #$007E : STA $0346,x
LDA #$0800 : STA $0347,x
TXA : CLC : ADC #$0009 : STA $0360
RTL
}

; This is what used to be stage 4, but the read BG2 1st screen swapped out for x-ray 1st screen transfer
BuildXrayBg2Tilemap_TransferXrayTilemap_Screen0:
{
; Check if BG2 tilemap is suitable for copying, namely layer 2 scroll = 0000 (custom layer 2, BG2 scrolls with BG1, no parallax)
LDA $091B : BNE +
    LDY $1920,x
    LDA $1914,x : TAX
    LDA #$5000
    JSR CopyBgToXrayTilemap

+
LDY $B3
LDX $B1
LDA #$6000
JSR CopyBgToXrayTilemap

; $22 = [layer 1 Y position] / 10h * [room width in blocks] + [layer 1 X position] / 10h (block index)
LDA $0915 : LSR #4 : XBA : ORA $07A5 : STA $4202
LDA $0911 : LSR #4 : CLC : ADC $4216 : STA $22

; $16 = 0 (x-ray BG2 tilemap index)
STZ $16

; $14 = 10h (row loop counter)
LDA #$0010 : STA $14

.loop_revealed_row
{
    ; Load right half of revealed 2xN block
    JSR $CD42

    ; $12 = 10h (column loop counter)
    LDA #$0010 : STA $12

    ; $24 = (block index)
    LDA $22 : STA $24

    .loop_revealed_column
    {
        ; Load revealed block
        JSR $CDBE

        DEC $12 : BNE .loop_revealed_column
    }

    ; A = [$16]
    LDA $16 : PHA

    ; $16 += 7C0h
    CLC : ADC #$07C0 : STA $16

    ; Load revealed block
    JSR $CDBE

    ; $16 = [A] + 40h
    PLA : CLC : ADC #$0040 : STA $16

    ; (Block index) += [room width]
    LDA $22 : ADC $07A5 : STA $22

    DEC $14 : BNE .loop_revealed_row
}

JSL $84831A ; Load item x-ray blocks
JMP $D173 ; X-ray setup stage 6 - transfer x-ray tilemap - 1st screen
}

; This is split off into a subroutine so that it can be reused for BG1 and BG2 tilemaps
CopyBgToXrayTilemap:
{
;; Parameters:
;;     A: Source tilemap base address
;;     X: BG X scroll
;;     Y: BG Y scroll

STA $22

; $18 (BG row origin block index) =
;       ([BG Y scroll] / 8 & 1Eh) * 20h (20h tiles per tilemap row, rounded down to top-left of 16x16 block)
;     + ([BG X scroll] / 8 & 1Eh)       (1 byte per tilemap column, rounded down to top-left of 16x16 block)
;     + [BG X scroll] / 100h % 2 * 400h (400h tiles per tilemap screen)
TYA : AND #$00F0 : ASL #2 : STA $18
TXA : AND #$00F0 : LSR #3 : ADC $18 : STA $18
TXA : AND #$0100 : ASL #2 : ADC $18 : STA $18

; $16 = 0 (x-ray BG2 tilemap index)
STZ $16

; $14 = 10h (row loop counter)
LDA #$0010 : STA $14

PEA $917E : PLB
.loop_copy_bg_row
{
    ; $12 = 10h (column loop counter)
    LDA #$0010 : STA $12

    ; $1A = [BG row origin block index] & 7E0h (BG row origin block row index)
    LDA $18 : AND #$07E0 : STA $1A

    ; $1C = [BG row origin block index] & 1Fh (BG row origin block column index)
    LDA $18 : AND #$001F : STA $1C

    ; $1E = 0 (BG block X offset)
    STZ $1E

    .loop_copy_bg_column
    {
        ; X = ([BG row origin block row index] + [BG row origin block column index] + [BG block X offset]) * 2
        LDA $1A : ADC $1C : ADC $1E : ASL A : ADC $22 : TAX

        ; $7E:4000 + [x-ray BG2 tilemap index]       = [$7E:5000/6000 + [X]]
        ; $7E:4000 + [x-ray BG2 tilemap index] + 2   = [$7E:5000/6000 + [X] + 2]
        ; $7E:4000 + [x-ray BG2 tilemap index] + 40h = [$7E:5000/6000 + [X] + 40h]
        ; $7E:4000 + [x-ray BG2 tilemap index] + 42h = [$7E:5000/6000 + [X] + 42h]
        LDY $16
        LDA $0000,x : CMP #$0338 : BEQ + : STA $4000,y : +
        LDA $0002,x : CMP #$0338 : BEQ + : STA $4002,y : +
        LDA $0040,x : CMP #$0338 : BEQ + : STA $4040,y : +
        LDA $0042,x : CMP #$0338 : BEQ + : STA $4042,y : +

        ; X-ray BG2 tilemap index += 4 (move right two tilemap columns)
        TYA : CLC : ADC #$0004 : STA $16

        ; BG block X offset += 2 (move right two tilemap columns)
        LDA $1E : INC #2 : STA $1E

        ; If [BG row origin block column index] + [BG block X offset] >= 20h (reached end of tilemap screen):
        ADC $1C : CMP #$0020 : BCC +
        {
            ; BG row origin block row index = [BG row origin block row index] + 400h & 7E0h (switch tilemap screens)
            LDA $1A : ADC.w #$0400-1 : AND #$07E0 : STA $1A

            ; BG row origin block column index = 0
            STZ $1C

            ; BG block X offset = 0
            STZ $1E
        }

        +
        DEC $12 : BNE .loop_copy_bg_column
    }

    ; Copy last BG block of row to x-ray BG2 tilemap
    {
        ; $20 = [BG row origin block row index]
        LDA $1A : STA $20

        ; A = [BG row origin block column index] + [BG block X offset]
        LDA $1C : ADC $1E

        ; If [A] >= 20h (reached end of tilemap screen):
        CMP #$0020 : BCC +
        {
            ; $20 = [BG row origin block row index] + 400h & 7E0h (switch tilemap screens)
            LDA $20 : ADC #$0400-1 : AND #$07E0 : STA $20

            ; A = 0
            TDC
        }

        +
        ; X = ([$20] + [A]) * 2
        ADC $20 : ASL A : ADC $22 : TAX

        ; $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h       = [$7E:5000/6000 + [X]]
        ; $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 2   = [$7E:5000/6000 + [X] + 2]
        ; $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 40h = [$7E:5000/6000 + [X] + 40h]
        ; $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 42h = [$7E:5000/6000 + [X] + 42h]
        LDA $16 : ADC #$07C0 : TAY
        LDA $0000,x : CMP #$0338 : BEQ + : STA $4000,y : +
        LDA $0002,x : CMP #$0338 : BEQ + : STA $4002,y : +
        LDA $0040,x : CMP #$0338 : BEQ + : STA $4040,y : +
        LDA $0042,x : CMP #$0338 : BEQ + : STA $4042,y : +
    }

    ; BG row origin block index = ([BG row origin block index] & 400h)
    ;                           + ([BG row origin block index] + 40h & 3FFh) (move down two tilemap rows)
    LDA $18 : AND #$0400 : STA $20
    LDA $18 : CLC : ADC #$0040 : AND #$03FF : ADC $20 : STA $18

    ; X-ray BG2 tilemap index += 40h (move down two tilemap rows)
    LDA $16 : ADC #$0040 : STA $16

    DEC $14 : BEQ + : JMP .loop_copy_bg_row : +
}
PLB

RTS
}

warnpc $91CD42
}

; Check if x-ray should show any blocks
org $91D143
{
; Remove check for fireflea FX
LDA $079B
CMP #$A66A : BEQ + ; In Tourian entrance room
CMP #$CEFB : BEQ + ; In n00b tube room
LDA $179C
CMP #$0003 : BEQ + ; Fighting Kraid
CMP #$0006 : BEQ + ; Fighting Crocomire
CMP #$0007 : BEQ + ; Fighting Phantoon
CMP #$0008 : BEQ + ; Fighting Draygon
CMP #$000A         ; Fighting Mother Brain

+
RTL

warnpc $91D173
}

; HDMA object instruction list - x-ray
org $91D249
{
; Rearrange these so that BG2 tilemap is read before x-ray tilemap is built
dw $85B4 : dl $91D0D3 ; read BG2 tilemap - 2nd screen
skip 4
dw $85B4 : dl ReadBg2Tilemap_Screen0
skip 4
dw $85B4 : dl BuildXrayBg2Tilemap_TransferXrayTilemap_Screen0
}

; X-ray setup
org $91E28D
{
; Hijack the end
JML ClearXrayTilemap
}

