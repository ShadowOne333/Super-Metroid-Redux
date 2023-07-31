lorom

org $90BFFE 
                       JSR.W CODE_90F750

org $90F750 
          CODE_90F750: PHA            
                       LDA.W $0B36    
                       BNE CODE_90F763
                       LDA.B $8B      
                       BIT.W $09AC    
                       BEQ CODE_90F763
                       PLA            
                       LDA.W #$0001   
                       BRA CODE_90F764
                                      
          CODE_90F763: PLA            
                                      
          CODE_90F764: STA.W $0C7C,X  
                       RTS            
