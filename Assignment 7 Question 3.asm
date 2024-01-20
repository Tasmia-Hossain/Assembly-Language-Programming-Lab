; Write a program that prompts the user to enter two unsigned hex numbers, 0 to FFFFh, and prints their sum in hex on the next line. 
; If the user enters an illegal character, he or she should be prompted to begin again. 
; Your program should be able to handle the possibility of unsigned overflow. Each input ends with a carriage return.

.MODEL SMALL
.STACK 100H
.DATA 
    
FIRST DB 'ENTER THE FIRST HEX NUMBER (0-FFFF): $'
SECOND DB 0DH,0AH,'ENTER THE SECOND HEX NUMBER (0-FFFF) : $'                         
SUM DB 0DH,0AH,'THE SUM IN HEX FORM IS : $'
ILLEGAL DB 0DH,0AH,'OPPS!!! Illegal INPUT.PLEASE TRY AGAIN $'

COUNT DB ?
TEMP DW ?

.CODE
MAIN PROC 
    ;initialize DS
    MOV AX,@DATA                
    MOV DS,AX
    
    JMP BEGIN              
    
  TOP:                   
    LEA DX,ILLEGAL          
    MOV AH,9
    INT 21H
    
  BEGIN:                   
    LEA DX,FIRST         
    MOV AH,9
    INT 21H
    
    XOR BX,BX  ;CLEARING BX
    MOV COUNT,30H             
    
  PROCEED:                  
    MOV AH,1               
    INT 21H                    
    
    CMP AL,0DH  ;COMPARE WITH CARRIAGE RETURN
    JNE NO_ENTER ;JUMP IF AL!=CR
    
    CMP COUNT,30H  ;COMPARE COUNT 
    JBE TOP        ;JUMP IF COUNT<=0
    JMP SECOND_INPUT                 
    
  NO_ENTER:                      
    CMP AL,"A"     ;COMPARE AL WITH "A"
    JB DECIMAL_1    ;IF AL<A
    
    CMP AL, "F" ;COMPARE AL WITH "F"
    JA TOP      ;IF AL>F 
    
    ADD AL,09H                
    JMP BINARY                  
    
  DECIMAL_1:                
    CMP AL,30H   ;COMPARE AL WITH 0
    JB TOP        ;IF AL<0
    
    CMP AL,39H   ;compare AL with 9
    JA TOP        ;IF AL>9
    
  BINARY:                        
    INC COUNT                 
    
    AND AL,0FH ;ASCII TO BINARY
    
    MOV CL,4   ;CL=4
    SHL AL,CL  ;AL LEFT SHIFT 
    
    MOV CX,4   ;CX=4
    
  LOOP_1:                   
    SHL AL,1   ;AL SINGLE LEFT SHIFT 
    RCL BX,1   ;BX ROTATE BY 1  THROUGH CARRY 
                              
    LOOP LOOP_1 ;UNTIL CX=0
    
    CMP COUNT,34H             
    JE SECOND_INPUT                 
    JMP PROCEED              
    
  SECOND_INPUT:                        
    MOV TEMP,BX             
    
    LEA DX,SECOND           
    MOV AH,9
    INT 21H
    
    XOR BX,BX      ;CLEARING BX
    MOV COUNT,30H             
    
  PROCEED_2:                 
     MOV AH,1               
     INT 21H                  
    
     CMP AL,0DH    ;COMPARE AL WITH CARRIAGE RETURN
     JNE NO_ENTER_2 ;IF AL!=CR
    
     CMP COUNT,30H ;COMPARE COUNT WITH 0
     JBE TOP        ;IF COUNT<=0
     JMP OUTPUT              
    
   NO_ENTER_2:              
     CMP AL,"A"    ;COMPARE AL WITH "A"
     JB DECIMAL_2   ;IF AL<A
    
     CMP AL,"F"    ;COMPARE AL WITH "F"
     JA JUMP        ;IF AL>F
    
    
     ADD AL,09H              
     JMP BINARY_2                
    
   DECIMAL_2:              
     CMP AL,30H    ;COMPARE AL WITH 0
     JB  JUMP       ;IF AL<0
    
     CMP AL,39H    ;COMPARE AL WITH 9
     JA  JUMP       ;IF AL>9
     JMP BINARY_2
    
   JUMP:                   
     JMP TOP           
    
   BINARY_2:                    
     INC COUNT                
    
     AND AL,0FH  ;ASCII TO BINARY
    
     MOV CL,4    ;CL=4
     SHL AL,CL   ;AL LEFT SHIFT 
    
     MOV CX,4    ;CX=4
    
   LOOP_2:                 
     SHL AL,1    ;AL SINGLE LEFT SHIFT 
     RCL BX,1    ;BX ROTATE BY 1  THROUGH CARRY 
                             
     LOOP LOOP_2  ;UNTIL CX=0
    
     CMP COUNT,34H          
     JE OUTPUT                
     JMP PROCEED_2            
    
   OUTPUT:                  
    ;PRINTING THE RESULT STRING     
    LEA DX,SUM               
    MOV AH,9
    INT 21H
    
    ADD BX,TEMP               
    JNC SKIP    ;IF  CF!=1
    MOV AH,2                    
    MOV DL,31H ;DL=1
    INT 21H                     
    
  SKIP:                       
    MOV COUNT,30H ;COUNT=0
    
  LOOP_3:                     
    XOR DL,DL     ;CLEARING DL
    MOV CX,4      ;set CX=4
    
  LOOP_4:                   
     SHL BX,1   ;BX SINGLE LEFT SHIFT
     RCL DL,1   ;DL ROTATE BY 1 THROUGH CARRY
                              
    LOOP LOOP_4  ;UNTIL CX=0
    
    MOV AH, 2                 
    
    CMP DL,9    ;COMPARE DL WITH 9
    JBE NUMBER   ;IF DL<=9
    SUB DL,9    ;CONVERT TO NUMBER
    OR DL,40H   ;CONVERT NUMBER TO LETTER
    JMP DISPLAY              
    
  NUMBER:            
    OR DL,30H   ;DECIMAL TO ASCII CODE
    
  DISPLAY:                 
    INT 21H                  
    
    INC COUNT                  
    CMP COUNT,34H             
    JNE LOOP_3   ;IF COUNT!=4
    
  EXIT:  
    ;return to DOS                        
    MOV AH,4CH                  
    INT 21H
    MAIN ENDP
END MAIN





