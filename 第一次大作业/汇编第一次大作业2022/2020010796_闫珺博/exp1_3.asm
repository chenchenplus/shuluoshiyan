.text
  li $v0,5      # 5代表读入整数
  syscall
  move $t0,$v0 # t0取参数n
  sll $a0,$t0,2 # t0左移两位相当于×4
  li $v0,9      # 9代表开辟n*4的空间
  syscall
  move $t1,$v0 # 读入开辟数组的首地址
  move $a0,$v0 # 读入开辟数组的首地址
  move $t2,$v0 # 读入开辟数组的首地址
  li $t3,0 # 令i=0
  scan_int:
  li $v0,5      # 5代表读入整数
  syscall
  sw $v0,0($t2)
  addi $t2, $t2, 4 # 更新数组中第i个元素的地址
  addi $t3, $t3, 1 # i++
  bne $t0 $t3 scan_int # i==n时跳出循环
  
  li $t3,0 # 令i=0
  srl $t4,$t0,1 # t4取参数n/2，由于n是正数直接用逻辑右移
  addi $t2, $t2,-4
  beq $t3 $t4 swapend # 相等时说明n==1，不进行交换
  swap: lw $t5,0($t1) # t = a[i]
  lw $t6,0($t2) # 取出a[n - i - 1]
  sw $t6,0($t1) # a[i] = a[n - i - 1]
  sw $t5,0($t2) # a[n - i - 1] = t
  addi $t1, $t1, 4 # 更新数组中正数第i个元素的地址
  addi $t2, $t2,-4 # 更新数组中倒数第i个元素的地址
  addi $t3, $t3, 1 # i++
  bne $t3 $t4 swap # i==n/2时跳出循环
  swapend:
  li $t3,0 # 令i=0
  move $t1,$a0 # t1中写入数组首地址
  li $v0,1 # 打印整数
  print:lw $a0,0($t1) # 取a[i] 
  syscall
  addi $t1,$t1,4 # 取下一个a[i]地址
  addi $t3, $t3, 1 # i++
  bne $t0 $t3 print # i==n时跳出循环

move $v0,$zero  # 返回值0
