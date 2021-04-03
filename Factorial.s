.globl __start

.rodata
    msg0: .string "N!=\n"
    msg1: .string "Enter a number: "
    msg2: .string "The result is: "

.text

__start:   # Similar with funciotn.
  # Prints msg0
    addi a0, x0, 4  # Check table.
    la a1, msg0  # Load.
    ecall   # Call system to print.
    
  # Prints msg1
    addi a0, x0, 4
    la a1, msg1
    ecall

  # Reads an int
    addi a0, x0, 5
    ecall

################################################################################ 
  # Write your main function here. 

add t3, a0, x0  # Create a counter.

fact:
  addi sp,sp,-8
  sw ra,4(sp)
  sw a0,0(sp)
  
  addi t1, a0, -1
  bge t1, x0, L1
  
  addi t0, x0, 1
  addi sp, sp, 8
  jalr x0, 0(x1)
  
L1: addi a0, a0, -1
  jal fact
  
  lw a0, 0(sp)
  lw ra, 4(sp)
  addi sp, sp, 8
  
  mul t0, t0, a0
  addi t3, t3, -1

  beq t3, x0, Exit
  jr ra
  
Exit:
  add x0, x0, x0
  
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