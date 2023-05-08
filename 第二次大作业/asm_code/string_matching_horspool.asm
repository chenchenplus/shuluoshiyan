.data
str: .space 512
pattern: .space 512
filename: .asciiz "test.dat"

.text
main:
#fopen
move $a0, filename # load filename
li $a1, 0 # fmoveg
li $a2, 0 # mode
li $v0, 13 # open file syscall index
syscall

#read str
move $a0, $v0 # load file description to $a0
move $a1, str
li $a2, 1
li $s0, 0 # len_pattern = 0
read_str_entry:
slti $t0, $s0, 512
beqz $t0, read_str_exit
li $v0, 14 # read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_str_exit
addi $a1, $a1, 1
addi $s0, $s0, 1
j read_str_entry
read_str_exit:

#read pattern
move $a1, pattern
li $a2, 1
li $s1, 0 # len_pattern = 0
read_pattern_entry:
slti $t0, $s1, 512
beqz $t0, read_pattern_exit
li $v0, 14 # read file syscall index
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

# call horspool
move $a0, $s0
move $a1, str
move $a2, $s1
move $a3, pattern
jal horspool

# printf
move $a0, $v0
li $v0, 1
syscall
# return 0
li $a0, 0
li $v0, 17
syscall

horspool:
# #### your code here #####
move $t5,$a0 # 保存$a0的值len_str
li $a0,1024
li $v0,9      # 申请table[256]的空间
syscall
move $t0,$v0 # table的首地址
move $t1,$t0 # table的首地址
li $t2,-1
loop_tableinit:
sw $t2,0($t1)
add $t1,$t1,4 # table[i]地址
subi $a0,$a0,4 # 每次循环减4
blt $zero,$a0,loop_tableinit 

move $t2,$a3 # pattern的首地址
loop_tablegen:
lw $t3,0($t2) # pattern[i]
sll $t3,$t3,2 # pattern[i]*4
addi $t2,$t2,4 # 下一次循环pattern[i]的地址
move $t1,$t0 # table的首地址
add $t1,$t1,$t3 # table[pattern[i]]的地址
sw $a0,0($t1)
addi $a0,$a0,1 # 每次循环i加1
blt $a0,$a2,loop_tablegen # $a2存len_pattern

subi $a0,$a2,1 #  i=len_pattern - 1;

loop_i:
ble $t5,$a0,exit_i
li $t4,0 # j=0
loop_j:
ble $a2,$t4,exit_j
subi $t6,$a2,1 # len_pattern-1
sub $t6,$t6,$t4 # len_pattern-1-j
sll $t6,$t6,2  # (len_pattern-1-j)*4
add $t6,$t6,$a3 # pattern[len_pattern-1-j]的地址
lw $t6,0($t6) # pattern[len_pattern-1-j]
sub $t7,$a0,$t4 # i-j
sll $t7,$t7,2
add $t7,$t7,$a1 # str[i-j]的地址
lw $t7,0($t7) # str[i-j]

bne $t6,$t7,exit_j # pattern[len_pattern-1-j]!=str[i-j]时跳出循环
addi $t4,$t4,1 # j+=1
j loop_j
exit_j:
bne $t4,$a2,if
addi $v0,$v0,1 # cnt+=1
if:
sll $t6,$a0,2 # 4*i
add $t6,$t6,$a1
lw $t6,0($t6) # str[i]
sll $t6,$t6,2 # str[i]*4
add $t6,$t6,$t0 # table[str[i]]地址
lw $t6,0($t6) # table[str[i]]
addi $t6,$t6,1 # table[str[i]]+1
subi $t7,$a2,1 # len_pattern-1
sub $t7,$t7,$t4 # len_pattern-1-j
blt$t7,$t6,else # len_pattern-1-j<table[str[i]] + 1则去往else分支
add $a0,$a0,$a2 # i=i+len_pattern
sub $a0,$a0,$t6 # i=i+len_pattern-(table[str[i]]+1)
j loop_i
else:
addi $a0,$a0,1 # i+=1
j loop_i
exit_i:
move $a0,$t5 # 恢复$a0的值
ja $ra

