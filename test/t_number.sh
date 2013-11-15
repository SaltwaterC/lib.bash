#!/usr/bin/env bash

source ../lib.bash

testNumberIsInt()
{
	# function exists
	assertEquals "Function number_is_int exists" "function" $(type -t number_is_int)
	
	# test with output
	assertEquals "Output success case" $TRUE $(number_is_int 1)
	assertEquals "Output failure case" $FALSE $(number_is_int a)

	# test with return
	number_is_int 1 $FALSE
	assertEquals "Status success case" $TRUE $?
	number_is_int a $FALSE
	assertEquals "Status failure case" $FALSE $?
}

source $(which shunit2)
