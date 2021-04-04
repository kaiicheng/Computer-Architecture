.globl __start

.rodata
    msg0: .string "This is HW1-1: T(n) = 8T(n/2) + 4n, T(1) = 7\n"
    msg1: .string "Enter a number: "
    msg2: .string "The result is: "

.text

__start:
  # Prints msg0
    addi a0, x0, 4
    la a1, msg0
    ecall
    
  # Prints msg1
    addi a0, x0, 4
    la a1, msg1
    ecall

  # Reads an int
    addi a0, x0, 5
    ecall


################################################################################ 
  # Write your main function here. 
  # Input n is in a0. You should store the result T(n) into t0
  # HW1-1 T(n) = 8T(n/2) + 4n, T(1) = 7, round down the result of division
  # ex. addi t0, a0, 1

add t3, x0, x0  # Set counter.
addi t4, x0, 4  # t4=4
#addi t6, x0, 8  # t6=8
addi t6, x0, 1  # First time (1=>First time, 0=>other)

main:
  addi sp, sp,-8  # Save return address??? and n on stack
  addi t3, t3, 8

  sw ra, 4(sp)  # 4(sp)=ra
  sw a0, 0(sp)  # 0(sp)=a0=n
  
  addi t1, a0, -2  # t1=n-2
  bge t1, x0, L1  # If n>=2, go to L1.
  
  addi t0, x0, 7  # Else, set return vlue to 7.
  addi sp, sp, 8  # Pop stack.
  addi t3, t3, -8
  bgt t6, x0, Exit1
  jalr x0, 0(x1)  # Return.
  
L1: 
  srli a0, a0, 1  # n=int(n/2)
  addi t6, x0, 0  # First time (1=>First time, 0=>other)
  
  jal main  # Call main function.
  
  lw a0, 0(sp)  # 0(sp)=a0=n   n=2
  lw ra, 4(sp)  # 4(sp)=ra
  addi sp, sp, 8
  addi t3, t3, -8
  
  slli t0, t0, 3  # t2=8*T(int(n/2))
  slli t5, a0, 2  # t5=4*n  
  add t0, t0, t5  # t2=8*T(int(n/2))+4*n

  beq t3, x0, Exit2
  jr ra
  
Exit1:
  add x0, x0, x0  # Pass.
  
Exit2:
  add x0, x0, x0  # Pass.

################################################################################

result:
  # Prints msg2
    addi a0, x0, 4
    la a1, msg2
    ecall

  # Prints the result in t0
    addi a0, x0, 1
    add a1, x0, t0
    ecall
    
  # Ends the program with status code 0
    addi a0, x0, 10
    ecall