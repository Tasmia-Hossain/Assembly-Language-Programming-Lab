; Write a program that prompts the user to type a hex number of four hex digits or less, and outputs it in binary on the next line. 
; If the user enters an illegal character, he or she should be prompted to begin again. Accept only uppercase letters. 
; Your program may ignore any input beyond four characters.

.MODEL SMALL
.STACK 100H
.DATA 

INPUT DB 'ENTER A MAXIMUM 4 DIGIT HEX NUMBER (A-B OR 0-9): $'
BINARY DB 0DH,0AH,'THE BINARY FORM: $'
ILLEGAL DB 0DH,0AH,'OPPS!!ILLEGAL INPUT.PLEASE TRY AGAIN: $'
TEMP DB ?
 
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
    ;display msg for illegal character input                 
    LEA DX,ILLEGAL           
    MOV AH,9
    INT 21H
    
  BEGIN:  
    ;clearing BX and initialize TEMP=0                    
    XOR BX,BX                 
    MOV TEMP,30H              
    
  PROCEED:                  
    MOV AH,1                 
    INT 21H                    
    
    CMP AL,0DH      ;COMPARE WITH CARRIAGE RETURN
    JNE NO_ENTER    ;JUMP IF  AL!=CR
    
    CMP TEMP,30H    ;COMPARE TEMP 
    JBE TOP         ;JUMP IF TEMP<=0
    JMP BINARY_PRINT                  
    
  NO_ENTER:                     
    CMP AL,"A"  ;COMPARE AL WITH "A"
    JB DECIMAL  ;if AL<65
    
    CMP AL,"F"  ;COMPARE AL WITH "F"
    JA TOP      ;if AL>70   
    
    ADD AL,09H                
    JMP BINARY_START                    
    
  DECIMAL:                  
     CMP AL,30H              
     JB TOP  ;if AL<0
    
     CMP AL,39H              
     JA TOP  ;if AL>9
    
  BINARY_START:                           
    INC TEMP                  
    
    AND AL,0FH  ;ASCII TO BINARY NUMBER
    
    MOV CL,4    ;CL=4
    SHL AL,CL   ;AL SHIFT LEFT 4 POSITIONS
    
    MOV CX,4 ;CX=4
    
  LOOP_1:                   
    SHL AL,1    ;AL LEFT SHIFT
    RCL BX,1    ;BX CARRY LEFT ROTAATE
                              
    LOOP LOOP_1 ;UNTIL CX=0
    
    
    CMP TEMP,34H              
    JE BINARY_PRINT                    
    JMP PROCEED              
    
  BINARY_PRINT:
    ;input binary msg                            
    LEA DX,BINARY             
    MOV AH,9                    
    INT 21H
    
    MOV CX,16    ;CX=16
    MOV AH,2                   
                                                                
  PRINT:                     
    SHL BX,1    ;BX LEFT SHIFT BY 1
    JC ONE      ;if CF=1
    MOV DL,30H  ;set DL=0
    JMP DISPLAY              
    
  ONE:                      
    MOV DL,31H   ;DL=1                     
    
  DISPLAY:                  
    INT 21H                  
    LOOP PRINT   ;UNTIL CX=0


  EXIT: 
    ;return to DOS
    MOV AH,4CH  
    INT 21H
    MAIN ENDP
END MAIN
