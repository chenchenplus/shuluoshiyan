# read str
li $a1, 4
li $a0, 41 # len_str = 41

# read pattern
li $a3, 0
li $a2, 3 # len_pattern = 3

# call brute_force
brute_force:
li $t0,0 # i=0
li $t1,0 # j=0
li $v0,0 # cnt=0
sub $t2,$a0,$a2 # len_str-len_pattern
loop_i:
li $t1,0 # j=0
loop_j:
add $t3,$t0,$t1 # i+j
add $t3,$a1,$t3 # str[i+j]地址
lb $t3,0($t3) # str[i+j]
add $t4,$a3,$t1 # pattern[j]地址
lb $t4,0($t4) # pattern[j]

bne $t3,$t4,exit_j
addi $t1,$t1,1 # j+=1
blt $t1,$a2,loop_j # j<len_pattern
exit_j:
bne $t1,$a2,nxtloop
addi $v0,$v0,1 # cnt+=1
nxtloop:
addi $t0,$t0,1 # i+=1
ble $t0,$t2,loop_i # i<=len_str-len_pattern
