;Write a program to read two decimal digits whose sum is less than 10 and display them and their sum in the next line with an appropriate message.

.MODEL SMALL
.STACK 100
.DATA

MSG1 DB 'ENTER FIRST DECIMAL DIGIT: $'
MSG2 DB 'ENTER SECOND DECIMAL DIGIT: $'
MSG3 DB 'ENTERED TWO DECIMAL DIGITS: $'
MSG4 DB 'SUM: $'
MSG5 DB 'THE SUM IS LESS THAN 10.$'
MSG6 DB 'THE SUM IS GREATER THAN 10.$'

.CODE
MAIN PROC
    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX
    
    ;display message 1
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    ;input first decimal digit              
    MOV AH,1
    INT 21H
    SUB AL,48   ;convert ASCII to Decimal
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
    
    ;input second decimal digit              
    MOV AH,1
    INT 21H
    SUB AL,48   ;convert ASCII to Decimal
    MOV BH,AL  
    
    
    ;go to a new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
       

    ;sum of 2 decimal numbers
    ADD BH, BL 

    
    MOV BL,10
    
    CMP BH, BL
    JL SUM_LESS_THAN_10
    JMP GREATER_THAN_10
    
SUM_LESS_THAN_10: 

    ;output the sum
    LEA DX,MSG4
    MOV AH,9
    INT 21H

    MOV AH,2
    ADD BH,48
    MOV DL,BH
    INT 21H  
          
    ;go to a new line
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;print message for sum less than 10
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    JMP EXIT 
    
GREATER_THAN_10: 
     
    ;print message for sum greater than 10
    LEA DX,MSG6
    MOV AH,9
    INT 21H

EXIT:
    ;return to DOS
    MOV AH,4CH
    INT 21H
    END MAIN
