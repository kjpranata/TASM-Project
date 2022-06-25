.model small
.stack 100h
.data 
    ;//For Main Menu 
	menu db 'Main Menu',10,13
	db '1. Number Pattern',10,13
	db '2. Design Pattern',10,13
	db '3. Box Type Pattern',10,13
	db '4. Nested Loop Pattern',10,13
    db '0. Exit',10,13
	db 'Enter Choice : $'

    ;//For Continue or Not
	continue db 'Continue (Y/N)?',10,13
	db 'Choice : $'

    ;;For Exit
    exit db 'Good Bye ~!$'

    ;;// Declare Variables for Number 4
    pointer db 0
    bh2 db 0
    loop4 db 0
    mov loop4,0

.code
main proc
    ;print string
	showstring Macro str
		mov ah,9h
		lea dx, str
		int 21h
	endm

	;print char
	showchar Macro char
		mov ah,2
		mov dl, char
		int 21h
	endm

	;enter new line
	nextline Macro
        showchar 10;
	endm

	;read character
	inputchar Macro
		mov ah, 1
		int 21h
	endm

	;read string
	inputstring Macro str
		mov ah, 0Ah
		lea dx, str
		int 21h
	endm

	;clear screen	
	cls Macro
		mov ah, 0h
		mov al, 03h
		int 10h
	endm

	mov ax,@data
	mov ds,ax
    w
    ;print main menu function and read user input 
	printmenu:
		cls
		showstring menu
		inputchar	;read user iput
		mov bl,al
		cmp bl,'1'	
		je choice1	;print first option
		cmp bl,'2'	
		je cchoice2	;print second option
		cmp bl,'3'
		je cchoice3 ;print third option
		cmp bl,'4'
		je cchoice4	;print fourth option
		cmp bl,'0'
        je ddone
        jne printmenu

    ;print continue function and read user input
	printcontinue:
		showstring continue
		inputchar
        cmp al,'n'
		je ddone
        cmp al,'y'
        je printmenu
        nextline
        jne printcontinue

    ;//These 3 functions just for checkpoint to jump
    cchoice3:
        jmp choice3

    cchoice4:
        jmp choice4
    
    ddone:
        jmp done

    ;//If choice is 1
    choice1:
        ;//Declaring variable for upper part
        nextline
        mov cl, 9 
        mov bh, 9
        mov dh, 1 ;;for row
        mov bl, 0 ;;Counter
        mov ch, 0
    
    ;//Print spaces
    blank1:
        inc bl
        showchar ' '
        cmp bl,bh ;//As long as bl is not equal to bh, print space
        jne blank1
        mov bl,0
        mov al, 47
    
    ;//Print left upper part function
    leftupper:
        inc bl
        inc al
        showchar al ;//Print the numbers in left right side
        cmp bl,dh
        jne leftupper
        mov bl,0
    
    ;//Print right upper part function
    rightupper:
        cmp bl,ch
        je skip
        inc bl
        dec al
        showchar al ;//Print the numbers in upper right side
        jne rightupper
    
    ;//Check point for choice2
    cchoice2:
        jmp choice2
    
    ;//Check point to skip
    skip:
        mov bl,0
    
    ;//Print spaces
    blank2:
        inc bl
        showchar ' '
        cmp bl,bh
        jne blank2
        mov bl,0
        nextline
        dec bh
        dec cl
        inc dh
        inc ch
        cmp cl,0
        jne blank1
    
    ;//Declaring variable for lower part
    bottom:
        mov cl, 8 
        mov dh, 8 
        mov ch, 7
        mov ah, 2
        mov bh, 1 
        mov bl, 0 
        showchar ' '

    ;//Print spaces
    blank3:
        inc bl
        showchar ' ' ;//Print spaces until bl equal to bh
        cmp bl,bh
        jne blank3
        mov bl,0
        mov al, 47

    ;//Print left lower part function 
    leftlower:
        inc bl
        inc al
        showchar al ;//Print numbers
        cmp bl,dh
        jne leftlower
        mov bl,0
    
    ;//Print right lower part function
    rightlower:
        cmp bl,ch
        je skip2
        inc bl
        dec al
        showchar al ;//Print numbers
        jne rightlower
    
    ;//Skip jump checkpoint
    skip2:
        mov bl,0
    
    ;//Print spaces
    blank4:
        inc bl
        showchar ' ' ;//Print spaces until bh equal to bh
        cmp bl,bh
        jne blank4
        mov bl,0
        nextline
        showchar ' '
        inc bh
        dec cl
        dec dh
        dec ch
        cmp cl,0
        jne blank3
        jmp printcontinue

    ;//If choice is 2
    choice2:
        ;//Declaring variables
        nextline
        mov bh,0 ;//Line counter for main function
        mov ch,0
        mov cl,0
        mov dh,0 ;//Line counter for jump
        jmp mainc2

        ;//Main function of choice 2
        mainc2:
            ;//Increment variable bh and printing each line one by one accordingly
            inc bh
            cmp bh,1
            je line1c2
            cmp bh,2
            je lline2c2
            cmp bh,3
            je lline3c2
            cmp bh,4
            je lline4c2
            cmp bh,5
            je lline3c2
            cmp bh,6
            je lline2c2
            cmp bh,7
            je line1c2
            jmp printcontinue

        ;//Printing space function
        printspace:
            showchar ' '
            ;//Jump based on the line that is using the function
            cmp dh,1
            je line1c2
            cmp dh,2
            je line2c2
            cmp dh,3
            je lline3c2
            cmp dh,4
            je lline4c2

        ;//Printing hashtag function
        printpagar:
            showchar '#'
            ;//Jump based on the line that is using the function
            cmp dh,1
            je line1c2
            cmp dh,2
            je line2c2
            cmp dh,3
            je line3c2
            cmp dh,4
            je lline4c2
        
        ;//These two functions is jump checkpoints 
        lline2c2:
            jmp line2c2

        lline3c2:
            jmp line3c2
        
        ;//Function to print line 1
        line1c2:
            inc cl
            mov dh,1 ;//Line sign
            cmp cl,4
            jl printspace ;//cl Lower than 4 print space
            cmp cl,6
            jl printpagar ;//cl lower than 6 print hashtag
            cmp cl,8
            jl printspace ;//cl lower than 8 print spaces
            inc ch  ;// To count the diamond
            cmp ch,6 ;//To loop based on how many diamonds wanted to be display
            mov cl,0
            jne line1c2
            nextline
            mov ch,0
            jmp mainc2

        ;//Checkpoint
        lline4c2:
            jmp line4c2
        
        ;//Function to print line2
        line2c2:
            inc cl
            mov dh,2
            cmp cl,3
            jl printspacee
            je printpagarr
            cmp cl,6
            jl printspacee
            je printpagarr
            cmp cl,8
            jl printspacee
            inc ch
            cmp ch,6
            mov cl,0
            jne line2c2
            nextline
            mov ch,0
            jmp mainc2
        
        ;//These two functions for jump checkpoint
        printspacee:
            jmp printspace

        printpagarr:
            jmp printpagar
        
        ;//Function to print line 3
        line3c2:
            inc cl
            mov dh,3
            cmp cl,2
            jl printspacee 
            je printpagarr 
            cmp cl,7
            jl printspacee 
            je printpagarr 
            cmp cl,8
            jl printspacee 
            inc ch
            cmp ch,6
            mov cl,0
            jne line3c2
            nextline
            mov ch,0
            jmp mainc2
        
        ;//Function to print line 4
        line4c2:
            inc cl
            mov dh,4
            cmp cl,1
            je printpagarr 
            cmp cl,8
            jl printspacee
            inc ch
            cmp ch,7
            mov cl,0
            jne line4c2
            nextline
            mov ch,0
            jmp mainc2
    
    ;//If choice is 3
    choice3:
        ;//Declare variable
        nextline
        mov bl,0 ;//Line counter for main function
        mov bh,0 ;//Counter for print
        mov cl,0 ;//Line Counterf or Jump
        mov ch,0 ;//Counter for print only 1 character
        jmp main3

        ;//Line 1 Function
        line1:
            inc bh
            showchar 'K'
            cmp bh,10 ;//Print K until BH is 10
            jne line1
            mov bh,0
            nextline
            jmp main3
        
        ;//Line 2 function
        line2:
            inc bh
            mov cl,2 ;//For Line Counter
            cmp ch,0
            je sshowk ;//Print K if ch is 0
            cmp bh,10
            jl sshowe ;//print E until ch is 9
            je sshowk ;//Print K when bh is 10
            mov bh,0
            mov ch,0
            nextline
            jmp main3

        ;//These five functions is for Jump checkpoint
        sshowk:
            jmp showk

        sshowe:
            jmp showe

        sshowv:
            jmp showv

        sshowi:
            jmp showi

        sshown:
            jmp shown

        ;//Line 3 function
        line3:
            inc bh
            mov cl,3
            cmp ch,0
            je sshowk ;// Print K if CH 0
            cmp ch,1
            je sshowe ;// Print E if ch 1
            cmp bh,9
            jl sshowv ;//Print V until bh 8
            je sshowe ;//Print E if bh 9
            cmp bh,10
            je sshowk ;// Print K if bh 10
            mov bh,0
            mov ch,0
            nextline
            jmp main3
        
        ;//Line 4 function
        line4:
            inc bh
            mov cl,4
            cmp ch,0
            je sshowk ;//Print K if ch 0
            cmp ch,1
            je sshowe ;//Print E if ch 1
            cmp ch,2
            je sshowv ;//Print V is ch 2
            cmp bh,8
            jl sshowi ;//Print I until bh is 7
            je sshowv ;//Print V if bh 8
            cmp bh,9
            je sshowe ;//Print E if bh 9
            cmp bh,10
            je sshowk ;//Print K if bh 10
            mov bh,0
            mov ch,0
            nextline
            jmp main3
        
        ;//These five functions is just for checkpoint
        ssshowk:
            jmp showk

        ssshowe:
            jmp showe

        ssshowv:
            jmp showv

        ssshowi:
            jmp showi

        ssshown:
            jmp shown
        
        ;//Line 5 function
        line5:
            inc bh ;1
            mov cl,5
            cmp ch,0
            je ssshowk ;//Print K if ch0
            cmp ch,1
            je ssshowe ;//Print E if ch 1
            cmp ch,2
            je ssshowv ;//Print V if ch 2
            cmp ch,3
            je ssshowi ;//Print I if ch 3
            cmp bh,7
            jl ssshown ;//Print N until ch6
            je ssshowi ;//print I if ch 7
            cmp bh,8
            je ssshowv ;//Print V if ch 8
            cmp bh,9
            je ssshowe ;//Print E if ch 9
            cmp bh,10
            je ssshowk ;//Print K if ch 10
            mov bh,0
            mov ch,0
            nextline
            jmp main3
        
        ;//These five functions for jump checkpoint
        lline1:
            jmp line1

        lline2:
            jmp line2

        lline3:
            jmp line3

        lline4:
            jmp line4

        lline5:
            jmp line5
            
        ;//Main function for choice 3
        main3:
            inc bl
            cmp bl,1
            je lline1
            cmp bl,2
            je lline2
            cmp bl,3
            je lline3
            cmp bl,4
            je lline4
            cmp bl,5
            je lline5
            cmp bl,6
            je lline5
            cmp bl,7
            je lline4
            cmp bl,8
            je lline3
            cmp bl,9
            je lline2
            cmp bl,10
            je lline1 
            nextline
            jmp printcontinue

        ;//These 4 functions for jump checkpoint
        llline2:
            jmp line2

        llline3:
            jmp line3

        llline4:
            jmp line4

        llline5:
            jmp line5
        
        ;//Print K function
        showk:
            inc ch
            showchar 'K'
            cmp cl,2
            je llline2
            cmp cl,3
            je llline3
            cmp cl,4
            je llline4
            cmp cl,5
            je llline5
        
        ;//Print E function
        showe:
            inc ch
            showchar 'E'
            cmp cl,2
            je llline2
            cmp cl,3
            je llline3
            cmp cl,4
            je llline4
            cmp cl,5
            je llline5

        ;//Print V function
        showv:
            inc ch
            showchar 'V'
            cmp cl,3
            je llline3
            cmp cl,4
            je llline4
            cmp cl,5
            je llline5

        ;//Print I function
        showi:
            inc ch
            showchar 'I'
            cmp cl,4
            je llline4
            cmp cl,5
            je llline5

        ;//Print N function
        shown:
            inc ch
            showchar 'N'
            cmp cl,5
            je llline5
    
    ;//If Choice is 4
    ;//Declare Variable
    choice4:
        nextline
        mov bh,0 ;//For COunter
        mov bl,1 ;//To print line 1
        mov ch,12 ;//Counter to print right side
        mov cl,4 ;//Counter to print star in left side
        mov dh,0
        mov bh2,0 ;//For Counter
        mov pointer,0 ;//For pointer between printline1 and main4
        jmp main4

    ;//Main function for choice 4
    main4:
        inc bh ;2
        mov pointer,0
        cmp bh,bl
        je printstarline1 ;//Print Lien 1 if bh equal to bl
        cmp bh,cl 
        jl printstar ;//Print star while bh less than cl
        cmp bh,8 
        jl printspasi ;//Print space until bh is 7
        cmp bh,ch 
        jl printstar ;//Print while bh is lower than ch
        nextline
        inc dh 
        add cl,1
        dec ch
        mov bh,1
        cmp dh,4 ;//To loop until line 5
        jl main4
        inc loop4
        cmp loop4,1 ;//To print lower part
        je  choice4
        mov loop4,0
        jmp printcontinue
    
    ;//line  1 function
    printstarline1:
        inc bh2
        mov pointer,1 ;//In order to be able to use printstar and printspasi function
        cmp bh2,bl 
        je printstar ;//Print star if bh2 is equal to bl
        mov bl,250 ;//Change the value of bl so that in the next loop this function will not run again
        cmp bh2,7 
        jl printspasi ;// Print space until bh2 is 6
        cmp bh2,ch
        jl printstar ;//Print star while bh2 is lower than ch
        nextline
        mov bh2,0
        jmp main4
    
    ;//Print Star function
    printstar:
        showchar '*'
        cmp pointer,1
        je printstarline1
        jmp main4

    ;//Print space function
    printspasi:
        showchar " "
        cmp pointer,1
        je printstarline1
        jmp main4
    
    ;//Done function for user to finish using the system
    done:
        cls
        showstring exit
        mov ah,4ch
        int 21h
main endp
end main