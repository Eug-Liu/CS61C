.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -28
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)


    mv s0 a0
    mv s1 a1
    mv s2 a2
    mv s3 a3

    mv a1 s0
    li a2 1
    jal fopen
    li t0 -1
    beq a0 t0 exit53
    mv s4 a0 # s4 is the targeted file descriptor

    li a0 8
    jal malloc
    mv a2 a0
    mv s5 a2
    sw s2 0(a2)
    sw s3 4(a2)
    # Place the matrix info into buffer s5 and a2

    mv a1 s4
    li a3 2
    li a4 4
    jal fwrite
    li t0 2
    bne a0 t0 exit54
    # Write the first 2 bytes

    mul t0 s2 s3 # Size of the matrix
    mv a1 s4
    mv a2 s1
    mv a3 t0
    li a4 4
    jal fwrite
    mul t0 s2 s3
    bne t0 a0 exit54
    # Wrtie the matrix

    mv a0 s5
    jal free

    mv a1 s4
    jal fclose
    bne x0 a0 exit55
    # Epilogue


    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    addi sp sp 28

    ret

exit53:
    li a1 53
    j exit2

exit54:
    li a1 54
    j exit2

exit55:
    li a1 55
    j exit2