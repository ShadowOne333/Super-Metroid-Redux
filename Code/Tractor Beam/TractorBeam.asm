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