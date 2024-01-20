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


