.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    addi t0, x0, 1
    blt a1, t0, exit
    # Exit with code 8

loop_start:
    add t0, x0, x0 # the counter
    






loop_continue:
    beq a1, t0, loop_end
    
    lw t1, 0(a0) # t1 is current item in the array
    blt x0, t1, else
    sw x0, 0(a0)
else:
    addi a0, a0, 4
    addi t0, t0, 1
    jal x0, loop_continue
loop_end:


    # Epilogue

    
	ret

exit:
    addi a0, x0, 8
    jalr x0, ra, 0