include irvine32.inc

.data
line byte "                                                    Linear Graph Plotter  ",0,13h,10h
line1 byte "  Model Equation:   Y=(A/B)*X+C",0,13h,10h
inputStr1 db "  Enter the value of A: ", 0
inputStr2 db "  Enter the value of B: ", 0
inputStr3 db "  Enter the value of C: ", 0
resultStr db "Result: ", 0
space BYTE " "
xline BYTE "-"
dot BYTE "*"
yline BYTE "|"
num dword 60
myArray REAL8 210 DUP(?) 
slope REAL8 ?
intercept REAL8 ?
constant REAL8 ?
X REAL8 ?
result REAL8 ?
num1 dword 1
num4 dword 45
oo REAL8 0.4
pp REAL8 0.0 
myInt dword ?
.code
main PROC
    mov eax, 0
    call clrscr
    

    mov edx, offset line
    call writestring
    call crlf
    
    mov edx, offset line1
    call writestring
    call crlf
    
    mov edx, OFFSET inputStr1
    call WriteString
    call ReadFloat
    fld st(0)
    fstp slope
    
    mov edx, OFFSET inputStr2
    call WriteString
    call ReadFloat
    fld st(0)
    fstp intercept
    
    mov edx, OFFSET inputStr3
    call WriteString
    call ReadFloat
    fld st(0)
    fstp constant
    
    finit
    mov ecx, 196
    mov esi, OFFSET myArray
    fld PP
    fstp X
    mov edx, OFFSET resultStr
    
l1:
finit
    fld X
    fmul slope
    fdiv intercept
    fadd constant
    fstp result
    fld X
    fld result
    fstp DWORD PTR [esi]
    add esi, 4
    fld X
    fadd oo
    fstp X
    dec ecx
    jne l1
    
        mov ecx, 196         
    mov esi, OFFSET myArray 
  
output_loop:
 finit
    fld DWORD PTR [esi]    
    call WriteFloat        
    call Crlf               
    add esi, 4              
    loop output_loop

call crlf
mov ecx,0
mov edx,0
mov esi,0
.WHILE ecx < 50
     mov ebx,0
     mov edx,0
     .IF ecx == 45
        call crlf
        .WHILE edx<211
           mov al, xline
           call writechar
           inc edx
        .ENDW
     .ENDIF
     .IF ecx==46
        .WHILE edx<95
           .IF edx<27
              mov al,0
              mov al,space
              call writechar
           .ENDIF
           .iF edx==27
              mov al,0
              mov al, yline
              call writechar
           .ENDIF
           .iF edx>27
              mov eax, 0
              mov eax,num1
              call writeint
              inc num1
           .endif
           inc edx
        .ENDW
     .ENDIF
     call crlf
     mov esi,OFFSET myArray
     .WHILE ebx < 200
        .If ebx==13 && ecx<45
           mov eax, 0
           mov eax,num4
           call writeint
           dec num4
        .Endif
        .IF ebx == 14 && ecx<=35 
           mov al,0
           mov al, yline
           call writechar
        .ENDIF
        .IF ebx == 15 && ecx>35 && ecx<45
           mov al,0
           mov al, yline
           call writechar
        .ENDIF
        .IF ebx == 17 && ecx>=45
           mov al,0
           mov al, yline
           call writechar
        .ENDIF
        mov eax,0
        .IF ebx>15
           finit
           fld dword PTR [esi]
           fist myInt
           mov eax,0
           mov num,45
           sub num,ecx
           mov eax,0
           mov eax,num
           add esi,4
        .ENDIF
        .IF ebx>15 && ecx<45 && myInt==eax 
           mov eax,0
           mov al,0
           mov al,dot
           call writechar        
        .ELSE
            mov al,0
            mov al,space
            call writechar
        .ENDIF
        inc ebx
     .ENDW
     inc ecx
.ENDW
call readint
exit
main endp
end main