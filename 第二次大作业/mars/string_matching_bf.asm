# read str
li $a1, 10010004
li $a0, 249 # len_str = 249

# read pattern
li $a3, 10010000
li $a2, 4 # len_pattern = 4

# call brute_force
brute_force:
addi $s4,$0,0x4000
li $t0,0 # i=0
li $t1,0 # j=0
sll $s4,$s4,16
li $v0,0 # cnt=0
sub $t2,$a0,$a2 # len_str-len_pattern
addi $s4,$s4,0x0010
addiu $s5,$0,0x000f
loop_i:
li $t1,0 # j=0
loop_j:
add $t3,$t0,$t1 # i+j
add $t3,$a1,$t3 # str[i+j]��ַ
add $t4,$a3,$t1 # pattern[j]��ַ
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
sw  $t0,256($a3)
sw  $t1,260($a3)
sw  $t2,264($a3)
sw  $t3,268($a3)
sw  $t4,272($a3)
addi $t0, $zero, 0x92 #5
addi $t1, $zero, 0x82 #6
addi $t2, $zero, 0xF8 #7
addi $t3, $zero, 0x80 #8
addi $t4, $zero, 0x90 #9
sw  $t0,276($a3)
sw  $t1,280($a3)
sw  $t2,284($a3)
sw  $t3,288($a3)
sw  $t4,292($a3)
addi $t0, $zero, 0x88 #a
addi $t1, $zero, 0x83 #b
addi $t2, $zero, 0xC6 #c
addi $t3, $zero, 0xA1 #d
addi $t4, $zero, 0x86 #e
addi $t5, $zero, 0x8e #f
sw  $t0,296($a3)
sw  $t1,300($a3)
sw  $t2,304($a3)
sw  $t3,308($a3)
sw  $t4,312($a3)
sw  $t5,316($a3)
andi $s0,$v0,0x000f
andi $s1,$v0,0x00f0
andi $s2,$v0,0x0f00
andi $s3,$v0,0xf000
sll $s0,$s0,2
srl $s1,$s1,2
srl $s2,$s2,6
srl $s3,$s3,10
add $s0,$s0,$a3
add $s1,$s1,$a3
add $s2,$s2,$a3
add $s3,$s3,$a3
lw $s0,256($s0)
lw $s1,256($s1)
lw $s2,256($s2)
lw $s3,256($s3)
addi $s0,$s0,0x0e00
addi $s1,$s1,0x0d00
addi $s2,$s2,0x0b00
addi $s3,$s3,0x0700
Decode:
#����?
li $t0,0
sw $s0,0($s4)
timer1:
addi $t0,$t0,1
bne $t0,$s5,timer1
#�ڶ�λ
li $t0,0
sw $s1,0($s4)
timer2:
addi $t0,$t0,1
bne $t0,$s5,timer2
#����λ
li $t0,0
sw $s2,0($s4)
timer3:
addi $t0,$t0,1
bne $t0,$s5,timer3
#����?
li $t0,0
sw $s3,0($s4)
timer4:
addi $t0,$t0,1
bne $t0,$s5,timer4
