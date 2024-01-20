; For each of the following instructions, give the new destination contents and the new settings of CF, SF, ZF, PF, and OF. Suppose that the flags are initially 
; 0 in each part of this question.
; a. ADD AX, BX where AX contains FFFEH and BX contains 0001H
; b. INC AL where Al contains FFH
; c. NEG AL where AL contains F7H
; d. XCHG AX, BX where AX contains ABC1H and BX contains A217H

.MODEL SMALL
.STACK 100H
.CODE

MAIN PROC 
     ;a
     MOV AX,0FFFEH
     MOV BX,0001H
     ADD AX,BX
     
     ;b
     MOV AL,0FFH
     INC AL
     
     ;c
     MOV AL,0F7H
     NEG AL
     
     ;d
     MOV AX,0ABC1H
     MOV BX,0A217H
     XCHG AX,BX
     
     MOV AH,4CH
     INT 21H
     END MAIN


