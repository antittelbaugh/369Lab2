#Group 3 - Julia Otto completed 100% of this exercise
.data	
list1:		.word		3, 9, 1, 2, 6, 3, -4, -7, -8, 4, -2,  8, 7, 6
.text 		# list1 is an array of integers storing the given sequence of values	 
.globl	tomato
tomato: 
addi	$sp, $sp, -8       #sp=sp-8; make space in stack for 2 items
addi	$t0, $a0, -1       #t0=a0-1; decrement a0
sw  	$t0, 0($sp)        #t0=sp; store decremented value in current loc on stack
sw  	$ra, 4($sp)        #ra=4+sp; save return address in space above t0 on stack
bne 	$a0, $zero, orange #if a0!=0, orange if not fully decremented
li  	$v0, 0             #vo = 0
addi	$sp, $sp, 8        #sp=sp+8
jr 	$ra                    #return

orange:   
move  $a0, $t0          #t0->a0 
jal   	tomato			#jump to tomato
lw    	$t0, 0($sp)		#load value from address sp into t0
sll	    $t1, $t0, 2     #t1 = t0 + 4
add   	$t1, $t1, $a1   #t1=t1+a1  
lw    	$t2, 0($t1)     #load value from address t1 into t2  
add   	$v0, $v0, $t2   #v0=vo+t2  
lw    	$ra, 4($sp)     #load next value into ra         
addi 	$sp, $sp, 8     #sp=sp+8   
jr 	$ra                 #return

# main function starts here                                            						
.globl main
main:	
    addi	$sp, $sp, -4	# Make space on stack
	sw	$ra, 0($sp)	# Save return address
	la	$a1, list1	# a1 has the base address pointing to the first 
# element of the “list1” array declared in .data section above
	li	$a0, 9		# loads the immediate value into the destination register
	jal	tomato	
return:	
li	$v0, 0			# Return value
	lw	$ra, 0($sp)		# Restore return address
	addi	$sp, $sp, 4		# Restore stack pointer
	jr 	$ra			# Return
# Step through this code in your simulator and monitor the register values. 
# What does the tomato function do?   
# The tomato function iterates a0 from 9 to 0 and stores this value in the stack.
# It stores the number in every other memory location and reserves the open spaces in 
# the stack to save the register address for later. If a0 has not reached 0 it calls the orange function. This then
# sets t0 equal to a0 and calls tomato again. Once a0 is 0, orange is not called and the rest of tomato is carried out.
# vo is set to 0 and we start moving the stack pointer back up the stack. Now, we have to complete the recursed orange calls.
# This then stores the incrementing values in the stack into t0. Then we get the address of the list item and store it in t1 then
# load the value from this address in t2. In v0, we create a running sum of the first 9 values from list1 stored in t2. This is completed 
# once we run up the stack and finally we return and restore the return address and stack pointer and v0 to 0.
