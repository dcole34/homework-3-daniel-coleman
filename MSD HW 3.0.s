# Daniel Coleman
# EECE.3170: Microprocessors I
# UMass Lowell
# D.C. HW #3
	
	.global main
	.data
   sx: .word 1, 2, 3, 4, 5
   sy: .word 5, 4, 3, 2, 1 # test 1
   # sy: .word 1, 0, 1, 0, 1, 0, 1, 0, 1, 0  # test 2
    .text
    .ent main
main:
    li $a0,2
    li $a1,1
    # li $a2,2 # 1 for test 1
    jal g
    nop
loop: 
    j loop
    nop
    .end main
  
    .ent g
g: 
  li $t8,0
  li $t9,0
  li $t1,0 # ix = 0
  li $t2,0 # iy = 0
  la $t3,sx
  la $t4,sy
  add $s0,$zero,$zero # $s0 = i = 0
  
  bne $a1,1,L2
  bne $a2,1,L2
   j      L1
 L1:
   beq $s0,5,L3 # sets t0 =1 if s0<5
   
   lw $t5,0($t3) # sx
   lw $t6,0($t4) # sy
   move $t7,$t6
   
   mul $t6,$a0,$t5 # sa * sx
   add $t6,$t6,$t7 # sy + sa*sx
   
   sw $t6,0($t4)
   
   addi $t3,$t3,4 # increasing sx[i] , i++
   addi $t4,$t4,4 # increasing sy[i] , i++
   addi $s0,$s0,1 # i++
   j L1     
 L2: # else 
   beq $s0,10,L3
   
   lw $t5,0($t3) # sx
   lw $t6,0($t4) # sy
   move $t7,$t6
   
   mul $t6,$a0,$t5 # sa * sx
   add $t6,$t6,$t7 # sy + sa*sx
   
   sw $t6,0($t4)
   
   sub $t3,$t3,$t8
   sub $t4,$t4,$t9
   
   
   add $t1,$t1,$a1 
   add $t2,$t2,$a2
   
   sll $t8,$t1,2
   sll $t9,$t2,2
   # mul $t8,$t1,4 # ix
   # mul $t9,$t2,4 # iy
   
   add $t3,$t3,$t8
   add $t4,$t4,$t9
   addi $s0,$s0,1 # i++ 
   
   b L2
 L3:
    jr  $ra
    nop
    .end g