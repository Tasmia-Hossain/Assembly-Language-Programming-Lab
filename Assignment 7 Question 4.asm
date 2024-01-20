;Write a program that prompts the user to enter a string of decimal digits, ending with a carriage return, and print their sum in hex on the next line. 
; If the user enters an illegal character, he or she should be prompted to begin again.

.MODEL SMALL
.STACK 100H
.DATA
INPUT DB 'ENTER A STRING OF DECIMAL DIGIT: $'
SUM DB 0DH,0AH,'THE SUM IN HEX FORM: $'
WRONG DB 0DH,0AH,'OPPS!!! ILLEGAL INPUT. TRY AGAIN: $'
         
.CODE
MAIN PROC
    ;initialize DS    
    MOV AX,@DATA
    MOV DS,AX
            
    ;display input msg 
    LEA DX,INPUT          
    MOV AH,9
    INT 21H
    
    JMP BEGIN                  
    
  TOP:                   
    LEA DX,WRONG  
    MOV AH,9
    INT 21H
    
    XOR BX,BX    ;CLEARING BX
    XOR CX,CX    ;CLEARING CX
    
  BEGIN:                   
    MOV AH,1
    INT 21H
    
    INC CX                     
    
    CMP AL,0DH      ;COMPARE AL WITH CARRIAGE RETURN
    JNE NO_ENTER    ;IF AL!=CR
    
    CMP CX,1                 
    JB TOP          ;IF CX<1
    JMP END_INPUT             
    
  NO_ENTER:                  
    CMP AL,30H      ;COMPARE AL WITH 0
    JB TOP          ;IF AL<0
    
    CMP AL,39H      ;COMPARE AL WITH 1
    JA TOP          ;IF AL>9
    
    AND AL,0FH      ;ASCII TO DECIMAL 
    
    
    XOR AH,AH       ;CLEARING AH
    ADD BX,AX                 
    
    JMP BEGIN               
    
  END_INPUT:                    
    ;display sum msg
    LEA DX,SUM           
    MOV AH,9
    INT 21H
    
    MOV CX,4                    
    MOV AH,2                    
    
  LOOP_1:                        
    XOR DX,DX      ;CLEARING DX
    
  LOOP_2:                     
    SHL BX,1       ;BX SINGLE LEFT SHIFT
    RCL DL,1       ;DL ROTATE BY 1 THROUGH CARRY
    INC DH                  
    CMP DH,4       ;COMPARE DH WITH 4
    JNE  LOOP_2    ;IF DH!=4
    
    CMP DL,9       ;COMPARE DL WITH 9
    JBE NUMBER     ;IF DL<=9
    SUB DL,9       ;CONVERT TO NUMBER
    OR DL,40H      ;CONVERT NUMBER TO LETTER
    JMP DISPLAY               
                               
  NUMBER:            
    OR DL,30H      ;CONVERTING DECIMAL TO ASCII
    
  DISPLAY:                 
    INT 21H                 
    LOOP LOOP_1    ;UNTIL  CX=0
    
  EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN 




ND MAIN 




