.text
  li $v0,5      # 5代表读入整数
  syscall
  move $t0,$v0 # 读入i
  li $v0,5      # 5代表读入整数
  syscall
  move $t1,$v0 # 读入j
  abs $t0,$t0 # i取绝对值
  abs $t1,$t1 # j取绝对值
  li $t2, 0 # temp置0
  for: addi $t0, $t0, 1 # i++
  addi $t2, $t2, 1 # ++temp
  bne $t1 $t2 for # temp==j时跳出循环
move $a0,$t0
li $v0,1     # 1代表打印整数
syscall       # 执行系统调用
move $v0,$zero  # 返回值0