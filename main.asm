INCLUDE Irvine32.inc

.data
    ; Game Variables
    cookieCount DWORD 0 ; Total Cookies
    cookiePower DWORD 0 ; Cookies per Click
    cookiePowerPrice DWORD 10 ; Price for Upgrading Cookie Power
    autoCookie DWORD 0 ; Auto Cookies per Second
    autoCookiePrice DWORD 50 ; Price for Auto Cookie Generator

    ; Message Strings
    cookieMsg BYTE "Cookies: ", 0
    cookiePowerMsg BYTE "Cookies Power: ", 0
    cookiePowerPriceMsg BYTE "[1] Buy Cookie Power: ", 0
    autoCookieMsg BYTE "Auto Cookies: ", 0
    autoCookiePriceMsg BYTE "[2] Buy Auto Cookie: ", 0
    controlMsg BYTE "[Spacebar] to add cookie, [Q] Quit Game", 0

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

    ; Display auto cookie count
    mov edx, OFFSET autoCookieMsg
    call WriteString
    mov eax, autoCookie
    call WriteDec
    call Crlf

    ; Display auto cookie price
    mov edx, OFFSET autoCookiePriceMsg
    call WriteString
    mov eax, autoCookiePrice
    call WriteDec
    call Crlf

    ; Display control instructions
    mov edx, OFFSET controlMsg
    call WriteString
    call Crlf

    exit

main ENDP
END main
