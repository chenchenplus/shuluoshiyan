.text
  li $v0,5      # 5�����������
  syscall
  move $t0,$v0 # ����i
  li $v0,5      # 5�����������
  syscall
  move $t1,$v0 # ����j
  abs $t0,$t0 # iȡ����ֵ
  abs $t1,$t1 # jȡ����ֵ
  li $t2, 0 # temp��0
  for: addi $t0, $t0, 1 # i++
  addi $t2, $t2, 1 # ++temp
  bne $t1 $t2 for # temp==jʱ����ѭ��
move $a0,$t0
li $v0,1     # 1�����ӡ����
syscall       # ִ��ϵͳ����
move $v0,$zero  # ����ֵ0