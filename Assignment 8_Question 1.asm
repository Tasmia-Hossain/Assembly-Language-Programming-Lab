; Write a program that lets the user type in an algebraic expression, ending with a carriage return, that contains round, square, and curly brackets.
; As the expression is being typed in, the program evaluates each character. 
; If at any point the expression is incorrectly bracketed (too many right brackets or a mismatch between left and right brackets), the program tells the user to start over. 
; After the carriage return is typed, if the expression is correct, the program displays "expression is correct." 
; If not, the program displays "too many left brackets". In both cases, the program asks the user if he or she wants to continue. 
; If the user types 'Y', the program runs again. Your program does not need to store the input string, only check it for correctness.

.MODEL SMALL
.STACK 100H
.DATA  
MSG1 DB 0DH,0AH,'Enter an Algebraic Expression : ',0DH,0AH,'$'
MSG2 DB 0DH,0AH,'Expression is Correct.$'
MSG3 DB 0DH,0AH,'Too many Left Brackets.$'
MSG4 DB 0DH,0AH,'Too many Right Brackets.$'
MSG5 DB 0DH,0AH,'Mismatch between Left and Right Brackets. Begin Again.$'
MSG6 DB 0DH,0AH,'Type 'Y' if you want to Continue : $'

.CODE
MAIN PROC
    ;initialize DS 
    MOV AX,@DATA
    MOV DS,AX 
    
  START:
    ;display MSG1
    MOV AH,9
    LEA DX,MSG1 
    INT 21H  
    
    XOR CX,CX   ;clear CX
    MOV AH,1    ;Single key Input 
    
  INPUT:
    INT 21H         ;read a character
    CMP AL,0DH      ;compare AL with CR
    JE END_INPUT    ;jump to END_INPUT if AL=CR 
    
    CMP AL,"["      ;compare AL with "["
    JE PUSH_BRACKET ;jump to PUSH_BRACKET if AL="["
    
    CMP AL,"{"      ;compare AL with "{"
    JE PUSH_BRACKET ;jump to PUSH_BRACKET if AL="{"
    
    CMP AL,"("      ;compare AL with "("
    JE PUSH_BRACKET ;jump to PUSH_BRACKET if AL="("
    
    CMP AL,")"       ;compare AL with ")"
    JE ROUND_BRACKET ;jump to ROUND_BRACKET if AL=")"
     
    CMP AL,"}"       ;compare AL with "}"
    JE CURLY_BRACKET ;jump to CURLY_BRACKET if AL="}"
    
    CMP AL,"]"        ;compare AL with "]"
    JE SQUARE_BRACKET ;jump to SQUARE_BRACKET if AL="]"
    
    JMP INPUT         ;jump to INPUT
    
  PUSH_BRACKET:
    PUSH AX     ;push AX onto the STACK
    INC CX      ;increament CX
    JMP INPUT   ;jump to INPUT
    
  ROUND_BRACKET:
    POP DX      ;pop a value from STACK into DX
    DEC CX      ;decreament CX 
    
    CMP CX,0          ;compare CX with 0
    JL RIGHT_BRACKETS ;jump to RIGHT_BRACKETS if CX<0   
    
    CMP DL,"("      ;compare DL with "("
    JNE MISMATCH    ;jump to MISMATCH if DL!="(" 
    
    JMP INPUT       ;jump to INPUT
    
  CURLY_BRACKET:
    POP DX      ;pop a value from STACK into DX
    DEC CX      ;decreament CX 
    
    CMP CX,0            ;compare CX with 0
    JL RIGHT_BRACKETS   ;jump to RIGHT_BRACKETS if CX<0 
    
    CMP DL,"{"      ;compare DL with "{"
    JNE MISMATCH    ;jump to MISMATCH if DL!="{"
    JMP INPUT       ;jump to INPUT
    
  SQUARE_BRACKET: 
    POP DX      ;pop a value from STACK into DX
    DEC CX      ;decreament CX 
    
    CMP CX,0            ;compare CX with 0
    JL RIGHT_BRACKETS   ;jump to RIGHT_BRACKETS if CX<0 
    
    CMP DL,"["      ;compare DL with "["
    JNE MISMATCH    ;jump to MISMATCH if DL!="["
    JMP INPUT       ;jump to INPUT 
    
  END_INPUT:
    CMP CX,0          ;compare CX with 0
    JNE LEFT_BRACKETS ;jump to LEFT_BRACKETS if CX!=0 
    
    ;display MSG2
    MOV AH,9    
    LEA DX,MSG2 
    INT 21H
    
    ;display MSG6 
    LEA DX,MSG6 
    INT 21H 
    
    MOV AH,1    ;Single key Input
    INT 21H    
    
    CMP AL,"Y"  ;compare AL with "Y"
    JNE EXIT    ;jump to EXIT if AL!="Y"
    JMP START   ;jump to START
    
  MISMATCH: 
    ;display MSG5
    MOV AH,9
    LEA DX,MSG5  
    INT 21H   
    
    JMP START   ;jump to START

  LEFT_BRACKETS:
    ;display MSG3 
    MOV AH,9
    LEA DX,MSG3 
    INT 21H  
    
    JMP START   ;jump to START
  
  RIGHT_BRACKETS:
    ;display MSG$ 
    MOV AH,9
    LEA DX,MSG4 
    INT 21H
    
    JMP START   ;jump to START

  EXIT:
    ;return to DOS
    MOV AH,4CH
    INT 21H 
    MAIN ENDP
END MAIN

    INT 21H
    
    JMP START   ;jump to label START

  EXIT:
    ;return to DOS
    MOV AH,4CH
    INT 21H 
    MAIN ENDP
END MAIN
