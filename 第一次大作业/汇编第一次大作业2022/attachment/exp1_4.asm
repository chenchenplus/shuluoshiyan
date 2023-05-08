main:
li $v0, 5
syscall
move $a0, $v0
jal Hanoi
move $a0, $v0
li $v0 1
syscall
li $v0 10
syscall

Hanoi: # 将参数放入$a0
addi $t0 $0, 1
bne $t0 $a0 Next
addi $v0 $0 1 # 返回1
jr $ra
Next:
# （保护现场）
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $a0, 0($sp)


addi $s1 $0 1
# （调用Hanoi(n-1)，返回值存在$v0）

addi $a0 $a0 -1
jal Hanoi
addi $s1 $0 1

add $s1 $v0 $s1
add $s1 $v0 $s1
add $v0 $s1 $0
# jr $ra
# （恢复现场）
lw $ra, 4($sp)
lw $a0, 0($sp)

addi $sp, $sp, 8

jr $ra

