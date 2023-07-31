lorom

org $A0868F 
                       JSR.W CODE_A0FF00

org $A0FF00
          CODE_A0FF00: PHX              
                       LDA.W $0A28      
                       CMP.W #$004F     
                       BEQ CODE_A0FF20  
                       CMP.W #$0050     
                       BEQ CODE_A0FF20  
                       LDA.W $0A1C      
                       CMP.W #$004F     
                       BEQ CODE_A0FF2F  
                       CMP.W #$0050     
                       BEQ CODE_A0FF2F  
                                        
                 exit: PLX              
                       LDA.W $1840      
                       RTS              
                                        
          CODE_A0FF20: LDA.W #$0002     
                       STA.W $0B36      
                       LDA.W #$FFFA     
                       JSL.L $90F780
                       BRA exit         
                                        
          CODE_A0FF2F: LDX.W $05D5      
                       INX              
                       STX.W $05D5      
                       CPX.W #$0000     
                       BPL CODE_A0FF3D  
                       BRA exit         
                                        
                                        
          CODE_A0FF3D: CPX.W #$0025     
                       BPL exit         
                       CPX.W #$0010     
                       BPL CODE_A0FF51  
                       CPX.W #$0005     
                       BPL CODE_A0FF56  
                       LDA.W #$FFFB     
                       BRA CODE_A0FF59  
                                        
          CODE_A0FF51: LDA.W #$FFFD     
                       BRA CODE_A0FF59  
                                        
          CODE_A0FF56: LDA.W #$FFFD     
                                        
          CODE_A0FF59: JSL.L $90F780
                       BRA exit         
