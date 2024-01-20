OUTPUT_DECIMAL PROC
    PUSH BX     ;push BX onto the STACK
    PUSH CX     ;push CX onto the STACK
    PUSH DX     ;push DX onto the STACK 
    
    CMP AX,0    ;compare AX with 0
    JGE START   ;jump to label START if AX>=0 
    
    PUSH AX     ;push AX onto the STACK 
    
    MOV AH,2    ;single character output
    MOV DL,"-"  ;set DL='-'
    INT 21H 
    
    POP AX      ;pop a value from STACK into AX
    
    NEG AX      ;take 2\'s complement of AX  
    
  START: 
    XOR CX,CX   ;clear CX
    MOV BX,10   ;set BX=10
    
  OUTPUT: 
    XOR DX,DX   ;clear DX
    DIV BX      ;divide AX by BX
    PUSH DX     ;push DX onto the STACK
    INC CX      ;increment CX
    OR AX, AX   ;take OR of Ax with AX
    JNE OUTPUT  ;jump to label OUTPUT if ZF=0  
    
    MOV AH,2    ;single character output
    
  DISPLAY: 
    POP DX       ;pop a value from STACK to DX
    OR DL, 30H   ;convert decimal to ascii code
    INT 21H 
    LOOP DISPLAY ;jump to label @DISPLAY if CX!=0 
    
    POP DX      ;pop a value from STACK into DX
    POP CX      ;pop a value from STACK into CX
    POP BX      ;pop a value from STACK into BX
    
    RET
OUTPUT_DECIMAL ENDP    
