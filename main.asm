INCLUDE Irvine32.inc

.data
    ; Game Variables
    cookieCount DWORD 0 ; Total Cookies
    cookiePower DWORD 1 ; Cookies per Click
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
    
    ; For clearing lines
    clearLine BYTE "                                        ", 0

.code
main PROC
    ; Clear screen once at the start
    call ClrScr

gameLoop:
    ; Move cursor to top-left (row 0, col 0)
    mov dh, 0
    mov dl, 0
    call Gotoxy

    ; Display total cookies
    mov edx, OFFSET cookieMsg
    call WriteString
    mov eax, cookieCount
    call WriteDec
    mov edx, OFFSET clearLine  ; Clear rest of line
    call WriteString
    call Crlf

    ; Display cookie power
    mov edx, OFFSET cookiePowerMsg
    call WriteString
    mov eax, cookiePower
    call WriteDec
    mov edx, OFFSET clearLine
    call WriteString
    call Crlf

    ; Display cookie power upgrade price
    mov edx, OFFSET cookiePowerPriceMsg
    call WriteString
    mov eax, cookiePowerPrice
    call WriteDec
    mov edx, OFFSET clearLine
    call WriteString
    call Crlf

    ; Display auto cookie count
    mov edx, OFFSET autoCookieMsg
    call WriteString
    mov eax, autoCookie
    call WriteDec
    mov edx, OFFSET clearLine
    call WriteString
    call Crlf

    ; Display auto cookie price
    mov edx, OFFSET autoCookiePriceMsg
    call WriteString
    mov eax, autoCookiePrice
    call WriteDec
    mov edx, OFFSET clearLine
    call WriteString
    call Crlf

    ; Display control instructions
    mov edx, OFFSET controlMsg
    call WriteString
    call Crlf

    ; Read user input
    call ReadChar

    ; If user presses 'q' or 'Q', quit the game
    cmp al, 'q'
    je quitGame
    cmp al, 'Q'
    je quitGame

    ; If user presses '1', buy cookie power
    cmp al, '1'
    je buyCookiePower

    ; If user presses '2', buy auto cookie
    cmp al, '2'
    je buyAutoCookie

    ; If user presses spacebar, add cookies
    cmp al, ' '
    jne gameLoop
    mov eax, cookiePower
    add cookieCount, eax
    jmp gameLoop

buyCookiePower:
    ; Check if user has enough cookies
    mov eax, cookieCount
    cmp eax, cookiePowerPrice
    jl gameLoop  ; Not enough cookies, go back to game loop
    
    ; Subtract the price from cookieCount
    mov eax, cookiePowerPrice
    sub cookieCount, eax
    
    ; Increment cookiePower by 1
    inc cookiePower
    
    ; Double the cookiePowerPrice
    mov eax, cookiePowerPrice
    shl eax, 1  ; Left shift by 1 = multiply by 2
    mov cookiePowerPrice, eax
    
    jmp gameLoop

buyAutoCookie:
    ; Check if user has enough cookies
    mov eax, cookieCount
    cmp eax, autoCookiePrice
    jl gameLoop  ; Not enough cookies, go back to game loop
    
    ; Subtract the price from cookieCount
    mov eax, autoCookiePrice
    sub cookieCount, eax
    
    ; Add 5 to autoCookie
    add autoCookie, 5
    
    ; Double the autoCookiePrice
    mov eax, autoCookiePrice
    shl eax, 1  ; Left shift by 1 = multiply by 2
    mov autoCookiePrice, eax
    
    jmp gameLoop

quitGame:
    exit

main ENDP
END main
