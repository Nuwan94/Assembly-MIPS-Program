###################################
#    SENG 21213 : Assignment 01	  #
#      Nuwan Sameera Alawatta	  #
#           SE/2015/003		  	  #
#           2018/07/01			  #
###################################

	# data section
	.data
day1: .asciiz "Monday    : "
day2: .asciiz "Tuesday   : "
day3: .asciiz "Wednesday : "
day4: .asciiz "Thursday  : "
day5: .asciiz "Friday    : "
day6: .asciiz "Saturday  : "
day7: .asciiz "Sunday    : "
days: .word day1,day2,day3,day4,day5,day6,day7	# array of String's addresses

week1: 	.word	0:7        # array of 7 integers
week2: 	.word	0:7        # array of 7 integers

displayHeadingWeek1:	.asciiz " Production of Week 1\n"
spacer: 		.asciiz "  "
week1Msg: 		.asciiz "=============== WEEK 1 ===============\n"
week2Msg: 		.asciiz "=============== WEEK 2 ===============\n"
compareMsg: 	.asciiz "============= COMPARISON =============\n\n"
displayMsg: 	.asciiz "=============== DISPLAY ==============\n\n"
highestValMsg: 	.asciiz "\n Highest Production : "
lowestValMsg: 	.asciiz "\n Lowest Production  : "
enterProd: 		.asciiz "Enetr the Production for "
newline: 		.asciiz "\n"

	# text section
	.text
main:

	la $a0,week1Msg
	li $v0,4
	syscall			# print the Week1 message

	la $s1,week1
	jal InputProduction		# get Week1 inputs

	la $a0,newline
	li $v0,4
	syscall			# newline print

	la $a0,week2Msg
	li $v0,4
	syscall			# print the Week2 message

	la $s1,week2
	jal InputProduction		# get Week2 inputs

	la $a0,newline
	li $v0,4
	syscall			# newline print

	la $a0,compareMsg
	li $v0,4
	syscall			# print the compare message

	la $s1,week1
	la $s2,week2
	jal CompareProduction

	la $a0,displayMsg
	li $v0,4
	syscall			# print the display message

	la $a0,displayHeadingWeek1
	li $v0,4
	syscall

	la $s1,week1
	jal DisplayProduction

	li $v0, 10				# exit the program
	syscall

#------------------------------ InputProduction ------------------------------#

InputProduction:
	la $s0,days			# load days array base address
	li $t9,7 			# counter
	li $t8,0	 		# byte shifter
	
	InputLoop:
	addi $t9,$t9,-1		# counter--

	la $a0,enterProd
	li $v0,4
	syscall				# print the production message
	lw $a0,0($s0)
	li $v0,4
	syscall				# print the day

	li $v0,5			# get input
	syscall
	
	sw $v0, 0($s1)		# save input in week of $s0
	addi $s0,$s0,4		# shift to next day
	addi $s1,$s1,4		# shift to next element of week

	bne $t9,$zero,InputLoop	# if(counter!=0) loop again

	jr $ra				# jump to return address

#-----------------------------------------------------------------------------#

#----------------------------- CompareProduction -----------------------------#

CompareProduction:
	la $s0,days			# load days array base address
	li $t9,7 			# counter
	li $t8,0	 		# byte shifter

CompareLoop:
	addi $t9,$t9,-1		# counter--

	lw $a0,0($s0)
	li $v0,4
	syscall				# print the day

	lw $t0,0($s1)		# load week1 value for the day
	lw $t1,0($s2)		# load week2 value for the day

	bgt $t0,$t1,swap # if(t0>t1)
	b endif
swap:
	move $t2,$t0
	move $t0,$t1
	move $t1,$t2
endif:
	la $a0,highestValMsg
	li $v0,4
	syscall				# print highest Value message

	move $a0,$t1
	li $v0,1
	syscall

	la $a0,lowestValMsg
	li $v0,4
	syscall				# print lowest Value message

	move $a0,$t0
	li $v0,1
	syscall

	la $a0,newline
	li $v0,4
	syscall				# newline print
	syscall				# newline print

	addi $s0,$s0,4		# shift to next day
	addi $s1,$s1,4		# shift to next element of week 1
	addi $s2,$s2,4		# shift to next element of week 2

	bne $t9,$zero,CompareLoop	# if(counter!=0) loop again

	jr $ra				# jump to return address

#-----------------------------------------------------------------------------#

#----------------------------- DisplayProduction -----------------------------#

DisplayProduction:
	la $s0,days			# load days array base address
	li $t9,7 			# counter
	li $t8,0	 		# byte shifter

DisplayLoop:
	addi $t9,$t9,-1		# counter--

	la $a0,spacer
	li $v0,4
	syscall

	lw $a0,0($s0)
	li $v0,4
	syscall				# print the day

	lw $t0,0($s1)		# load week1 value for the day

	la $a0,spacer
	li $v0,4
	syscall

	move $a0,$t0
	li $v0,1
	syscall

	la $a0,newline
	li $v0,4
	syscall				# newline print

	addi $s0,$s0,4		# shift to next day
	addi $s1,$s1,4		# shift to next element of week1

	bne $t9,$zero,DisplayLoop	# if(counter!=0) loop again

	jr $ra				# jump to return address

#-----------------------------------------------------------------------------#