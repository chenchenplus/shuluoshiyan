.data
in_buff: .space 8
out_buff: .space 8
input_file: .asciiz "a.in"
output_file: .asciiz "a.out"
.text
la $a0, input_file # input_file 是一个字符串
li $a1, 0 # flag 0为读取 1为写入
li $a2, 0 # mode is ignored 设置为0就可以了
li $v0, 13 # 13 为打开文件的 syscall 编号
syscall # 如果打开成功 ， 文件描述符返回到$v0中
 move $a0,$v0 # 将文件描述符载入到 $a0中
 la $a1, in_buff # in_buff 为数据暂存区
 li $a2, 8 # 读取8个byte
 li $v0, 14 # 14 为读取文件的 syscall 编号
 syscall
 li $v0,16 # 16 为关闭文件的 syscall 编号
 syscall

# 地址初始化，循环变量赋值为N
la $s0, in_buff
la $s1, out_buff
li $t0, 2

# 地址加4 循环变量减1
for: 
addi $t0, $t0, -1
lw $t1, 0($s0)
sw $t1, 0($s1)
addi $s0, $s0, 4
addi $s1, $s1, 4
bne $t0 $zero for

la $a0, output_file # output_file 是一个字符串
li $a1, 1 # flag 0为读取 1为写入
li $a2, 0 # mode is ignored 设置为0就可以了
li $v0, 13 # 13 为打开文件的 syscall 编号
syscall # 如果打开成功 ， 文件描述符返回到$v0中
move $a0,$v0 # 将文件描述符载入到 $a0中
 la $a1, out_buff # out_buff 为数据暂存区
 li $a2, 8 # 写入8个byte
 li $v0, 15 # 15 为写入文件的 syscall 编号
 syscall
# 此时$a0 中的文件描述符没变
# 直接调用 syscall 16 关闭它
li $v0,16 # 16 为关闭文件的 syscall 编号
syscall
li $v0,5      # 5代表读入整数
syscall
addi $a0, $v0, 1
li $v0,1     # 1代表打印整数
syscall       # 执行系统调用
move $v0,$zero  # 返回值0