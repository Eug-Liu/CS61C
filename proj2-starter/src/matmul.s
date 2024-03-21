.globl matmul
.import utils.s

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    bge x0, a1, exit2
    bge x0, a2, exit2
    bge x0, a3, exit3
    bge x0, a4, exit3
    bne a2, a4, exit4

    # Prologue
    addi sp, sp -44
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    mv s6, a6

    li s7, 0 # Outer loop counter
    li s8, 0 # Inner loop counter

    mv s9 a3

outer_loop:
    beq s7, s1, outer_loop_end



inner_loop:
    
    beq s8, s5, inner_loop_end
    
    mv a0, s0
    mv a1, s3
    mv a2, s2 
    li a3, 1
    mv a4, s5
    # Assign args for dot

    jal ra dot
    sw a0 0(s6) #####

    addi s6, s6, 4 # Move d ptr
    addi s8, s8, 1
    addi s3, s3, 4 # Move m1 ptr
    j inner_loop
inner_loop_end:

    addi s3, s9, 0 #Reset the m1 ptr
    add s8 x0 x0 # Reset the inner counter
    addi s7, s7, 1
    mv t0, a2
    slli t0, t0, 2
    add s0, s0, t0 # Move m2 ptr
    j outer_loop
outer_loop_end:


    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9 40(sp)
    addi sp, sp, 44
    
    ret

exit2:
    li a0 17
    li a1, 2
    li a7, 93
    ecall
exit3:
    li a0 17
    li a1, 3
    li a7, 93
    ecall

exit4:
    mv a1 a2
    jal print_int
    mv a1 a4
    jal print_int

    li a0 17
    li a1 4
    li a7, 93
    ecall