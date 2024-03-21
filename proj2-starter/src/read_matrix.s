.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)

	mv s0 a0
    mv s1 a1
    mv s2 a2
    
    mv a1 s0
    mv a2 x0
    jal ra fopen
    mv s3 a0 # s3 is the file decrib 
    li t0 -1
    beq a0 t0 exit50
    
    mv a1 s3
    mv a2 s1
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit51
    mv a1 s3
    mv a2 s2
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit51
    # Read the matrix file info

    li t0 4 # 4 bytes
    lw t1 0(s1)
    lw t2 0(s2)
    mul t3 t1 t2
    mul t3 t3 t0
    # Calculate the matrix size

    mv a0 t3
    jal ra malloc
    mv s4 a0
    mv a1 s3
    mv a2 a0
    mv a3 t3
    mv t4 t3
    jal ra fread
    bne t4 a0 exit51
    #Read the file content

    mv a1 s3
    jal ra fclose
    bne a0 x0 exit52

    mv a0 s4
    mv a1 s1
    mv a2 s2
    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24

    ret

exit50:
    jal print_int
    li a1 50
    j exit2

exit51:
    li a1 51
    j exit2

exit52:
    li a1 52
    j exit2