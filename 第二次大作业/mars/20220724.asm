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
addi $s4,$0,0x4000
sll $s4,$s4,16
addi $s4,$s4,0x0010
addiu $s5,$0,0x000f
loop_i:
li $t1,0 # j=0
loop_j:
add $t3,$t0,$t1 # i+j
add $t3,$a1,$t3 # str[i+j]地址
add $t4,$a3,$t1 # pattern[j]地址
lb $t3,0($t3) # str[i+j]
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
addi $t0, $zero, 0xC0 #0
addi $t1, $zero, 0xF9 #1
addi $t2, $zero, 0xA4 #2
addi $t3, $zero, 0xB0 #3
addi $t4, $zero, 0x99 #4
sw  $t0,256($0)
sw  $t1,260($0)
sw  $t2,264($0)
sw  $t3,268($0)
sw  $t4,272($0)
addi $t0, $zero, 0x92 #5
addi $t1, $zero, 0x82 #6
addi $t2, $zero, 0xF8 #7
addi $t3, $zero, 0x80 #8
addi $t4, $zero, 0x90 #9
sw  $t0,276($0)
sw  $t1,280($0)
sw  $t2,284($0)
sw  $t3,288($0)
sw  $t4,292($0)
addi $t0, $zero, 0x88 #a
addi $t1, $zero, 0x83 #b
addi $t2, $zero, 0xC6 #c
addi $t3, $zero, 0xA1 #d
addi $t4, $zero, 0x86 #e
addi $t5, $zero, 0x8e #f
sw  $t0,296($0)
sw  $t1,300($0)
sw  $t2,304($0)
sw  $t3,308($0)
sw  $t4,312($0)
sw  $t5,316($0)
andi $s0,$v0,0x000f
andi $s1,$v0,0x00f0
andi $s2,$v0,0x0f00
andi $s3,$v0,0xf000
srl $s1,$s1,4
srl $s2,$s2,4
srl $s3,$s3,12
lw $s0,256($s0)
lw $s1,256($s1)
lw $s2,256($s2)
lw $s3,256($s3)
addi $s0,$s0,0x0e00
addi $s1,$s1,0x0d00
addi $s2,$s2,0x0b00
addi $s3,$s3,0x0700
Decode:
#最低位
li $t0,0
sw $s0,0($s4)
timer1:
addi $t0,$t0,1
bne $t0,$s5,timer1
#第二位
li $t0,0
sw $s1,0($s4)
timer2:
addi $t0,$t0,1
bne $t0,$s5,timer3
#第三位
li $t0,0
sw $s2,0($s4)
timer3:
addi $t0,$t0,1
bne $t0,$s5,timer3
#最高位
li $t0,0
sw $s3,0($s4)
timer4:
addi $t0,$t0,1
bne $t0,$s5,timer4
j Decode