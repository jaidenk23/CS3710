# ECE3710 - Mini MIPS
# Jaiden Kazemini

init:
    addi $3, $0, 0      # set counter to 0
    addi $4, $0, 1      # set f1 to 1
    addi $5, $0, 0      # set f2 to 0

fib_loop:
    beq  $3, 14, display_loop # if counter = 14, jump to display loop
    add  $6, $3, $4     # temporary register $6 = f1 + f2
    addi $4, $6, 0      # f1 = temporary register
    sub  $4, $6, $5     # f2 = f1 - f2
    sw   $6, 128($3)    # store computed Fibonacci value in memory
    addi $3, $3, 1      # increment counter
    beq  $0, $0, fib_loop   # unconditional jump to fib_loop

display_loop:
    lw   $6, 0($0)      # load switch value into $6
    addi $6, $6, 128    # add base address to get the exact memory location
    lw   $4, 0($6)      # load the Fibonacci value from memory into $4
    sw   $4, 255($0)    # display the value on LEDs
    beq  $0, $0, display_loop   # unconditional jump to display_loop



