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
	file.exists $0 1
	assertEquals "Status success case" 0 $?
	file.exists do-not-exist 1
	assertEquals "Status failure case" 1 $?
}

testFileCleanup()
{
	assertEquals "Function file.cleanup exists" "function" $(type -t file.cleanup)
	
	touch .file.cleanup
	assertEquals "First .file.cleanup file exists" 0 $(file.exists .file.cleanup)
	
	mkdir .file.cleanup_dir/
	touch .file.cleanup_dir/.file.cleanup
	assertEquals "Second .file.cleanup file exists" 0 $(file.exists .file.cleanup_dir/.file.cleanup)
	
	file.cleanup . .file.cleanup
	assertEquals "Exists with success" 0 $?
	
	assertEquals "First .file.cleanup gone" 1 $(file.exists .todelete)
	assertEquals "Second .file.cleanup gone" 1 $(file.exists .todelete_dir/.todelete)
	
	rmdir .file.cleanup_dir/
}

source $(which shunit2)
