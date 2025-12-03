INCLUDE Irvine32.inc

.data
    ; Game Variables
    cookieCount DWORD 0 ; Total Cookies
    cookiePower DWORD 1 ; Cookies per Click
    cookiePowerPrice DWORD 10 ; Price for Upgrading Cookie Power
    autoCookie DWORD 0 ; Auto Cookies per Second
    autoCookiePrice DWORD 50 ; Price for Auto Cookie Generator
    
    ; Timer Variables
    lastTime DWORD 0 ; Last time auto cookies were added
    currentTime DWORD 0 ; Current time
    autoInterval DWORD 10000 ; 10 seconds in milliseconds
    
    ; Display flag
    needsRedraw BYTE 1 ; 1 = needs redraw, 0 = no redraw needed

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
    
    ; Initialize the timer with current time
    call GetMseconds
    mov lastTime, eax
    
    ; Force initial display
    mov needsRedraw, 1

gameLoop:
    ; Check if 10 seconds have passed
    call GetMseconds
    mov currentTime, eax
    
    ; Calculate time elapsed
    mov eax, currentTime
    sub eax, lastTime
    cmp eax, autoInterval
    jl skipAutoAdd  ; Less than 10 seconds, skip adding auto cookies
    
    ; Add auto cookies to total
    mov eax, autoCookie
    add cookieCount, eax
    
    ; Update lastTime
    mov eax, currentTime
    mov lastTime, eax
    
    ; Mark that we need to redraw
    mov needsRedraw, 1

skipAutoAdd:
    ; Only redraw if needed
    cmp needsRedraw, 1
    jne skipDisplay
    
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
    
    ; Clear the redraw flag
    mov needsRedraw, 0

skipDisplay:
    ; Small delay to prevent excessive CPU usage
    mov eax, 50  ; 50ms delay
    call Delay
    
    ; Use ReadKey (non-blocking) to check for key press
    call ReadKey
    jz gameLoop  ; Zero flag set = no key pressed, continue loop

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
    mov needsRedraw, 1  ; Mark for redraw
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
    
    ; Mark for redraw
    mov needsRedraw, 1
    
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
    
    ; Mark for redraw
    mov needsRedraw, 1
    
    jmp gameLoop

quitGame:
    exit

main ENDP
END main
