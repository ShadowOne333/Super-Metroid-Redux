lorom

org $86EFE2 : JSL.L $80CEA0 : NOP #2

org $80CEA0
          CODE_80CEA0: LDA.W $0CD0      
                       CMP.W #$003C     
                       BMI CODE_80CF00  
                       LDA.W $1A4B,X    
                       SEC              
                       SBC.W $0AF6      
                       STA.B $12        
                       LDA.W $1A93,X    
                       SEC              
                       SBC.W $0AFA      
                       STA.B $14        
                       JSL.L $A0C0AE
                       STA.B $00        
                       LDA.W $0CD0      
                       SEC              
                       SBC.W #$003C     
                                        
          CODE_80CEC7: LSR A            
                       CMP.W #$0008     
                       BMI CODE_80CED5  
                                        
                       CMP.W #$0010     
                       BPL CODE_80CEC7  
                       LDA.W #$0008     
                                        
          CODE_80CED5: STA.W $0E32      
                       LDA.B $00        
                       JSL.L $A0B0C6
                       LDA.W $0E36      
                       STA.B $02        
                       LDA.B $00        
                       JSL.L $A0B0B2
                       LDA.W $0E36      
                       STA.B $04        
                       LDA.W $1A4B,X    
                       CLC              
                       ADC.B $02        
                       STA.W $1A4B,X    
                       LDA.W $1A93,X    
                       CLC              
                       ADC.B $04        
                       STA.W $1A93,X    
                                        
          CODE_80CF00: DEC.W $1B23,X    
                       LDA.W $1B23,X    
                       RTL              

org $86F600 
                       LDA.W $0CD0    
                       BEQ CODE_86F631
                       LDA.W $0AF6    
                       CMP.W $1A4B,X  
                       BEQ CODE_86F613
                       BMI CODE_86F61F
                       BPL CODE_86F624
                       BRA CODE_86F631
                                      
                                      
          CODE_86F613: LDA.W $1A93,X  
                       CMP.W $0AFA    
                       BEQ CODE_86F631
                       BMI CODE_86F629
                       BPL CODE_86F62E
                                      
          CODE_86F61F: DEC.W $1A4B,X  
                       BRA CODE_86F613
                                      
                                      
          CODE_86F624: INC.W $1A4B,X  
                       BRA CODE_86F613
                                      
                                      
          CODE_86F629: INC.W $1A93,X  
                       BRA CODE_86F631
                                      
                                      
          CODE_86F62E: DEC.W $1A93,X  
                                      
          CODE_86F631: LDA.W $1B23,X  
                       RTS            
