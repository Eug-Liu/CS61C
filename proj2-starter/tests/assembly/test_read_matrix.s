.import ../../src/read_matrix.s
.import ../../src/utils.s

.data
file_path: .asciiz "../inputs/test_read_matrix/test_input2.bin"

.text
main:
    # Read matrix into memory
    li t0 4 # Int size
    la s0 file_path
    mv a0 t0
    jal ra malloc
    mv s1 a0
    mv a0 t0
    jal ra malloc
    mv s2 a0

    mv a0 s0
    mv a1 s1
    mv a2 s2
    jal ra read_matrix
    mv s3 a0
    # Print out elements of matrix
    lw a1 0(a1)
    lw a2 0(a2)
    jal ra print_int_array

    mv a0 s1
    jal free
    mv a0 s2
    jal free
    mv a0 s3
    jal free

    # Terminate the program
    jal exit