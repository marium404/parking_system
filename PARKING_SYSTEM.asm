
;                    ****************************************************
;                    *                                                  *                                        
;                    *         *** ASSEMBLY LANGUAGE PROJECT ***        *
;                    *                                                  *
;                    *--------------------------------------------------*
;                    *                                                  *
;                    *                                                  *
;                    *        >>>>  PARKING MANAGEMENT SYSTEM  <<<<     *          
;                    *                                                  *
;                    *            =============================         *
;                    *            =============================         *
;                    *                                                  * 
;                    *                      MADE BY: MARYAM ASGHAR(401) *
;                    *                                                  *
;                    *                                                  *
;                    ****************************************************  
          
          
          
          
           ;=================HEADER LIBRARY======================
 
INCLUDE "EMU8086.INC"

           ;=======================MACROS========================
PRINTME MACRO M1
    
    MOV DX,OFFSET M1
    MOV AH,9
    INT 21H   
    CALL NEWLINEE

ENDM

PRINTME1 MACRO M2
    
    MOV DX,OFFSET M2
    MOV AH,9
    INT 21H

ENDM                      

           ;====================HEADER FILES=====================
;====================CODE SIZE / SMALL REFER LESS THAN EQUAL TO 64KB===============

.MODEL SMALL

;====================STACK FOR OPERATIONS AND 100 BYTE RESERVED FOR CODE=========== 

.STACK 100H

;======================INITIALIZING OF VARIABLES===================================
.DATA
                                                                 
           ;==================VARIABLES FOR FILE_HANDLING========
           
    FNAME DB 'RECORD.TXT',0
    HANDLE DW ?
    STORE DB 300 DUP(?)
    FCOUNT DB 150 
    PNT DB '.$'
           
           ;======================MAIN MENU======================
           
    MAINMENU DW '  ',0AH,0DH

    DW ' ',0AH,0DH
    DW ' ',0AH,0DH
    DW ' ',0AH,0DH
    DW '                ****************************************************',0AH,0DH
    DW '                *                                                  *',0AH,0DH                                        
    DW '                *        ***  PARKING MANAGEMENT SYSTEM  ***       *',0AH,0DH
    DW '                *                                                  *',0AH,0DH
    DW '                *-----------------------MENU-----------------------*',0AH,0DH
    DW '                *                                                  *',0AH,0DH
    DW '                *                                                  *',0AH,0DH
    DW '                *                PRESS 1 FOR BIKE                  *',0AH,0DH
    DW '                *                PRESS 2 FOR RIKSHW                *',0AH,0DH          
    DW '                *                PRESS 3 FOR CAR                   *',0AH,0DH
    DW '                *                PRESS 4 FOR DISPLAY RECORDS       *',0AH,0DH
    DW '                *                PRESS 5 FOR DELETE RECORDS        *',0AH,0DH
    DW '                *                PRESS 6 FOR EXIT                  *',0AH,0DH 
    DW '                *                                                  *',0AH,0DH
    DW '                *                                                  *',0AH,0DH
    DW '                ****************************************************',0AH,0DH 
    DW '$',0AH,0DH 
    
           ;=======================LOGIN PANEL MENU===============
           
    STR1 DW '                ****************************************************$'
    STR2 DW '                *                                                  *$'                                        
    STR3 DW '                *       ***  PARKING MANAGEMENT SYSTEM    ***      *$'
    STR4 DW '                *----------------------LOGIN-----------------------*$'
    STR5 DW '                *         >>>ENTER USERNAME:                       *$'          
    STR6 DW '                *         >>>ENTER PASSWORD:                       *$'
    STR7 DW '                *                >>>>> WELCOME <<<<<               *$'
    STR8 DW '                *                   INVALID INPUT!                 *$'
    SPACES DW '                *                            $',13 
    SPACES2 DW '                 *$',10 
    SPACES3 DW '                *$',10
    LOAD DW '__$'
    LOADING DW '                                  $'
    
    USER DB 'ADMIN $'
    PW DB '56789 $'
    PW1 DB 'ENTER USERNAME:$'
    PW2 DB 'ENTER PASSWORD:$'
    PARKING DB 'WELCOME TO PARKING SYSTEM$'
    PW3 DB 'INVALID INPUT!$'
                                           
    NEWLINE DB 10,13,'$'                   ; FOR NEW LINE
    
    OPT DB '      >>>>> ENTER CHOICE:  $'
    SPAA DW '                         $'   ; FOR SPACES
    AMOUNT DW 0                            
    COUNT DW '0'                           ; TO COUNT VEHICLE
    
    PAY DB '      >>>>>  PLEASE PAY:  $'
    
            
                                                                                   
;==========================VARIABLES TO STORE RECORDS===============================    
    
    P1 DB 'TOTAL AMOUNT: $'
    P2 DB 'NUMBER OF VEHICLE: $'
    P3 DB 'NUMBER OF BIKES: $'
    P4 DB 'NUMBER OF CARS: $'
    P5 DB 'NUMBER OF RIKSHW: $'
    
    BB DW '0'
    RR DW '0'
    CC DW '0'

            ;=======================CODE STARTS======================
            
.CODE       


;|||||||||||||******************START MAIN PROCEDURE*******************|||||||||||||||||||
;*****************************************************************************************

MAIN PROC
    
    MOV AX,@DATA                    ; LOADS DATA              
    MOV DS,AX 
    
    CALL LOGIN                      ; CALL LOGIN PROCEDURE FUNCTION
     
     
    WHILE:
    
     
      CALL COLOR  
    
      CALL NEWLINEE 
      CALL NEWLINEE
      CALL NEWLINEE
    
      CALL M_MENU
    
      CALL NEWLINEE 
    
      PRINTME OPT
    
      PRINTME1 SPAA
    
      MOV AH,1                 ; INPUT FROM USER
      INT 21H
    
      MOV BL,AL
    
      CALL NEWLINEE
      CALL NEWLINEE
    
      MOV AL,BL                ; COMPARE INPUT
    
      CMP AL,'1'
      JE BIKE
    
      CMP AL,'2'
      JE RIKSHW
    
      CMP AL,'3'
      JE CAR
    
    
      CMP AL,'4'
      JE RECORD
      
      CMP AL,'5'
      JE DELETE
     
      CMP AL,'6'
      JE ENDD
    
      CALL NEWLINEE
    
      PRINTN "                           ------- INVALID INPUT! ------- " 
          
    
      JMP WHILE 
    
    BIKE:                            ; FOR BIKE
                                     
      CMP COUNT,'5'                  ; MAX LIMIT FOR BIKES
      JLE BKE1
        
      PRINTN "                       ------- PARKING IS FULL! ------- "
        
      JMP WHILE
   
        
      BKE1:                           
        
        PRINTME1 PAY    
        CALL NEWLINEE
        PRINTME1 SPAA
            
        MOV AX,20                   ; TICKET PRIZE
        ADD AMOUNT,AX
        MOV DX,0
        MOV BX,10
        MOV CX,0
            
      B1:
        DIV BX
        PUSH DX
        MOV DX,0
        MOV AH,0
           
        INC CX
        CMP AX,0
           
           JNE B1     
        
      B2:
        POP DX
        ADD DX,48
        MOV AH,2
        INT 21H
    
      LOOP B2
        
      INC COUNT
        
      INC BB
        
      JMP WHILE
     
        
    RIKSHW:                          ; FOR RICKSHAW
        
      CMP COUNT,'5'                  ; MAX LIMIT FOR RIKSHW
      JLE RKH1
        
      PRINTN "                       ------- PARKING IS FULL! ------- "
        
      JMP WHILE
      
        
      RKH1:
            
        PRINTME1 PAY
        CALL NEWLINEE
        PRINTME1 SPAA
                                     ; TICKET PRIZE
        MOV AX,30
        ADD AMOUNT,AX
        MOV DX,0
        MOV BX,10
        MOV CX,0 
            
            
      R1:
        DIV BX
        PUSH DX
        MOV DX,0
        MOV AH,0
           
        INC CX
        CMP AX,0
           
        JNE R1     
        
      R2:
        POP DX
        ADD DX,48
        MOV AH,2
        INT 21H
    
      LOOP R2
        
      INC COUNT
        
      INC RR
        
      JMP WHILE
  
            
                                    ; FOR CAR
    CAR:
                                    ; MAX LIMIT FOR CARS
      CMP COUNT,'5'
      JLE CAR1
        
      PRINTN "                       ------- PARKING IS FULL! ------- "
        
      JMP WHILE
     
        
      CAR1: 
        
        PRINTME1 PAY
        CALL NEWLINEE
        PRINTME1 SPAA
            
        MOV AX,50                    ; TICKET PRIZE
        ADD AMOUNT,AX
        MOV DX,0                     ; REMINDER 0
        MOV BX,10
        MOV CX,0
            
            
        C1:
          DIV BX
          PUSH DX
          MOV DX,0
          MOV AH,0
           
          INC CX
          CMP AX,0
           
          JNE C1     
        
        C2:
          POP DX
          ADD DX,48
          MOV AH,2
          INT 21H
    
        LOOP C2
        
        INC COUNT
        
        INC CC
        
        JMP WHILE
       
        
    RECORD: 
    
;|*************==========CALCULATE AMOUNT===========**************|
;|*                                                              *|
      PRINTME1 P1
      MOV AX,AMOUNT
              
      MOV DX,0
      MOV BX,10
      MOV CX,0
      
      RC1:
        DIV BX
        PUSH DX
        MOV DX,0 
              
        INC CX
        CMP AX,0
        JNE RC1 
              
      RC2:
        POP DX 
        ADD DX,48
        MOV AH,2
        INT 21H 
           
      LOOP RC2 
;|*                                                                *|
;|******************************************************************|           
      CALL NEWLINEE
      
;|**************==========NUMBER OF VEHICLE=========****************|
;|*                                                                *|
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,19
      MOV DX,OFFSET P2
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
              
;|**************==========COUNT=========****************************| 
    
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,2
      MOV DX,OFFSET COUNT
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
;|*                                                                 *|           
;********************************************************************|
              
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET PNT
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE 
              
      
;|***************==========NUMBER OF BIKES=========*****************|
;|*                                                                *|
          
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,17
      MOV DX,OFFSET P3
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE  
           
;|**************============BIKES==========*************************|
        
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET BB
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
      
;|*                                                                 *|                 
          
;|*******************************************************************|
              
      CALL WRITE_FILE 
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET PNT
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE 
              
                                                                     
;|***************==========NUMBER OF RIKHS=========*****************|
;|*                                                                *|
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,18
      MOV DX,OFFSET P5
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
                                            
;|**************============RIKHS==========*************************| 
           
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET RR
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
                                                                                      
;|*                                                                 *|                 
          
;|*******************************************************************|
              
      CALL WRITE_FILE 
              
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET PNT
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE 
                                                                          
;|****************==========NUMBER OF CARS=========******************|
;|*                                                                 *|
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,16
      MOV DX,OFFSET P4
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
                                                        
;|**************=============CARS==========**************************|  
           
         
          
        
      CALL WRITE_FILE
              
      CALL APPEND_FILE
              
      MOV CX,1
      MOV DX,OFFSET CC
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE
           
                                                                                                          
;|*                                                                 *|                 
          
;|*******************************************************************|
              
              
      CALL WRITE_FILE 
              
      CALL APPEND_FILE
      MOV CX,1
      MOV DX,OFFSET PNT
      MOV AH,40H
      INT 21H
              
      CALL CLOSE_FILE 
              
;|*********************************************************************
                                                                   
;|****************========OPEN FILE FOR READING======*****************|
;|*                                                                  *|
      MOV AH,3DH
      MOV DX,OFFSET(FNAME)
      MOV AL,0  ; 0 MEAN FOR READING PURPOSE 
      INT 21H
      MOV HANDLE,AX

      MOV AH,3FH
      MOV BX,HANDLE
      MOV DX,OFFSET(STORE)
      MOV CX,150
      INT 21H
                                                        
;|**************===========DISPLAY DATA==========*********************|
      MOV SI,OFFSET(STORE)
              
      MOV BX,OFFSET(PNT)
      MOV CX,150 
              
      PP1:
        
        CMP AL,[BX]
        JNE X
                 
        CALL NEWLINEE
                  
                  
        X: 
          MOV AH,2
          MOV DL,[SI]
          INT 21H 
                 
          INC SI
          DEC FCOUNT
          JNZ PP1
             
          CALL CLOSE_FILE 
                                                                                                
;|*                                                                 *|                 
          
;|*******************************************************************|
                   
          JMP WHILE
          JMP ENDD 
          
          
          ;************======DELETE RECORDS=========**************
          
           
      DELETE:
      
        MOV BB,'0'
        MOV RR,'0'
        MOV CC,'0'
                
        MOV AMOUNT,0
        MOV COUNT,'0'
                
        MOV AH,41H
        MOV DX,OFFSET(FNAME)
        INT 21H
                
        PRINTN "RECORDS HAVE BEEN CLEARED"
                
        CALL NEWLINEE
                
        JMP WHILE
        JMP ENDD
        
        ;****************========EXIT=========*******************
                
       ENDD: 
       
          CALL LOADD
              
          MOV AH,4CH
          INT 21H
             
                
MAIN ENDP

;|||||||||||||********************END MAIN PROCEDURE*******************|||||||||||||||||||
;*****************************************************************************************


COLOR PROC 
    
    MOV AH, 06H        ; SCROLL UP FUNCTION
    XOR AL, AL         ; CLEAR ENTIRE SCREEN
    XOR CX, CX         ; UPPER LEFT CORNER
    MOV DX, 4F4FH      ; LOWER RIGHT CORNER
    MOV BH, 1CH        ; LIGHT BLUE ON BLACK
    INT 10H 
    
    MOV AH, 02H
    MOV DH, 0H
    MOV DL, 0H
    MOV BH, 00H 
    INT 10H
     
COLOR ENDP 

NEWLINEE PROC
   
    MOV DX,OFFSET NEWLINE
    MOV AH,9
    INT 21H
RET
            
NEWLINEE ENDP


LOGIN PROC
    
    CALL COLOR
    
    CALL NEWLINEE
    CALL NEWLINEE
   
    
    PRINTME STR1
    PRINTME STR2
    PRINTME STR3
    PRINTME STR2
    PRINTME STR4
    PRINTME STR2
    PRINTME STR5
    PRINTME STR2
    
    
        ;*********************for user name***********************
    MOV SI,OFFSET USER 
    
    
    PRINTME1 SPACES    
    
   
    
    MOV CX,5
    
    UR:
        MOV AH,8                     ; 8 TO HIDE INPUT CHARACTER
        INT 21H
        
        
        CMP AL,[SI]
        JNE INV
        
        
        
        MOV DX,4                     ; ASCII CODE OF DIAMOND
        MOV AH,2
        INT 21H
        
        
        INC SI
        
        
    LOOP UR
        
        ;*********************for password*************************
        
    PRINTME SPACES2   
   
    PRINTME STR2
    PRINTME STR2
    PRINTME STR6
    
    MOV SI,OFFSET PW 
    
    
    PRINTME1 SPACES
    
    MOV CX,5
    
    UR1:
        MOV AH,8
        INT 21H
        
        CMP AL,[SI]
        JNE INV
        
        MOV DX,4
        MOV AH,2
        INT 21H
        
        INC SI
        
    LOOP UR1  
            
            
        PRINTME SPACES2
    
        PRINTME STR2
        PRINTME STR7
        PRINTME STR2 
        PRINTME STR2
        PRINTME STR1
        
        CALL NEWLINEE
       CALL LOADD
        
        JNE WHILE
        
        
    INV:                    ; INVALID INPUT
    
        CALL NEWLINEE
        PRINTME STR2
        PRINTME STR8
        PRINTME STR2
        PRINTME STR1
        
        
        JNE ENDD
    
    
    RET
    
LOGIN ENDP

;***********************MAIN MENU******************************|

M_MENU PROC
    
    CALL COLOR
    
    MOV DX,OFFSET MAINMENU
    MOV AH,9H
    INT 21H
    
    CALL NEWLINEE   
    
    
    
    RET
    
M_MENU ENDP

;|************************LOADER********************************|

LOADD PROC 
    
     ;************LOADER******************
    
    MOV DX,OFFSET LOADING
    MOV AH,9
    INT 21H 
   

    MOV BL,0EH
    MOV CX,2H
    INT 10H
    MOV AX,900H
	
    MOV DX,OFFSET LOAD
    INT 21H

    MOV BL,0AH
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H 
    
    MOV BL,07H
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H
    
    MOV BL,0FH
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H

    MOV BL,0DH
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H
  
    MOV BL,0EH
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H 
    
    MOV BL,0CH
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H
    
    MOV BL,05H
    MOV CX,2H
    INT 10H	

    MOV DX,OFFSET LOAD
    INT 21H 
    
RET    
    
LOADD ENDP 

;|*****************LOAD FILE TO WRITE**************************|

WRITE_FILE PROC
    
    MOV DX,OFFSET(FNAME)
    MOV AL,1  ; 1 MEAN FOR WRITING PURPOSE
    MOV AH,3DH 
    INT 21H
    
    RET
    
WRITE_FILE ENDP

;******************APPENDING MODE IN FILE**********************|

APPEND_FILE PROC
    
    MOV BX,AX
    MOV CX,0
    MOV AH,42H
    MOV AL,02H
    INT 21H
    
    RET
    
APPEND_FILE ENDP

;|***********************CLOSE FILE****************************| 

CLOSE_FILE PROC
    
    MOV AH,3EH
    MOV DX,HANDLE
    INT 21H
              
    RET
    
CLOSE_FILE ENDP          



;***************OPEING A NEW FILE***************;
;
;MOV AH,3CH
;MOV DX,OFFSET(FNAME) 
;MOV CL,1 ;FOR OPEN NEW FILE   
;INT 21H 
;MOV HANDLE,AX
;
;
;
;
;;***************CLOSEING A FILE***********************
;   MOV AH,3EH
;   MOV DX,HANDLE
;   INT 21H 
;        
   
END MAIN                
                      
        

