.globl classify

.import argmax.s
.import matmul.s
.import read_matrix.s
.import relu.s
.import utils.s
.import write_matrix.s

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

li t0 5
beq a0 t0 exit49_end
exit49:
    li a1 49
    jal exit2
exit49_end:
	# =====================================
    # LOAD MATRICES
    # =====================================
addi sp sp -56
sw ra 4(sp) # First place is used by argmax
sw s0 8(sp)
sw s1 12(sp)
sw s2 16(sp)
sw s3 20(sp)
sw s4 24(sp)
sw s5 28(sp)
sw s6 32(sp)
sw s7 36(sp)
sw s8 40(sp)
sw s9 44(sp)
sw s10 48(sp)
sw s11 52(sp)

lw s0 4(a1) 
lw s1 8(a1)
lw s2 12(a1)
lw s3 16(a1) # Output path s3

    # Load pretrained m0
li t0 4
mv a0 t0
jal malloc
mv s4 a0 # s4 is row of m0
li t0 4
mv a0 t0
jal malloc
mv s5 a0 # s5 col of m0

mv a0 s0
mv a1 s4
mv a2 s5
jal read_matrix
mv s0 a0

mv a0 s4
lw s4 0(a0)
    jal free
mv a0 s5
lw s5 0(a0)
    jal free

    # Load pretrained m1
li t0 4
mv a0 t0
jal malloc
mv s6 a0 # s6 is row of m1
li t0 4
mv a0 t0
jal malloc
mv s7 a0 # s7 col of m1

mv a0 s1
mv a1 s6
mv a2 s7
jal read_matrix
mv s1 a0

mv a0 s6
lw s6 0(a0)
    jal free
mv a0 s7
lw s7 0(a0)
    jal free

    # Load input matrix
li t0 4
mv a0 t0
jal malloc
mv s8 a0 # s8 is row of input
li t0 4
mv a0 t0
jal malloc
mv s9 a0 # s9 col of input

mv a0 s2
mv a1 s8
mv a2 s9
jal read_matrix
mv s2 a0

mv a0 s8
lw s8 0(a0)
    jal free
mv a0 s9
lw s9 0(a0)
    jal free


    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
mul a0 s4 s9
slli a0 a0 4
jal malloc
mv s10 a0

mv a0 s0
mv a1 s4
mv a2 s5
mv a3 s2
mv a4 s8
mv a5 s9    
mv a6 s10
jal matmul


mv a0 s10
mul a1 s4 s9
jal relu

mul a0 s6 s9
slli a0 a0 4
jal malloc
mv s11 a0

mv a0 s1
mv a1 s6
mv a2 s7
mv a3 s10
mv a4 s4
mv a5 s9
mv a6 s11
jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
mv a0 s3
mv a1 s11
mv a2 s6
mv a3 s9
jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
mv a0 s11
mul a1 s6 s9
jal argmax
lw a0 0(sp)


    # Print classification
beq a0 x0 notprint
mv a1 a0
jal print_int


    # Print newline afterwards for clarity
li a1 '\n'
jal print_char

notprint:
    lw a0 0(sp)

    lw ra 4(sp) 
    lw s0 8(sp)
    lw s1 12(sp)
    lw s2 16(sp)
    lw s3 20(sp)
    lw s4 24(sp)
    lw s5 28(sp)
    lw s6 32(sp)
    lw s7 36(sp)
    lw s8 40(sp)
    lw s9 44(sp)
    lw s10 48(sp)
    lw s11 52(sp)
    addi sp sp 56

    ret
