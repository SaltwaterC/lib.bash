#!/usr/bin/env bash

source ../lib.bash

testFileExists()
{
	# function exists
	assertEquals "Function file.exists exists" "function" $(type -t file.exists)
	
	# test with output
	assertEquals "Output success case" $TRUE $(file.exists $0)
	assertEquals "Output failure case" $FALSE $(file.exists do-not-exist)

	# test with return
	file.exists $0 $FALSE
	assertEquals "Status success case" $TRUE $?
	file.exists do-not-exist $FALSE
	assertEquals "Status failure case" $FALSE $?
}

testFileCleanup()
{
	assertEquals "Function file.cleanup exists" "function" $(type -t file.cleanup)
	
	touch .file.cleanup
	assertEquals "First .file.cleanup file exists" $TRUE $(file.exists .file.cleanup)
	
	mkdir -p .file.cleanup_dir/
	touch .file.cleanup_dir/.file.cleanup
	assertEquals "Second .file.cleanup file exists" $TRUE $(file.exists .file.cleanup_dir/.file.cleanup)
	
	file.cleanup . .file.cleanup
	assertEquals "Exists with success" $TRUE $?
	
	assertEquals "First .file.cleanup gone" $FALSE $(file.exists .todelete)
	assertEquals "Second .file.cleanup gone" $FALSE $(file.exists .todelete_dir/.todelete)
	
	rmdir .file.cleanup_dir/
}

source $(which shunit2)
