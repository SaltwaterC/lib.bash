#!/usr/bin/env bash

source ../lib.bash

testFileExists()
{
	# function exists
	assertEquals "Function file.exists exists" "function" $(type -t file.exists)
	
	# test with output
	assertEquals "Output success case" 0 $(file.exists $0)
	assertEquals "Output failure case" 1 $(file.exists do-not-exist)

	# test with return
	file.exists $0 true
	assertEquals "Status success case" 0 $?
	file.exists do-not-exist true
	assertEquals "Status failure case" 1 $?
}

testFileCleanup()
{
	assertEquals "Function file.cleanup exists" "function" $(type -t file.cleanup)
	
	touch .todelete
	assertEquals "First .todelete file exists" 0 $(file.exists .todelete)
	
	mkdir .todelete_dir/
	touch .todelete_dir/.todelete
	assertEquals "Second .todelete file exists" 0 $(file.exists .todelete_dir/.todelete)
	
	file.cleanup . .todelete
	
	assertEquals "First .todelete gone" 1 $(file.exists .todelete)
	assertEquals "Second .todelete gone" 1 $(file.exists .todelete_dir/.todelete)
	
	rmdir .todelete_dir/
}

source $(which shunit2)
