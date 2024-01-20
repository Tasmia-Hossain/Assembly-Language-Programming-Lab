; Suppose the class records are stored as follows:
; CLASS
; DB ‘MARY ALLEN’, 67, 45, 98, 33
; DB ‘SCOTT BAYLIS’, 70, 56, 87, 44
; DB ‘GEORGE FRANK', 82, 72, 89, 40
; DB ‘SAM WONG', 78, 76, 92, 60
; Each name occupies 12 bytes. Write a program to print the name of each student and his or her average (truncated to an integer) for the four exams.

.MODEL SMALL
.STACK 100H
.DATA           

RESULT DB 'Average Marks Of The Students Are: ',0DH,0AH,'$'

AVERAGE DW 4 DUP(0)
CLASS   DB 'MARY ALLEN  ',67,45,98,33
        DB 'SCOTT BAYLIS',70,56,87,44
        DB 'GEORGE FRANK',82,72,89,40
        DB 'SAM WONG    ',78,76,92,60

.CODE
MAIN PROC  
    ;initialize DS
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DI,AVERAGE  ;DI=OFFSET ADDRESS OF AVERAGE
    LEA SI,CLASS    ;SI=OFFSET ADDRESS OF  CLASS 
    ADD SI,12       ;SKIP NAME PART
    MOV CX,4        ;4 ROWS/PERSON
    
  GET_AVERAGE:            
    XOR AX,AX                 
    MOV DX,4        ;[4 SUBJECT]
    
  GET_SUM:                     
    XOR BH,BH              
    MOV BL,[SI]     ;CLASS ARRAY
    
    ADD AX,BX              
    
    INC SI          ;ACCESSING NEXT ELEMENT OF CLASS ARRAY
    DEC DX                  
    JNZ GET_SUM     ;IF DX!=0
    
    MOV BX,4        ;FOR Avg
    DIV BX          ;AX=DX:AX/BX , DX=DX:AX%BX
    
    MOV [DI],AX     ;[DI]=AX
    ADD DI,2        ;ACCESSING NEXT ELEMENT  OF AVG ARRAY
    ADD SI,12       ;SKIP THE NAME PART  OF CLASS ARRAY          
    
    LOOP GET_AVERAGE ;UNTIL CX!=0
                                                                               
    LEA DX,RESULT           
    MOV AH,9                     
    INT 21H
    
    LEA SI,AVERAGE  ;SI=OFFSET ADDRESS OF  AVERAGE
    LEA DI,CLASS    ;DI=OFFSET ADDRESS OF  CLASS
    MOV CX,4        ;4 ROWS/PERSON
    
  PRINT_RESULT:               
    MOV BX,12       ;BX=12      [ FOR NAME]
    MOV AH,2                  
    
  STU_NAME:                    
    MOV DL,[DI]     ;DL=[DI]        [ CLASS ARRAY]
    INT 21H                  
    
    INC DI          ;NEXT ELEMENT OF CLASS ARRAY
    DEC BX                  
    JNZ STU_NAME    ;IF BX!=0
    
    MOV DL,20H      ;DL=20H
    INT 21H                   
    
    MOV DL,"="               
    INT 21H                    
    
    MOV DL,20H      ;DL=20H
    INT 21H                   
    
    XOR AH,AH                 
    MOV AL,[SI]     ;AL=[SI]
    
    CALL OUTDEC              
    
    ;go to new line
    MOV AH,2                 
    MOV DL,0DH                
    INT 21H                        
    MOV DL,0AH                
    INT 21H
    
    ADD SI,2           ;ACCSSING NEXT ELEMENT IN AVG ARRAY
    ADD DI,4           ;SKIP THE SUBJECT NUMBER PART IN CLASS ARRAY
    LOOP PRINT_RESULT  ;UNTIL CX!=0
    
    MOV AH,4CH                 
    INT 21H
    MAIN ENDP 



OUTDEC PROC 

    PUSH BX                        
    PUSH CX                       
    PUSH DX                        
    
    XOR CX,CX                     
    MOV BX,10                    
    
  OUTPUT:                      
    XOR DX,DX                   
    DIV BX     ;AX\BX
    PUSH DX                      
    INC CX                       
    OR AX,AX                    
    JNE OUTPUT ;IF ZF=0
    
    MOV AH,2                      
    
  PRINT:                      
    POP DX                      
    OR DL,30H  ;CONVERT DECIMAL TO ASCII
    INT 21H                      
    LOOP PRINT ;IF CX!=0
    
    POP DX                         
    POP CX                         
    POP BX  
                           
    RET                                                      
    OUTDEC ENDP
END MAIN
    

    
  PRINT:                      
    POP DX                      
    OR DL,30H                   ;CONVERT DECIMAL TO ASCII
    INT 21H                      
    LOOP PRINT                     ;IF CX!=0
    
    POP DX                         
    POP CX                         
    POP BX                         
                              
    RET                            ;RETURN
                           
    DECIMAL_PRINT ENDP
END MAIN
    
