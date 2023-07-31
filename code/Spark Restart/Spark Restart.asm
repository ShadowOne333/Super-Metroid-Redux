lorom

org $948884 : JSR $B1F0

org $94B1F0
          CODE_94B1F0: LDA.W $0A1C      
                       CMP.W #$00C9     
                       BEQ CODE_94B201  
                       CMP.W #$00CA     
                       BEQ CODE_94B24C  
                       LDA.W #$0001     
                       RTS              
                                        
          CODE_94B201: LDA.B $8B        
                       BIT.W $09B0      
                       BNE CODE_94B20C  
                       LDA.W #$0001     
                       RTS              
                                        
                                        
          CODE_94B20C: LDA.W #$0009     
                       STA.W $0A28      
                       DEC A            
                       STA.W $0A1E      
                       LDA.W #$0001     
                       STA.W $0A1F      
                                        
          CODE_94B21C: LDA.W #$0009     
                       STA.W $0B42      
                       LDA.W #$FFFE     
                       STA.B $12        
                       STZ.B $14        
                       JSL.L $949763
                       LDA.W #$0001     
                       STA.W $0A6E      
                       STA.W $0B3C      
                       LDA.W #$0402     
                       STA.W $0B3E      
                       STZ.W $0B36      
                       LDA.W #$A337     
                       STA.W $0A58      
                       LDA.W #$E913     
                       STA.W $0A60      
                       RTS              
                                        
          CODE_94B24C: LDA.B $8B        
                       BIT.W $09AE      
                       BNE CODE_94B257  
                       LDA.W #$0001     
                       RTS              
                                        
                                        
          CODE_94B257: LDA.W #$000A     
                       STA.W $0A28      
                       LDA.W #$0004     
                       STA.W $0A1E      
                       LDA.W #$0001     
                       STA.W $0A1F      
                       JMP.W CODE_94B21C