.data
.text
    Mystring: .asciz "Assignment 4 \n"     #String to print out
    Placeholder: .asciz " %ld"                                                                          #placeholder for more than number printing
    TheFactorial: .asciz " The factorial of your number is : %ld"                                                   #myage string
    Prompt: .asciz "Enter your number : \n"                #promtstring for user input 
   
.global main
main:

pushq   %rbp            #store the callers base pointer
movq    %rsp, %rbp      #initialize the base pointer    
movq    $0, %rax        #no vector registers in use for printf
movq    $Mystring, %rdi #load the address of the string
call    printf          #print the string
movq $0, %rax           #no vector registers in use for printf
call PrintFactorial

end:                    # section for ending the code 
mov     $0, %rdi        # Load the exit code
call    exit            # Actually exit the program 

Factorial:
         
movq $Prompt, %rdi
call    printf
leaq -8(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf 

ret

PrintFactorial:  #Beginning of foo subroutine

call Factorial  
movq -8 (%rbp), %rsi    # move this incremented variable back onto rsi 
movq $TheFactorial, %rdi       # load the function that needs to be printed 
movq $0, %rax           #stack does not have any vectors 
call printf             #call printf 

movq -16(%rbp), %rax    #Move return value into RAX 
movq %rbp, %rsp         #epilogue: clears the local variables 
popq %rbp               #resets the callers base pointer 

ret                     #returns user from subroutine 
