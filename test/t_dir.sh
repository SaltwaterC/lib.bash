#!/usr/bin/env bash

source ../lib.bash

testDirExists()
{
	# function exists
	assertEquals "Function dir_exists exists" "function" $(type -t dir_exists)
	
	# test with output
	assertEquals "Output success case" $TRUE $(dir_exists $(dirname $0))
	assertEquals "Output failure case" $FALSE $(dir_exists do-not-exist)

	# test with return
	dir_exists $(dirname $0) $FALSE
	assertEquals "Status success case" $TRUE $?
	dir_exists do-not-exist $FALSE
	assertEquals "Status failure case" $FALSE $?
}

testDirCleanup()
{
	# function exists
	assertEquals "Function dir_cleanup exists" "function" $(type -t dir_cleanup)
	
	mkdir -p .dir.cleanup/
	touch .dir.cleanup/.dir.cleanup_file
	assertEquals "First .dir.cleanup exists" $TRUE $(dir_exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file exists" $TRUE $(file_exists .dir.cleanup/.dir.cleanup_file)
	
	mkdir -p .dir.cleanup_dir/.dir.cleanup/
	touch .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file
	assertEquals "Second .dir.cleanup exists" $TRUE $(dir_exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" $TRUE $(file_exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	dir_cleanup . .dir.cleanup
	assertEquals "Exists with success" $TRUE $?
	
	assertEquals "First .dir.cleanup gone" $FALSE $(dir_exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file gone" $FALSE $(file_exists .dir.cleanup/.dir.cleanup_file)
	assertEquals "Second .dir.cleanup exists" $FALSE $(dir_exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" $FALSE $(file_exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	rmdir .dir.cleanup_dir
}

testDirAbsolutePath()
{
	local READLINK=$(which greadlink || which readlink)
	assertEquals "Absolute path for input directory" $($READLINK -f .) $(dir_absolute_path .)
}

source $(which shunit2)
