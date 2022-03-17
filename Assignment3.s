.data
.text
    Mystring: .asciz "Assignment 3 \n"     #String to print out
    Placeholder: .asciz " %ld"                                                                          #placeholder for more than number printing
    MyExponent: .asciz " The exponent is : %ld"                                                   #myage string
    Prompt1: .asciz " Please enter Base : \n"   
    Prompt2: .asciz "Please enter exponent:\n "
     Prompt3: .asciz "Please enter Total: \n "
    Testing: .asciz "Your total is: %ld\n"
    
   
.global main
main:

pushq   %rbp            #store the callers base pointer
movq    %rsp, %rbp      #initialize the base pointer    
movq    $0, %rax        #no vector registers in use for printf
movq    $Mystring, %rdi #load the address of the string
call    printf          #print the string
movq $0, %rax           #no vector registers in use for printf
movq $Prompt1, %rdi
call    printf
subq $16, %rsp          # reserve some space on the stack for variable
leaq -8(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf              # call scanf

         
movq $Prompt2, %rdi     # load the address of the string
call printf             # print the string
leaq -16(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf




movq -8(%rbp), %rsi    # move base to register r10
movq -16(%rbp),%rdi     # move exponent to register r11


call POW2

POW2:

movq $1, %r12           # assign 1 to "total" in r12
movq %r12, -32(%rbp)    # move r12 on to the stack
movq -32(%rbp),%r12     # move total back to r12

movq $0, %rbx           # assign 0 to "i" (for the loop)


POW:                    #Beginning of foo subroutine

incq %rbx               # increment i 


cmpq -16(%rbp), %rbx
jg ElseCode

imulq %rsi, %r12        # multiply the base with the total


movq %r12, -32(%rbp)    # move the new total back on the stack

cmpq -16(%rbp), %rbx    # compare if i < exponent
jl  POW                 # jump back to POW

ElseCode:
movq -32(%rbp), %rsi    # move total to rsi
movq $Testing, %rdi     # load the address of the string
movq $0, %rax           # no vectors needed in the stack
call printf             # print total



movq -16(%rbp), %rax    #Move return value into RAX 
movq %rbp, %rsp         #epilogue: clears the local variables 
popq %rbp               #resets the callers base pointer 

ret                     #returns user from subroutine 



end:                    # section for ending the code 
mov     $0, %rdi        # Load the exit code
call    exit            # Actually exit the program 
