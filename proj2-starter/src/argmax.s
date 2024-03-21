.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:
    addi t0, x0, 1
    blt a1, t0, exit
    # Exit if error occurs

    # Prologue


loop_start:
    add t0, x0, x0 # Counter
    addi t1, a0, 0
    lw t3, 0(t1)
    addi a0, x0, 0







loop_continue:
    beq t0, a1, loop_end
    lw t2, 0(t1)
    bge t3, t2, else
    addi t3, t2, 0
    addi a0, t0, 0
else:
    addi t0, t0, 1
    addi t1, t1, 4
    jal x0, loop_continue
loop_end:
    

    # Epilogue


    ret

exit:
    addi a0, x0, 7
    addi a7, x0, 93
    ecall