#!/usr/bin/env bash

source ../lib.bash

testNumberIsInt()
{
	# function exists
	assertEquals "Function number.is_int exists" "function" $(type -t number.is_int)
	
	# test with output
	assertEquals "Output success case" 0 $(number.is_int 1)
	assertEquals "Output failure case" 1 $(number.is_int a)

	# test with return
	number.is_int 1 true
	assertEquals "Status success case" 0 $?
	number.is_int a true
	assertEquals "Status failure case" 1 $?
}

source $(which shunit2)
