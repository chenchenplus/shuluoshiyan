.text
  li $v0,5      # 5�����������
  syscall
  move $t0,$v0 # t0ȡ����n
  sll $a0,$t0,2 # t0������λ�൱�ڡ�4
  li $v0,9      # 9������n*4�Ŀռ�
  syscall
  move $t1,$v0 # ���뿪��������׵�ַ
  move $a0,$v0 # ���뿪��������׵�ַ
  move $t2,$v0 # ���뿪��������׵�ַ
  li $t3,0 # ��i=0
  scan_int:
  li $v0,5      # 5�����������
  syscall
  sw $v0,0($t2)
  addi $t2, $t2, 4 # ���������е�i��Ԫ�صĵ�ַ
  addi $t3, $t3, 1 # i++
  bne $t0 $t3 scan_int # i==nʱ����ѭ��
  
  li $t3,0 # ��i=0
  srl $t4,$t0,1 # t4ȡ����n/2������n������ֱ�����߼�����
  addi $t2, $t2,-4
  beq $t3 $t4 swapend # ���ʱ˵��n==1�������н���
  swap: lw $t5,0($t1) # t = a[i]
  lw $t6,0($t2) # ȡ��a[n - i - 1]
  sw $t6,0($t1) # a[i] = a[n - i - 1]
  sw $t5,0($t2) # a[n - i - 1] = t
  addi $t1, $t1, 4 # ����������������i��Ԫ�صĵ�ַ
  addi $t2, $t2,-4 # ���������е�����i��Ԫ�صĵ�ַ
  addi $t3, $t3, 1 # i++
  bne $t3 $t4 swap # i==n/2ʱ����ѭ��
  swapend:
  li $t3,0 # ��i=0
  move $t1,$a0 # t1��д�������׵�ַ
  li $v0,1 # ��ӡ����
  print:lw $a0,0($t1) # ȡa[i] 
  syscall
  addi $t1,$t1,4 # ȡ��һ��a[i]��ַ
  addi $t3, $t3, 1 # i++
  bne $t0 $t3 print # i==nʱ����ѭ��

move $v0,$zero  # ����ֵ0
