.data
.text
    Mystring: .asciz "Assignment 4 \n"     #String to print out
    Placeholder: .asciz " %ld"                                                                          #placeholder for more than number printing
    TheFactorial: .asciz " The factorial of your number is : %ld"                                                   #myage string
    Prompt: .asciz "Enter your number : \n"                #promtstring for user input 
   
.global main
main:                   #main routine 

pushq   %rbp            #store the callers base pointer
movq    %rsp, %rbp      #initialize the base pointer    
movq    $0, %rax        #no vector registers in use for printf
movq    $Mystring, %rdi #load the address of the string
call    printf          #print the string
movq $0, %rax           #no vector registers in use for printf
movq $Prompt, %rdi      #move the text on to the rdi register
call    printf          #prints the text 
subq $16, %rsp          # reserve space for variables on the stack
leaq -8(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf              # prints the statements 

call AskForFactorial    #calls the subroutine AskForFactorial 



end:                    # section for ending the code 
mov     $0, %rdi        # Load the exit code
call    exit            # Actually exit the program 

AskForFactorial:


movq -8(%rbp), %rax     #moves the first variable of the stack on to the rax register
movq %rax, %r9          # moves the value of the rax register onto the r9 register 
movq %r9, -16(%rbp)     # moves the r9 register onto the 2nd variable of the stack 
call CalculateTheFactorial  #calls the subroutine to calculate the factorial 
ret #returns from the the subroutine 

CalculateTheFactorial:  #start of the CalculateTheFactorial sub routine 


#START OF SPACE FOR FACTORIAL FUNCTION 

cmpq $1, %rax   #start of the recursive if statement 
jg IfCode       #jumps to if code, only of the compare function returns true 
jmp ElseCode    #jumps to the else code, if the compare function returns false 



IfCode: #start of the IfCode sub routine 


decq -8(%rbp)   #decrements the first variable of stack
movq -8(%rbp), %rax #moves the decremented variable onto the rax register 
imulq %rax, %r9 #moves the value of the rax register onto the r9 register 
movq %r9, -16(%rbp) #moves the value of the r9 register onto the 2nd variable of the stack 
movq -8(%rbp), %rax #moves the first variable of the stack back onto the rax register 


jmp CalculateTheFactorial #the jump which makes this subroutine recursive 

jmp endOfIfStatement #ends the if statement sub routine 


ElseCode: #start of the else code sub routine 

jmp endOfIfStatement #ends the if statement sub routine 

endOfIfStatement: # moves back into calculate factorial subroutine 

#END OF SPACE FOR FACTORIAL FUNCTION 
movq -16 (%rbp), %rsi    #loads the result value back onto rsi 
movq $TheFactorial, %rdi       # load the function that needs to be printed  
movq $0, %rax           #stack does not have any vectors 
call printf             #call printf 

#START OF EPILOGUE 
movq -16(%rbp), %rax    #Move return value into RAX 
movq %rbp, %rsp         #epilogue: clears the local variables 
popq %rbp               #resets the callers base pointer 

ret                     #returns user from subroutine 

