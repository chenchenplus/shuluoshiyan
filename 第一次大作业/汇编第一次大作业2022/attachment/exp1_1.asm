.data
input_file: .asciiz "a.in"
output_file: .asciiz "a.out"
.text
li $a0,8
li $v0,9      # ����8byte�Ŀռ�
syscall
move $t0,$v0 # t0����8byte�ռ���׵�ַ
la $a0, input_file # input_file ��һ���ַ���
li $a1, 0 # flag 0Ϊ��ȡ 1Ϊд��
li $a2, 0 # mode is ignored ����Ϊ0
li $v0, 13 # 13 Ϊ���ļ��� syscall ���
syscall # ����򿪳ɹ� �� �ļ����������ص�$v0��
 move $a0,$v0 # ���ļ����������뵽 $a0��
 move $a1, $t0 # buff Ϊ�����ݴ���
 li $a2, 8 # ��ȡ8��byte
 li $v0, 14 # 14 Ϊ��ȡ�ļ��� syscall ���
 syscall
 li $v0,16 # 16 Ϊ�ر��ļ��� syscall ���
 syscall

la $a0, output_file # output_file ��һ���ַ���
li $a1, 1 # flag 0Ϊ��ȡ 1Ϊд��
li $a2, 0 # mode is ignored ����Ϊ0
li $v0, 13 # 13 Ϊ���ļ��� syscall ���
syscall # ����򿪳ɹ� �� �ļ����������ص�$v0��
move $a0,$v0 # ���ļ����������뵽 $a0��
 move $a1, $t0 # buff Ϊ�����ݴ���
 li $a2, 8 # д��8��byte
 li $v0, 15 # 15 Ϊд���ļ��� syscall ���
 syscall
# ��ʱ$a0 �е��ļ�������û��
# ֱ�ӵ��� syscall 16 �ر���
li $v0,16 # 16 Ϊ�ر��ļ��� syscall ���
syscall
li $v0,5      # 5�����������
syscall
addi $a0, $v0, 1
li $v0,1     # 1�����ӡ����
syscall       # ִ��ϵͳ����

move $v0,$zero  # ����ֵ0