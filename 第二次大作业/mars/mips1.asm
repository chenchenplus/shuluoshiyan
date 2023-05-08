# read str
li $a1, 4
li $a0, 4 # len_str = 4

# read pattern
li $a3, 0
li $a2, 4 # len_pattern = 4

# call brute_force
brute_force:
li $t1,0 # j=0
li $t5,0 # test
loop_j:
add $t3,$a1,$t1 # str[i+j]µØÖ·
add $t4,$a3,$t1 # pattern[j]µØÖ·
lb $t3,0($t3) # str[i+j]
lb $t4,0($t4) # pattern[j]
bne $t3,$t4,exit_j
addi $t1,$t1,1 # j+=1
addi $t5,$t5,1 # test
exit_j:
blt $t1,$a2,loop_j # j<len_pattern

