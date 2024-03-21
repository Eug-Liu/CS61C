.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:
    addi t0, x0, 1
    blt a2, t0, exit5
    blt a3, t0, exit6
    blt a4, t0, exit6
    # Exit once error occurs

    addi t0, a0, 0
    addi t1, a1, 0
    addi t2, x0, 0
    add a0, x0, x0
loop:
    beq t2, a2, loop_end
    
    mul t3, t2, a3 # Stride calculation
    slli t3, t3, 2
    add t3, t0, t3
    lw t4, 0(t3)
    mul t3, t2, a4 # Stride calculation
    slli t3, t3, 2
    add t3, t1, t3
    lw t5, 0(t3)
    mul t6, t4, t5
    add a0, a0, t6

    addi t2, t2, 1


    jal x0, loop
loop_end:



    
    ret

exit5:
    addi a0, x0, 5
    addi a7, x0, 93
    ecall
exit6:
    addi a0, x0, 6
    addi a7, x0, 93
    ecall