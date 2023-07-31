lorom

org $90A383 
                       JMP.W CODE_90FA00
                                        
          CODE_90A386: LDA.W $0A1C      

org $90FA00 
          CODE_90FA00: PHP              
                       REP #$30         
                       LDA.W $05D5      
                       AND.W #$0000     
                       STA.W $05D5      
                       BNE Continue4     
                       LDA.W $0A24      
                       CMP.W #$0013     
                       BEQ Return4       
                       CMP.W #$0014     
                       BEQ Return4       
                       CMP.W #$0019     
                       BEQ Return4       
                       CMP.W #$001A     
                       BEQ Return4       
                       CMP.W #$001B     
                       BEQ Return4       
                       CMP.W #$001C     
                       BEQ Return4       
                       CMP.W #$0027     
                       BEQ Return4       
                       CMP.W #$0028     
                       BEQ Return4       
                       CMP.W #$0029     
                       BEQ Return4       
                       CMP.W #$002A     
                       BEQ Return4       
                       CMP.W #$003D     
                       BEQ Return4       
                       CMP.W #$003E     
                       BEQ Return4       
                       CMP.W #$0051     
                       BEQ Return4       
                       CMP.W #$0052     
                       BEQ Return4       
                       CMP.W #$0067     
                       BEQ Return4       
                       CMP.W #$0068     
                       BEQ Return4       
                       CMP.W #$0081     
                       BEQ Return4       
                       CMP.W #$0082     
                       BEQ Return4       
                       CMP.W #$0083     
                       BEQ Return4       
                       CMP.W #$0084     
                       BEQ Return4       
                                        
            Continue4: JMP.W CODE_90A386
                                        
              Return4: PLP              
                       RTS              