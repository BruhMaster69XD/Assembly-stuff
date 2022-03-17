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
subq $16, %rsp          #reserve some space on the stack for variable
leaq -8(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf              # call scanf

         
movq $Prompt2, %rdi
call printf
leaq -16(%rbp), %rsi     # Allows the loading of effective address which is in the first variable 
movq $Placeholder, %rdi # loads the argument for scanf 
movq $0, %rax           # no vectors needed in the stack 
call scanf




movq -8(%rbp), %r10     # move base to register r10
movq -16(%rbp),%r11     # move exponent to register r11
movq $1, %r12           # assign 1 to "total" in r12
movq %r12, -32(%rbp)    # move r12 on to the stack
movq -32(%rbp),%r12     # move total back to r12


movq $0, %rbx           # assign 0 to "i" (for the loop)


POW:                    #Beginning of foo subroutine

incq %rbx               # increment i 



imulq %r10, %r12        # multiply the base with the total


movq %r12, -32(%rbp)    # move the new total back on the stack

cmpq -16(%rbp), %rbx    # compare if i < exponent
jl  POW                 # jump back to POW

movq -32(%rbp), %rsi    # move total to rsi
movq $Testing, %rdi     # load the address of the string
movq $0, %rax           # no vectors needed in the stack
call printf             # print total

#pushq %rbp              # Prologue: push the base pointer  
#movq %rsp, %rbp         # Move stack pointer to base pointer 
#subq $16, %rsp          #reserve some space on the stack for variable


movq -16(%rbp), %rax    #Move return value into RAX 
movq %rbp, %rsp         #epilogue: clears the local variables 
popq %rbp               #resets the callers base pointer 

ret                     #returns user from subroutine 

#loop1:
#incq %rbx

#movq $Testing, %rdi
#call printf
#cmpq -16(%rbp), %rbx
#jl  loop1

#call POW               #calls the subroutine POW


end:                    # section for ending the code 
mov     $0, %rdi        # Load the exit code
call    exit            # Actually exit the program 

