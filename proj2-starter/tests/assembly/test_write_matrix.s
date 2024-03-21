.import ../../src/write_matrix.s
.import ../../src/read_matrix.s
.import ../../src/utils.s

.data
m0: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 # MAKE CHANGES HERE TO TEST DIFFERENT MATRICES
file_path: .asciiz "../outputs/test_write_matrix/student_write_outputs.bin"

.text
main:
    la s0 file_path
    la s1 m0
    li s2 2
    li s3 4
    
    # Write the matrix to a file
    mv a0 s0
    mv a1 s1
    mv a2 s2
    mv a3 s3
    jal write_matrix

    li t0 4
    mv a0 t0
    jal ra malloc
    mv s4 a0
    mv a0 t0
    jal ra malloc
    mv s5 a0

    mv a0 s0
    mv a1 s4
    mv a2 s5
    jal read_matrix
    mv s6 a0

    lw a1 0(a1)
    lw a2 0(a2)
    jal ra print_int_array

    mv a0 s4
    jal free
    mv a0 s5
    jal free
    mv a0 s6
    jal free
    # Exit the program
    jal exit