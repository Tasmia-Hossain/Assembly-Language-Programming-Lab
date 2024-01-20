.MODEL SMALL
.STACK 100H
.DATA 

MSG1 DB 'ENTER AN UPPERCASE LETTER: $'   
MSG2 DB 'THE LOWERCASE LETTER: $'

.CODE
MAIN PROC
    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX   
    
    ;display message 1
    LEA DX,MSG1
    MOV AH,9
    INT 21H
                  
    ;input an uppercase letter              
    MOV AH,1
    INT 21H  
            
    ;convert uppercase to lowercase
    ADD AL,32
    MOV BL,AL         
    
    ;go to a new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H  
    
    ;display message 2
    LEA DX,MSG2
    MOV AH,9
    INT 21H        
    
    ;display lowercase letter  
    MOV AH,2
    MOV DL,BL
    INT 21H           
    
    ;return to DOS
    MOV AH,4CH
    INT 21H
    END MAIN