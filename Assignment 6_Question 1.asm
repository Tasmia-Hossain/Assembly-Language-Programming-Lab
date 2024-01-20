; Write a program that will prompt the user to enter a hex digit character (0- F), display it on the next line in decimal and ask the user if he or she wants to
; do it again. If the user types “Y”, the program repeats. If the user types “N” the program terminates. If the user enters an illegal character prompt the
; user to try again.

.MODEL SMALL
.STACK 100H
.DATA

INPUT_MSG DB 'ENTER A HEX DIGIT CHARACTER: $'
DISPLAY DB 'THE DECIMAL FORM OF THE HEX DIGIT CHARACTER: $'
ASK DB 'TYPE 'Y' FOR REPEAT AND 'N' FOR TERMINATE: $'
ILLEGAL DB 'Illegal Character!! Please Enter a HEX DIGIT Character (0-F): $'

.CODE
MAIN PROC    
    
    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX
    
    
    INPUT:
      ;print input msg
      MOV AH,9
      LEA DX,INPUT_MSG
      INT 21H
      
      ;user input
      MOV AH,1                  
      INT 21H
      MOV BL,AL


      ;less than 0
      CMP BL,48
      JL ILLEGAL_INPUT
      
      ;greater than F
      CMP BL,70
      JG ILLEGAL_INPUT 
      
      ;between 0-9
      CMP BL,57
      JLE CHANGE_DIGIT
      
      ;between 58-64 
      CMP BL,64
      JLE ILLEGAL_INPUT
      
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H 
      
      ;print display msg
      MOV AH,9
      LEA DX,DISPLAY
      INT 21H
      
      ;output
      SUB BL,17
     
      MOV AH,2
      MOV DL,49             
      INT 21H
      MOV DL,BL             
      INT 21H      
      JMP ASK_FOR_REPEAT  
      
      
    ASK_FOR_REPEAT:
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H 
      
      MOV AH,9
      LEA DX,ASK
      INT 21H
      
      MOV AH,1
      INT 21H
      MOV CL,AL
       
      CMP CL,'Y'
      
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H 
       
      ;if 'Y' then Repeat 
      JE INPUT           
              
      ;if 'N' then Stop        
      CMP CL,'N'
      JE EXIT 
      
      JMP ILLEGAL_INPUT 
      
    CHANGE_DIGIT:
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H 
      
      MOV AH,9
      LEA DX,DISPLAY
      INT 21H
      
      MOV AH,2
      MOV DL,BL           
      INT 21H
      JMP ASK_FOR_REPEAT  
      
    ILLEGAL_INPUT:
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H
      
      MOV AH, 9                  
      LEA DX,ILLEGAL           
      INT 21H
      
      ;go to a new line
      MOV AH,2
      MOV DL,0DH
      INT 21H
      MOV DL,0AH
      INT 21H
      
    EXIT:
      MOV AH,4CH
      INT 21H
      MAIN ENDP
    END MAINN
