#!/usr/bin/env bash

source ../lib.bash

testDirExists()
{
	# function exists
	assertEquals "Function dir.exists exists" "function" $(type -t dir.exists)
	
	# test with output
	assertEquals "Output success case" 0 $(dir.exists $(dirname $0))
	assertEquals "Output failure case" 1 $(dir.exists do-not-exist)

	# test with return
	dir.exists $(dirname $0) true
	assertEquals "Status success case" 0 $?
	dir.exists do-not-exist true
	assertEquals "Status failure case" 1 $?
}

source $(which shunit2)
