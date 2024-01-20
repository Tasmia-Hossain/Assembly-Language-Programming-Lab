.MODEL SMALL
.STACK 100H
.DATA
INPUT1 DB 'ENTER THE FIRST LOWERCASE LETTER : $'
INPUT2 DB 'ENTER THE SECOND LOWERCASE LETTER: $'
RESULT DB 'THE FOLLOWING  ALPHABETICAL ORDER : $'

.CODE
MAIN PROC
    
    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX
    
    ;print msg for input1
    MOV AH,9
    LEA DX,INPUT1
    INT 21H

    ;1st user input
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;go to a new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;print msg for input2
    MOV AH,9
    LEA DX,INPUT2
    INT 21H

    ;2nd user input
    MOV AH,1
    INT 21H
    MOV CL,AL
    
    ;compare and swap if necessary
    CMP CL,BL
    JAE NO_SWAP

    ;swap the letters
    MOV DL,BL
    MOV BL,CL
    MOV CL,DL

    NO_SWAP:
    ;go to a new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H

    ;print the result
    MOV AH,9
    LEA DX,RESULT
    INT 21H

    ;print the letters in alphabetical order
    MOV AH,2
    MOV DL,BL
    INT 21H

    MOV AH,2
    MOV DL,' '
    INT 21H

    MOV AH,2
    MOV DL,CL
    INT 21H

    ;exit the program
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN