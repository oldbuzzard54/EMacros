﻿         MACRO
&NAME    ESTART &TYPE=CSECT,&DESC=,&VER=,&BASE=,&REGS=NO,              *
               &PLIF=
         AIF   (T'&TYPE EQ 'O').TYPERR
         AIF   (T'&VER EQ 'O').VERR
         AIF   (T'&DESC EQ 'O').DERR
         AIF   ('&TYPE' EQ 'CSECT').TYPEC
         AIF   ('&TYPE' EQ 'START').TYPES
.TYPERR  MNOTE 12,'*** TYPE MUST BE CSECT OR START ***'
         MEXIT
.VERR    MNOTE 12,'*** VER OMITTED ***'
         MEXIT
.DERR    MNOTE 12,'*** DESC OMITTED ***'
         MEXIT
.TYPEC   ANOP
&NAME    CSECT
         AGO   .OK
.TYPES   ANOP
&NAME    START
.OK      ANOP
         AIF   (T'&REGS EQ 'O').REGOK
         AIF   ('&REGS' EQ 'YES').REGOK
         AIF   ('&REGS' EQ 'NO').REGOK
         MNOTE 12,'*** REGS INVALID ***'
         MEXIT
.REGOK   ANOP
*
         AIF   (T'&PLIF EQ 'O').NOPL1
         MVI   18(15),C'N'            SET NO PLI ENTRY POINT
         B     12(15)                 SKIP HEADER STUFF
         ENTRY &PLIF
&PLIF    MVI   10(15),C'Y'            SET PL1 ENTRY POINT
         BALR  15,0
ID1&SYSNDX B     ID4&SYSNDX.(15)        SKIP HEADER STUFF
ID5&SYSNDX DS   C
IDP&SYSNDX EQU  ID5&SYSNDX-ID1&SYSNDX
         AGO   .NOPL12
.NOPL1   ANOP
ID1&SYSNDX B     ID4&SYSNDX.(15)       BRANCH AROUND IDENT CONSTANTS
.NOPL12  ANOP
         DC    AL1(ID3&SYSNDX-ID2&SYSNDX)
ID2&SYSNDX DC    CL8'&NAME'
         DC    C&VER
         DC    C' &SYSDATE &SYSTIME - '
         DC    C&DESC
         DS    0F
IDS&SYSNDX EQU   *-ID1&SYSNDX
         DS    18F
ID3&SYSNDX DS    0H
         AIF   (T'&REGS EQ 'O').NOREG
         AIF   ('&REGS' EQ 'NO').NOREG
         EREGS
.NOREG   ANOP
ID4&SYSNDX EQU   *-ID1&SYSNDX
*
         STM   14,12,12(13)
*
         LR    5,13                COPY CALLER'S SAVEAREA ADDR
         LA    13,IDS&SYSNDX.(15)  ESTABLISH MY SAVEAREA
         ST    5,4(,13)            BACK CHAIN SAVE AREAS
         ST    13,8(,5)            FORWARD CHAIN SAVE AREAS
         AIF   (T'&BASE EQ 'O').NOBASE
         BALR  &BASE.,0            ESTABLISH BASE REG VALUE
         USING *,&BASE
.NOBASE  ANOP
         AIF   (T'&PLIF EQ 'O').SKIPLI
         CLI   IDP&SYSNDX.(15),C'Y'     SET CC BASED ON PLI INDICATOR
.SKIPLI  ANOP
         MEND
         MACRO
&NAME    ERETURN &RC=
.* RETURN TO SYSTEM WITH RETURN CODE
&NAME    L     13,4(0,13)          RESET TO CALLERS SAVE AREA
         RETURN (14,12),RC=&RC
         MEND
         MACRO
&NAME    EREGS
.* SET UP REGISTER EQU
         AIF   (T'&NAME EQ 'O').NONAME
&NAME    EQU   *
.NONAME  ANOP
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
         MEND
