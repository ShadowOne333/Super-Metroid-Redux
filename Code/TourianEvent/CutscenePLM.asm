; Code by Nodever2
; After applying this code, we need to manually modify the gray door at the entrance of the Super Metroid room with SMILE RF (room DC21 I think), and change its Main PLM from 0CA6 to 08A6.
; That way, the door will use the newly set flag (which is a reused Torizo boss flag since Tourian doesn't have one) to check whether or not to unlock the door.

lorom

org $A9F29A
    JSR SetEvent
    
org $A9FC00
SetEvent:
    LDA #$0004 : JSL $8081A6;set area torizo bit
    LDA #$0007;vanilla code replaced by hijack
    RTS 
