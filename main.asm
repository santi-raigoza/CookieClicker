INCLUDE Irvine32.inc

.data
    ; Game Variables
    cookieCount DWORD 0 ; Total Cookies
    cookiePower DWORD 0 ; Cookies per Click
    cookiePowerPrice DWORD 10 ; Price for Upgrading Cookie Power

    ; Message Strings
    cookieMsg BYTE "Cookies: ", 0
    cookiePowerMsg BYTE "Cookies Power: ", 0
    cookiePowerPriceMsg BYTE "[1] Buy Cookie Power: ", 0

.code
main PROC
    ; Display total cookies
    mov edx, OFFSET cookieMsg
    call WriteString
    mov eax, cookieCount
    call WriteDec
    call Crlf

    ; Display cookie power
    mov edx, OFFSET cookiePowerMsg
    call WriteString
    mov eax, cookiePower
    call WriteDec
    call Crlf

    ; Display cookie power upgrade price
    mov edx, OFFSET cookiePowerPriceMsg
    call WriteString
    mov eax, cookiePowerPrice
    call WriteDec
    call Crlf
    exit

main ENDP
END main
