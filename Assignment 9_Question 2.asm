; Write a program that (a) lets the user input a string, (b) prints it forward and backward without punctuation and blanks on successive lines, 
; and (c) decides whether it is a palindrome and prints the conclusion.

.MODEL SMALL
.STACK 100H     
.DATA
FIRST DB 'INPUT A STRING: $'     
FORWARD DB 0DH,0AH,'THE FORWARD STRING: $'
BACKWARD DB 0DH,0AH,'THE BACKWARD STRING: $'
PAL DB 0DH,0AH,'INPUT STRING IS PALINDROME.$'
NONPAL DB 0DH,0AH,'INPUT STRING IS NOT PALINDROME.$'     
EMPTY DB 0DH,0AH,'OPPS !!! INPUT STRING IS EMPTY.$'

STR1 DB 80 DUP('$')
STR2 DB 80 DUP('$')

.CODE
MAIN PROC 
    ;initialize DS,ES
    MOV AX,@DATA
    MOV DS,AX 
    MOV ES,AX ;USING EXTRA SEGMENT 
    
    CLD       ;CLEARNG DIRECTION FLAG (DF=0)   
       
    
    MOV AH,9 
    LEA DX,FIRST                  
    INT 21H    
         
    XOR CX,CX 
    
    MOV AH,1
                            
    LEA SI,STR1
    
  INPUT: 
    INT 21H
    CMP AL,0DH
    JE ENTER_PRESSED
    
    
    CMP AL,5BH    ;3RD BRACKET OPENING
    JE INPUT
      
    CMP AL,5DH    ;3RD BRACKET CLOSING                  
    JE INPUT
              
    CMP AL,7BH    ;2ND BRACKET OPENING
    JE INPUT  
    
    CMP AL,7DH    ;2ND BRACKET CLOSING      
    JE INPUT        
    
    CMP AL,28H   ;1ST BRACKET OPENING
    JE INPUT  
    
    CMP AL,29H   ;1ST BRACKET CLOSING
    JE INPUT 
    
    
    CMP AL,21H   ;EXCLAMATION
    JE INPUT
    
    CMP AL,22H   ;QUOTATION
    JE INPUT
    
    CMP AL,27H   ;APOSTHROPHE
    JE INPUT
    
    CMP AL,' '   ;SPACE
    JE INPUT
    
    CMP AL,2CH    ;COMMA
    JE INPUT
                     
    CMP AL,2DH    ;HYPHEN
    JE INPUT
    
    CMP AL,2EH    ;DOT
    JE INPUT
    
    CMP AL,3AH   ;COLON
    JE INPUT
    
    CMP AL,3BH   ;SEMICOLON
    JE INPUT
    
    CMP AL,5FH   ;UNDERSCORE
    JE INPUT
    
    CMP AL,60H   ;SINGLE QUOTATION
    JE INPUT    
    
            
             
    PUSH AX
    INC CX
    MOV [SI],AL ;ARRAY ADDRESSING
    INC SI  
    
    JMP INPUT
    
  ENTER_PRESSED:    
    CMP CX,0
    JE ERROR
    
    LEA DI,STR2 ;DESTINATION STRING
    MOV BX,CX   ;IN LOOP CX IS USED COUNTER
    
  REVERSE:
    POP DX    
    MOV [DI],DL ;BACKWARDING
    INC DI
    LOOP REVERSE
    
    MOV AH,9
    LEA DX,FORWARD
    INT 21H  
    
    MOV AH,9
    LEA DX,STR1
    INT 21H    
       
    MOV AH,9
    LEA DX,BACKWARD
    INT 21H   
    
    MOV AH,9
    LEA DX,STR2
    INT 21H           
        
    LEA SI,STR1 ;FORWARD STRING (SOURCE)
    LEA DI,STR2 ;BACKWARD STRING (DESTINATION)
    MOV CX,BX   ;RETRIVE THE CX VALUE 
    
    REPE CMPSW  ;CHECK EQUAL OR NOT      ES:DI -DS:SI
    
    JZ PALINDROME        
    
    MOV AH,9
    LEA DX,NONPAL
    INT 21H  
    
    JMP EXIT 
    
  ERROR:
    MOV AH,9
    LEA DX,EMPTY  ;IF THE STRING EMPTY
    INT 21H
    
    JMP EXIT
    
  PALINDROME:
    MOV AH,9
    LEA DX,PAL    ;PRINTING THE CONFIRMATION 
    INT 21H  
    
  EXIT:    
    MOV AH,4CH
    INT 21H
    MAIN ENDP              
END MAIN 
 
