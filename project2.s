.globl main

.data

x: .word 0
k: .word 0
n: .word 0

txt1: .asciiz "Enter an integer value for x: "
txt2: .asciiz "Enter an integer value for k: "
txt3: .asciiz "Enter an integer value for n: "
finaltxt: .asciiz "The result of x^k % n is: \n"

.text

#fast modular exponentiation method
.globl fme
fme:
sub $sp, $sp, 8    #stack pointers initiated
sw $ra, ($sp)
sw $a1, 4($sp)

addi $s0, $zero, 1 #load s0 with 1, this will be the result
blez $a1, LOOP	   #if k > 0, else jump
div $a1, $a1, 2
jal fme			  

move $t0, $v0	   #t0 holds temp
lw $a1, 4($sp)
addi $s0, $zero, 1 #reinstantiate s0 with 1
li $t7, 2
div $a1, $t7	   
mfhi $s2		   #put k % into s2

bne $s0, $s2, LOOP2#check that k % 2 = 1
div $a0, $a2	   
mfhi $s0		   #store x % in s0

LOOP2:			   #LOOP2 used in the code
mult $s0, $t0	   #multiplying temp and result
mflo $s0
mult $s0, $t0
mflo $s0
div $s0, $a2
mfhi $s0		    #value stored in $s0

LOOP:			    #LOOP1 used in the code
move $v0, $s0
lw $ra, ($sp)
addi $sp, $sp, 8
jr $ra


main:

addi $a0, $zero, 0  #initializing a0
addi $v0, $zero, 0  #initializing v0

li $v0, 4		#print txt1
la $a0, txt1
syscall

li $v0, 5		#get int x
syscall
sw $v0, x		#store k in $v0

li $v0, 4		#print txt2
la $a0, txt2
syscall

li $v0, 5		#get int k
syscall			
sw $v0, k   	#store k in $v0

li $v0, 4		#print txt3
la $a0, txt3
syscall

li $v0, 5		#get int n
syscall 		
sw $v0, n		#store n in $v0

li $v0, 4		#print txt3
la $a0, finaltxt
syscall

addi $a1, $zero, 0  #initializing a1
addi $a2, $zero, 0  #initializing a2

lw $a0, x		#load x, k, n
lw $a1, k
lw $a2, n

jal fme			#jump back to fme

move $a0, $v0 	#move result to $a0

li $v0, 1		#print result
syscall

li $v0, 10		#exit Program
syscall