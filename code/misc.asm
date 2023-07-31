lorom

org $818131 : db $49,$47,$4B,$11,$41,$14,$07	;Changes size of area maps

org $81B324
                       LDA.W #$0080
                       STA.W $09B6 
                       LDA.W #$8000
                       STA.W $09B4 
                       LDA.W #$0040
                       STA.W $09B8 
                       LDA.W #$4000
                       STA.W $09B2 
                       LDA.W #$2000
                       STA.W $09BA 
                       LDA.W #$0010
                       STA.W $09BC 
                       LDA.W #$0020
                       STA.W $09BE 
                       STZ.W $09DA 
                       STZ.W $09DC 
                       STZ.W $09DE 
                       STZ.W $09E0 
                       STZ.W $09E2 
                       STZ.W $09EA 
                       LDA.W #$0001
                       STA.W $09E4 

org $828774
                       dw $9D19,$8DAE,$0001,$02D0,$03A0,$007B,$002A,$021D,$8925,
					      $A3AE,$9096,$0000,$0200,$0000,$008B,$0048,$011B,$8924,
					      $9BC8,$8CD6,$0004,$0000,$0100,$005B,$FFCD,$013E,$8924,
                          $9E52,$8DEA,$0003,$0220,$01D0,$007B,$0016,$0080,$8924,
                          $A815,$92BE,$0000,$0600,$0200,$008B,$005A,$0100,$8924,
                          $A6A1,$A384,$0001,$0000,$0000,$008B,$FFB8,$023D,$891A,
                          $FFFF
					   
                       dw $A0D2,$8E0E,$0006,$0110,$0000,$006B,$0009,$017F,$8924,
                          $A253,$8F0A,$0001,$0000,$0400,$008B,$FFDC,$0143,$8924,
                          $91F8,$896A,$0000,$0220,$0400,$00BB,$001F,$017C,$8924,
                          $ACB3,$97CE,$0000,$0000,$0100,$008B,$FFA7,$0297,$8924,
                          $948C,$8ADE,$0000,$0200,$0000,$008B,$0048,$02C5,$8924,
                          $93FE,$8AEA,$0001,$0000,$0400,$008B,$FFAC,$019E,$8924,
                          $FFFF
					   
                       dw $ADAD,$962A,$0000,$01E0,$0000,$008B,$FFF5,$01C0,$8924,
                          $91F8,$896A,$0001,$0300,$0400,$00B0,$0000,$00C7,$8925,
                          $A253,$8F0A,$0001,$0000,$01C0,$008B,$FFE8,$01AA,$8924,
                          $9D19,$8DAE,$0001,$0200,$0200,$008B,$FFB7,$03C0,$8924,
                          $A59F,$91B6,$0001,$0000,$0100,$008B,$FFBF,$013F,$892B,
                          $A66A,$91F2,$0001,$0000,$0000,$008B,$FFB1,$0197,$8932,
                          $FFFF
					   
                       dw $91F8,$890A,$0000,$0600,$0200,$0080,$0030,$0100,$8925,
                          $A59F,$91B6,$0001,$0000,$0100,$008B,$FFB7,$04E1,$8924,
                          $91F8,$890A,$0000,$0600,$0200,$007B,$0020,$0185,$8925,
                          $DD58,$AAC8,$0002,$0300,$0000,$008B,$004C,$0174,$8924,
                          $91F8,$890A,$0000,$0600,$0200,$008B,$0004,$0200,$8925,
					      $FFFF

org $829297 : DEC $B1
org $8292C6 : INC $B1
org $8292D3 : DEC $B3
org $8292E0 : INC $B3

org $8298D7 : db $40
org $8298EF : db $00

org $82E3F1 : CMP #$0003

org $82F22C
                       LDA.W #$0040
                       STA.W $09B8 
                       LDA.W #$0080
                       STA.W $09B6 
                       LDA.W #$8000
                       STA.W $09B4 
                       LDA.W #$4000
                       STA.W $09B2 
                       LDA.W #$2000
                       STA.W $09BA 
                       LDA.W #$0010
                       STA.W $09BC 
                       LDA.W #$0020
                       STA.W $09BE 

org $82FF8E
                       db $11,$0C,$00,$97,$00,$FF,$FF,$2A
                       db $08,$0C,$00,$98,$00,$FF,$FF,$1D
                       db $09,$0C,$00,$9A,$00,$FF,$FF,$26
                       db $0B,$0C,$00,$FF,$FF,$FF,$FF,$FF 

org $84B48B 
                       dw $0000,$0001
					   dw $0120,$0100
                       dw $0600,$0600

org $84B4B6
                       LDA.W #$0000
                       STA.W $0B5A 
                       LDA.W #$0000
                       STA.W $0B5C 

org $84BA54 : db $2A


org $84BABF
                       dw $0001,$A6E3
					   dw $0001,$A6EF
					   dw $0001,$A6FB

org $84E2CA : db $00

org $84E2FF : db $00

org $84E727 : db $00

org $84E769 : db $00

org $84EC31 : db $00

org $84EC79 : db $00

org $84F030
                       STA.W $09D4
                       STA.W $09D6
                       RTS        

org $858000 : padword $000E : pad $858080

org $858426 : padword $000E : pad $858436

org $888788 : LDA $0084

org $888799 : LDA #$001A

org $8887F7 : SBC #$0002

org $888819 : ADC #$0002

org $88884F : ADC #$0002

org $88887A : SBC #$0002

org $8FE9A0 
					   LDA #$0001
					   JSL $8081FA
					   RTS

org $8FE9A8 
					   STZ $0F78
					   STZ $0FB8
					   RTS

org $90854D : AND #$000F

org $908592 : ADC #$0200

org $909005 : AND #$0000

org $909774 : AND #$000F

org $909E93 : dw $0004

org $909E97 : dw $0100 : dw $0800 : dw $0100 : dw $0800 : dw $000A

org $909EBD : dw $0003

org $909EC9 : dw $0004

org $909ED3 : dw $0002

org $909EDF : dw $0002

org $909EF7 : dw $0001,$0002

org $909F27 : dw $6000,$0004

org $90A031 : dw $0002

org $90A09B : dw $1000,$0001,$C000,$0001

org $90A0A7 : dw $C700

org $90A0B3 : dw $FF00

org $90A0BF : dw $0600

org $90A0EF : dw $F000

org $90A15B : dw $0800

org $90A167 : dw $F000

org $90A173 : dw $F000

org $90A445 : NOP #3

org $90B85F : CMP #$002C

org $90C254 : db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C

org $90C27B : db $08,$0A

org $90C283 : db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C

org $90C2D1 : dw $0400,$01AB,$0400,$01AB
              dw $0400,$01AB,$0400,$01AB
              dw $0400,$02AB,$0400,$02AB
              dw $0400,$02AB,$0400,$02AB
              dw $0600,$04AB,$0600,$04AB
              dw $0600,$04AB,$0600,$04AB

org $90CF33 : LDA #$0060

org $90CF70 : LDA #$0001

org $90D036 : LDA #$003A

org $90D0CE : LDA $09C2

org $90D0FD : LDA $09C2

org $90D129 : LDA $09C2

org $90D34C : JSR.W $FA7A ;Ending Shinespark

org $90FA7A : LDA.W #$0001 : STA.W $05D5
			  LDA.W $0AAF : RTS

org $90D396 : BRA $27

org $90D8CF : dw $0011,$0011,$0011,$0011,$0011 
			  dw $8200,$8480,$0000,$01F0,$0480
			  dw $0001,$0002,$0000,$0001,$0002 

org $90E2E9 : LDA #$0050
org $90E2F1 : LDA #$004F

org $90F640
                       CMP.W #$0003 : BEQ CODE_90F658
                       CMP.W #$0002 : BEQ CODE_90F658
                       CMP.W #$0006 : BEQ CODE_90F658
                       CMP.W #$0014 : BEQ CODE_90F658
                       JSL.L $9098BC
                                        
          CODE_90F658: RTL

org $90F670
          CODE_90F670: LDA.W $0A23      
                       AND.W #$00FF     
                       CMP.W #$0003     
                       BEQ CODE_90F68E  
                       CMP.W #$0002     
                       BEQ CODE_90F68E  
                       CMP.W #$0006     
                       BEQ CODE_90F68E  
                       CMP.W #$0014     
                       BEQ CODE_90F68E  
                       JSL.L $9098BC
                                        
          CODE_90F68E: RTL              

org $90F780 : STA.B $12 : STZ.B $14 : JSR.W $9440 : RTL

org $91D755 : CMP #$002C

org $91D9FD : BRA $EB

org $91EFFA : NOP #6

org $91F66F : NOP #4

org $948E92 : NOP #2

org $9BCB97 : LDA #$0019

org $9BCB9F : LDA #$001A

org $A09929 : LDA #$0008

org $A0A57B : LDA #$0008

org $A2A80F : CMP #$02EA

org $A39581
                       STZ.W $0799    
                       LDA.W #$0008   
                       CMP.W $0998    
                       BNE CODE_A39596
                       LDA.W $0F7E,X  
                       CLC            
                       ADC.W #$0001   
                       STA.W $0F7E,X  
                                      
          CODE_A39596: INC.W $0F7E,X  
                       NOP            

org $A395AF : SBC #$0002

org $A395D1 : ADC #$0002

org $A395EB : SBC #$0002

org $A6AAD7 : BRA $10

