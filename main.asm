INCLUDE Irvine32.inc

.data
    cookieCount DWORD 0 ; Total Cookies
    cookieMsg BYTE "Cookies: ", 0

.code
main PROC
    ; Display total cookies
    mov edx, OFFSET cookieMsg
    call WriteString

    ; Display the number stored in cookieCount
    mov eax, cookieCount
    call WriteDec

    call Crlf
    exit

main ENDP
END main
