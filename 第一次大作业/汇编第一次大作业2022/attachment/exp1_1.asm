.data
input_file: .asciiz "a.in"
output_file: .asciiz "a.out"
.text
li $a0,8
li $v0,9      # 开辟8byte的空间
syscall
move $t0,$v0 # t0储存8byte空间的首地址
la $a0, input_file # input_file 是一个字符串
li $a1, 0 # flag 0为读取 1为写入
li $a2, 0 # mode is ignored 设置为0
li $v0, 13 # 13 为打开文件的 syscall 编号
syscall # 如果打开成功 ， 文件描述符返回到$v0中
 move $a0,$v0 # 将文件描述符载入到 $a0中
 move $a1, $t0 # buff 为数据暂存区
 li $a2, 8 # 读取8个byte
 li $v0, 14 # 14 为读取文件的 syscall 编号
 syscall
 li $v0,16 # 16 为关闭文件的 syscall 编号
 syscall

la $a0, output_file # output_file 是一个字符串
li $a1, 1 # flag 0为读取 1为写入
li $a2, 0 # mode is ignored 设置为0
li $v0, 13 # 13 为打开文件的 syscall 编号
syscall # 如果打开成功 ， 文件描述符返回到$v0中
move $a0,$v0 # 将文件描述符载入到 $a0中
 move $a1, $t0 # buff 为数据暂存区
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