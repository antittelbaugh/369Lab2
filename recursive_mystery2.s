#Ashley Tittelbaugh did 100% of this file

.data	
list1:		.word		3, 9, -1, 0, 6, 5, -4, -7, -8,  
list2:		.word		9, 5, 0, 3, -4, 5, 6, -7, 8, 9, 
.text
.globl	tomato
tomato: 
addi	$sp, $sp, -8   # move stack pointer down to accomotodate 2 words    
addi	$t0, $a0, -1   # t0 = $a0 - 1   
sw  	$t0, 0($sp)    # first word in stack pointer is $t0 or $a0 -1    
sw  	$ra, 4($sp)    # return address is stored in seconds word of stack pointer    
bne 	$a0, $zero, orange  # if $a0 != 0 go to orange 
li  	$v0, 0            # else $v0 = 0 
addi	$sp, $sp, 8          # reset stack pointer 
jr    $ra #jump back               

orange:   
add  $a0, $0, $t0  # $a0 = $t0, but since $t0 = $a0-1  $a0 = (initial value of $a0) -1       
jal   tomato # goes back through tomato will loop through tomato $a0 + 1 times
lw    $t0, 0($sp)  #t0= $a0 -1 is stored in stack
sll	$t1, $t0, 2  #$t1 = $t0*4 = ($a0-1)
add   $t1, $t1, $a1     
lw    $t2, 0($t1)
slt   $t3, $t2, $a2
bne   $t3, $0, carrot      
add   $v0, $v0, $t2 

carrot:    
lw    $ra, 4($sp)                
addi 	$sp, $sp, 8        
jr 	$ra                      
########################################################################
.globl	test
test:	
addi	$sp, $sp, -4	# Make space on stack
sw	$ra, 0($sp)		# Save return address
jal	tomato		# call function
lw	$ra, 0($sp)		# Restore return address
addi	$sp, $sp, 4		# Restore stack pointer
jr 	$ra			# Return
########################################################################
# main function starts here                                            #
.globl main
main:	addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)		# Save return address
	la	$a1, list2	
	li	$a0, 8
      li    $a2, 5		
	jal	test		
# What is the value of $v0 at this point? (v0)= 25       #
	la	$a1, list1	
	li	$a0, 13		
	jal	test		
# What is the value of $v0 at this point?	(v0) = 34      #
# What does this code compute? Your answer HERE: 
#This code computes the the sum of all numbers in the first $a0 elements of the list $a1 that are greater than $a2. 
#Since values in .data are stored contiguously "list1" can be thought of as "list1" concatenated with list 2 
#which is why we can apply this code to the first 13 values of list1 despite list 1 only having 9 values #

return:	
li	$v0, 0		# Return value
	lw	$ra, 0($sp)		# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra			# Return	
