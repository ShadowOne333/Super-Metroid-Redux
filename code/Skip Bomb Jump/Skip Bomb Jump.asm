lorom

org $A09834
                       JSR.W CODE_A0F800

org $A0F800
          CODE_A0F800: LDA.B $8B      
                       BIT.W $09AC    
                       BNE CODE_A0F80B
                       LDA.W $0AF6    
                       RTS            
                                      
          CODE_A0F80B: PLA            
                       PLB            
                       RTL            
