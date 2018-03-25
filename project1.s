.globl main
main:

.data
A:  .word  -89, 19, 91, -23, -31, -96, 3, 67, 17, 13, -43, -74  

print: .asciiz "\nAverage of positive array elements:\n"

.text

la $s0, A          #$s0 = address of array A[12]

addi $s1, $zero, 0 #sum initialized as 0
addi $s2, $zero, 0 #counter initialized as 0

STARTFOR:
addi $s4, $s2, -12 #setting counter to -12, $s4 = condition for loop
bgez $s4, ENDFOR   #skip value if $s2 >= 0

addi $s3, $zero, 0 #initializing $s3 = 0

add $s3,$s2,$s2    #temp value = 2i
add $s3,$s3,$s3    #temp value = 4i
add $s6,$s0,$s3    #computing add of array, $s6 = temp address

lw $s5, 0($s6)     #load A[i], $s5 = temp variable

blez $s5, SIGNCHECK#skips negative numbers
add $s1, $s1, $s5  #if num is positive goes here

SIGNCHECK:
addi $s2, $s2, 1   #checks that all A[i] obtained are positive

j STARTFOR		   #checks that A[i] is greater than 0
ENDFOR:

div $t1, $s1, 6    #total divided by 6

li $v0, 4		   #print statement string
la $a0, print
syscall

move $a0, $t1	   #print statement mean
li $v0, 1
syscall

li $v0, 10		   #exit program
syscall