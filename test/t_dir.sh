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
	dir.exists $(dirname $0) 1
	assertEquals "Status success case" 0 $?
	dir.exists do-not-exist 1
	assertEquals "Status failure case" 1 $?
}

testDirCleanup()
{
	# function exists
	assertEquals "Function dir.cleanup exists" "function" $(type -t dir.cleanup)
	
	mkdir -p .dir.cleanup/
	touch .dir.cleanup/.dir.cleanup_file
	assertEquals "First .dir.cleanup exists" 0 $(dir.exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file exists" 0 $(file.exists .dir.cleanup/.dir.cleanup_file)
	
	mkdir -p .dir.cleanup_dir/.dir.cleanup/
	touch .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file
	assertEquals "Second .dir.cleanup exists" 0 $(dir.exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" 0 $(file.exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	dir.cleanup . .dir.cleanup
	assertEquals "Exists with success" 0 $?
	
	assertEquals "First .dir.cleanup gone" 1 $(dir.exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file gone" 1 $(file.exists .dir.cleanup/.dir.cleanup_file)
	assertEquals "Second .dir.cleanup exists" 1 $(dir.exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" 1 $(file.exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	rmdir .dir.cleanup_dir
}

source $(which shunit2)
