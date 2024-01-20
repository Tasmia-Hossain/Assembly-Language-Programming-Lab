;Write a program that prompts the user to enter a character, and in subsequent lines prints its ASCII code in binary and the number of 1 bit in its ASCII code.

.MODEL SMALL
.STACK 100H   
.DATA    

INPUT DB 'ENTER A CHARACTER: $'
BINARY DB 0DH,0AH,'ASCII CODE IN BINARY: $'
PRINT DB 0DH,0AH,'NUMBER OF 1 BIT IN ASCII CODE: $'             
             
.CODE
MAIN PROC 
    ;initialize DS
    MOV AX,@DATA   
    MOV DS,AX  
    
    ;display input msg
    LEA DX,INPUT
    MOV AH,9
    INT 21H
    
    ;input a character
    MOV AH,1
    INT 21H
           
    ;initialize BX=0       
    XOR BX,BX
    MOV BL,AL 
    
    ;display Binary msg
    LEA DX,BINARY
    MOV AH,9
    INT 21H 
    
    ;initialize BH=0,CX=8
    XOR BH,BH
    MOV CX,8 
     
    MOV AH,2
    
  ASCII_IN_BINARY:
    SHL BL,1    ;left shift 1 bit 
    
    JNC ZERO    ;if CF=0
    INC BH
    MOV DL,31H  ;display 1
    JMP PRINT_RESULT
    
  ZERO:
    MOV DL,30H  ;display 0
    
  PRINT_RESULT:
    INT 21H     ;until CL=0
    LOOP ASCII_IN_BINARY 
    
    ;display print msg
    LEA DX,PRINT 
    MOV AH,9
    INT 21H
    
    OR BH,30H   ;mask to get number 
    
    ;print the result
    MOV AH,2
    MOV DL,BH
    INT 21H   
    
    
  EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    
    
    
    
    
    






