lorom

org $90BEDE 
                       JSR.W CODE_90FAA0

org $90FAA0 
          CODE_90FAA0: PHA          
                       CMP.W #$8200 
                       BNE Skip     
                       LDA.W $0B36  
                       BEQ Skip     
                       LDA.W $0C04,X
                       CMP.W #$0004 
                       BEQ Continue1 
                       CMP.W #$0005 
                       BNE Skip     
                                    
            Continue1: LDA.W #$0001 
                       STA.W $0B36  
                       LDA.W #$0003 
                       STA.W $0B2E  
                                    
                 Skip: PLA          
                       STA.W $0C18,X
                       RTS          