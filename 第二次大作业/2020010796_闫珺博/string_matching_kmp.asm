.data
str: .space 512
pattern: .space 512
filename: .asciiz "test.dat"

.text
main:
#fopen
la $a0, filename #load filename
li $a1, 0 #flag
li $a2, 0 #mode
li $v0, 13 #open file syscall index
syscall

#read str
move $a0, $v0 #load file description to $a0
la $a1, str
li $a2, 1
li $s0, 0 #len_pattern = 0
read_str_entry:
slti $t0, $s0, 512
beqz $t0, read_str_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_str_exit
addi $a1, $a1, 1
addi $s0, $s0, 1
j read_str_entry
read_str_exit:

#read pattern
la $a1, pattern
li $a2, 1
li $s1, 0 #len_pattern = 0
read_pattern_entry:
slti $t0, $s1, 512
beqz $t0, read_pattern_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_pattern_exit
addi $a1, $a1, 1
addi $s1, $s1, 1
j read_pattern_entry
read_pattern_exit:

#close file
li $v0, 16 #close file syscall index
syscall

#call brute_force
move $a0, $s0
la $a1, str
move $a2, $s1
la $a3, pattern
jal kmp

#printf
move $a0, $v0
li $v0, 1
syscall
#return 0
li $a0, 0
li $v0, 17
syscall


kmp:
##### your code here #####

li $t0,0 # i=0
li $t1,0 # j=0
move $t2,$a0 # 保存$a0的�??
li $t3,0 # cnt=0
sll $a0,$a2,2 # len_pattern*4
li $v0,9 # 申请next数组
syscall
move $a0,$t2 # 恢复$a0的�?�len_str
move $t2,$v0 # next的首地址
jal next_gen
loop_i:
ble $a0,$t0,exit_i # len_str<=i�??出循�??

add $t4,$t0,$a1 # str[i]地址
lb $t4,0($t4) # str[i]
add $t5,$t1,$a3 # pattern[j]地址
lb $t5,0($t5) # pattern[j]
bne $t4,$t5,else_0
subi $t4,$a2,1 # len_pattern-1
bne $t1,$t4,else_2 # j!=len_pattern-1跳转
addi $t3,$t3,1 # cnt+=1
sll $t4,$t4,2 # 4*(len_pattern-1)
add $t4,$t4,$t2 # next[len_pattern-1]地址
lw $t1,0($t4) # j=next[len_pattern-1]
addi $t0,$t0,1 # i+=1
j loop_i
else_2:
addi $t0,$t0,1 # i+=1
addi $t1,$t1,1 # j+=1
j loop_i


else_0:
ble $t1,$zero,else_1 # j<=0跳转 
sll $t4,$t1,2 # 4*j
subi $t4,$t4,4 # 4*(j-1)
add $t4,$t4,$t2 # next[j-1]地址
lw $t1,0($t4) # j=next[j-1]
j loop_i
else_1:
addi $t0,$t0,1 # i++
j loop_i
exit_i:
move $v0,$t3 # cnt
jr $ra






next_gen:
li $t4,1 # i=1
li $t5,0 # j=0
beq $a2,$zero,return1 # len_pattern==0返回1
sw $zero,0($t2) # next[0]=0
loop_i_gen:
ble $a2,$t4,return0
add $t6,$t4,$a3 # pattern[i]地址
lb $t6,0($t6) # pattern[i]
add $t7,$t5,$a3 # pattern[j]地址
lb $t7,0($t7) # pattern[j]
bne $t6,$t7,if_gen
sll $t6,$t4,2 # 4*i
add $t6,$t6,$t2 # next[i]地址
addi $t5,$t5,1 # j+=1
sw $t5,0($t6) # next[i]=j+1;
addi $t4,$t4,1 # i+=1
j loop_i_gen

if_gen:
ble $t5,$zero,else_gen
sll $t6,$t5,2 # 4*j
subi $t6,$t6,4 # 4*(j-1)
add $t6,$t6,$t2 # next[j-1]地址
lw $t5,0($t6) # j=next[j-1]
j loop_i_gen
else_gen:
sll $t6,$t4,2 # 4*i
add $t6,$t6,$t2 # next[i]地址
sw $zero,0($t6) # next[i]=0
addi $t4,$t4,1 # i++
j loop_i_gen
return0:
li $v0,0
jr $ra
return1:
li $v0,1
jr $ra


