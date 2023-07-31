lorom

org $90AC60 : BEQ $00

org $90AE19 : BRA $02

org $90AFF1 : BRA $29

org $90B005
                       JSR.W $B329       
                       LDA.W $0C04,X           
                       AND.W #$000F            
                       ASL A                   
                       TAX                     
                       JSR.W ($B033,X)
                       JSR.W $B16A       
                       BCC return1              
                       JSL.L $90ADB7       
                                               
              return1: RTS                     

org $90B2FE
                       BNE CODE_90B310  
                       INC A            
                       STA.W $0C7C,X    
                       LDA.W #$0100     
                       STA.B $16        
                       STX.B $12        
                       JSR.W $B1F3
                       BRA CODE_90B313  
                                        
          CODE_90B310: JSR.W $B329
                                        
          CODE_90B313: PLY              
                       PLX              
                       PLP              
                       RTS              

org $90B362 : RTS

org $90B372
                       BNE return       
                       LDA.W $0BF0,X    
                       BPL CODE_90B37D  
                       EOR.W #$FFFF     
                       INC A            
                                        
          CODE_90B37D: AND.W #$FF00     
                       CMP.W #$0B00     
                       BMI return       
                       XBA              
                       SEC              
                       SBC.W #$000A     
                       STA.B $12        
                       LDA.W $0B78,X    
                       PHA              
                       BIT.W $0BF0,X    
                       BMI CODE_90B39A  
                       SEC              
                       SBC.B $12        
                       BRA CODE_90B39D  
                                        
                                        
          CODE_90B39A: CLC              
                       ADC.B $12        
                                        
          CODE_90B39D: STA.W $0B78,X    
                       JSL.L $94A4D9
                       LDA.W $0C18,X    
                       AND.W #$0F00     
                       CMP.W #$0800     
                       PLA              
                       BCS return       
                       STA.W $0B78,X    
                                        
               return: RTS              

org $90B412
                       BNE return2       
                       LDA.W $0BDC,X    
                       BPL CODE_90B41D  
                       EOR.W #$FFFF     
                       INC A            
                                        
          CODE_90B41D: AND.W #$FF00     
                       CMP.W #$0B00     
                       BMI return2       
                       XBA              
                       SEC              
                       SBC.W #$000A     
                       STA.B $12        
                       LDA.W $0B64,X    
                       PHA              
                       BIT.W $0BDC,X    
                       BMI CODE_90B43A  
                       SEC              
                       SBC.B $12        
                       BRA CODE_90B43D  
                                        
          CODE_90B43A: CLC              
                       ADC.B $12        
                                        
          CODE_90B43D: STA.W $0B64,X    
                       JSL.L $94A46F
                       LDA.W $0C18,X    
                       AND.W #$0F00     
                       CMP.W #$0800     
                       PLA              
                       BCS return2       
                       STA.W $0B64,X    
                                        
              return2: RTS              