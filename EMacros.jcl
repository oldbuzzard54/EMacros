         MACRO                                                          00000001
&NAME    ESTART &TYPE=CSECT,&DESC=,&VER=,&BASE=,&REGS=NO,              *00000002
               &PLIF=                                                   00000003
         AIF   (T'&TYPE EQ 'O').TYPERR                                  00000004
         AIF   (T'&VER EQ 'O').VERR                                     00000005
         AIF   (T'&DESC EQ 'O').DERR                                    00000006
         AIF   ('&TYPE' EQ 'CSECT').TYPEC                               00000007
         AIF   ('&TYPE' EQ 'START').TYPES                               00000008
.TYPERR  MNOTE 12,'*** TYPE MUST BE CSECT OR START ***'                 00000009
         MEXIT                                                          00000010
.VERR    MNOTE 12,'*** VER OMITTED ***'                                 00000011
         MEXIT                                                          00000012
.DERR    MNOTE 12,'*** DESC OMITTED ***'                                00000013
         MEXIT                                                          00000014
.TYPEC   ANOP                                                           00000015
&NAME    CSECT                                                          00000016
         AGO   .OK                                                      00000017
.TYPES   ANOP                                                           00000018
&NAME    START                                                          00000019
.OK      ANOP                                                           00000020
         AIF   (T'&REGS EQ 'O').REGOK                                   00000021
         AIF   ('&REGS' EQ 'YES').REGOK                                 00000022
         AIF   ('&REGS' EQ 'NO').REGOK                                  00000023
         MNOTE 12,'*** REGS INVALID ***'                                00000024
         MEXIT                                                          00000025
.REGOK   ANOP                                                           00000026
*                                                                       00000027
         AIF   (T'&PLIF EQ 'O').NOPL1                                   00000028
         MVI   18(15),C'N'            SET NO PLI ENTRY POINT            00000029
         B     12(15)                 SKIP HEADER STUFF                 00000030
         ENTRY &PLIF                                                    00000031
&PLIF    MVI   10(15),C'Y'            SET PL1 ENTRY POINT               00000032
         BALR  15,0                                                     00000033
ID1&SYSNDX B     ID4&SYSNDX.(15)        SKIP HEADER STUFF               00000034
ID5&SYSNDX DS   C                                                       00000035
IDP&SYSNDX EQU  ID5&SYSNDX-ID1&SYSNDX                                   00000036
         AGO   .NOPL12                                                  00000037
.NOPL1   ANOP                                                           00000038
ID1&SYSNDX B     ID4&SYSNDX.(15)       BRANCH AROUND IDENT CONSTANTS    00000039
.NOPL12  ANOP                                                           00000040
         DC    AL1(ID3&SYSNDX-ID2&SYSNDX)                               00000041
ID2&SYSNDX DC    CL8'&NAME'                                             00000042
         DC    C&VER                                                    00000043
         DC    C' &SYSDATE &SYSTIME - '                                 00000044
         DC    C&DESC                                                   00000045
         DS    0F                                                       00000046
IDS&SYSNDX EQU   *-ID1&SYSNDX                                           00000047
         DS    18F                                                      00000048
ID3&SYSNDX DS    0H                                                     00000049
         AIF   (T'&REGS EQ 'O').NOREG                                   00000050
         AIF   ('&REGS' EQ 'NO').NOREG                                  00000051
         EREGS                                                          00000052
.NOREG   ANOP                                                           00000053
ID4&SYSNDX EQU   *-ID1&SYSNDX                                           00000054
*                                                                       00000055
         STM   14,12,12(13)                                             00000056
*                                                                       00000057
         LR    5,13                COPY CALLER'S SAVEAREA ADDR          00000058
         LA    13,IDS&SYSNDX.(15)  ESTABLISH MY SAVEAREA                00000059
         ST    5,4(,13)            BACK CHAIN SAVE AREAS                00000060
         ST    13,8(,5)            FORWARD CHAIN SAVE AREAS             00000061
         AIF   (T'&BASE EQ 'O').NOBASE                                  00000062
         BALR  &BASE.,0            ESTABLISH BASE REG VALUE             00000063
         USING *,&BASE                                                  00000064
.NOBASE  ANOP                                                           00000065
         AIF   (T'&PLIF EQ 'O').SKIPLI                                  00000066
         CLI   IDP&SYSNDX.(15),C'Y'     SET CC BASED ON PLI INDICATOR   00000067
.SKIPLI  ANOP                                                           00000068
         MEND                                                           00000069
         MACRO                                                          00000001
&NAME    ERETURN &RC=                                                   00000002
.* RETURN TO SYSTEM WITH RETURN CODE                                    00000003
&NAME    L     13,4(0,13)          RESET TO CALLERS SAVE AREA           00000004
         RETURN (14,12),RC=&RC                                          00000005
         MEND                                                           00000006
         MACRO                                                          00000001
&NAME    EREGS                                                          00000002
.* SET UP REGISTER EQU                                                  00000003
         AIF   (T'&NAME EQ 'O').NONAME                                  00000004
&NAME    EQU   *                                                        00000005
.NONAME  ANOP                                                           00000006
R0       EQU   0                                                        00000007
R1       EQU   1                                                        00000008
R2       EQU   2                                                        00000009
R3       EQU   3                                                        00000010
R4       EQU   4                                                        00000011
R5       EQU   5                                                        00000012
R6       EQU   6                                                        00000013
R7       EQU   7                                                        00000014
R8       EQU   8                                                        00000015
R9       EQU   9                                                        00000016
R10      EQU   10                                                       00000017
R11      EQU   11                                                       00000018
R12      EQU   12                                                       00000019
R13      EQU   13                                                       00000020
R14      EQU   14                                                       00000021
R15      EQU   15                                                       00000022
         MEND                                                           00000023
