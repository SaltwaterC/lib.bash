#!/usr/bin/env bash

source ../lib.bash

testDirExists()
{
	# function exists
	assertEquals "Function dir.exists exists" "function" $(type -t dir.exists)
	
	# test with output
	assertEquals "Output success case" $TRUE $(dir.exists $(dirname $0))
	assertEquals "Output failure case" $FALSE $(dir.exists do-not-exist)

	# test with return
	dir.exists $(dirname $0) $FALSE
	assertEquals "Status success case" $TRUE $?
	dir.exists do-not-exist $FALSE
	assertEquals "Status failure case" $FALSE $?
}

testDirCleanup()
{
	# function exists
	assertEquals "Function dir.cleanup exists" "function" $(type -t dir.cleanup)
	
	mkdir -p .dir.cleanup/
	touch .dir.cleanup/.dir.cleanup_file
	assertEquals "First .dir.cleanup exists" $TRUE $(dir.exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file exists" $TRUE $(file.exists .dir.cleanup/.dir.cleanup_file)
	
	mkdir -p .dir.cleanup_dir/.dir.cleanup/
	touch .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file
	assertEquals "Second .dir.cleanup exists" $TRUE $(dir.exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" $TRUE $(file.exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	dir.cleanup . .dir.cleanup
	assertEquals "Exists with success" $TRUE $?
	
	assertEquals "First .dir.cleanup gone" $FALSE $(dir.exists .dir.cleanup)
	assertEquals "First .dir.cleanup_file gone" $FALSE $(file.exists .dir.cleanup/.dir.cleanup_file)
	assertEquals "Second .dir.cleanup exists" $FALSE $(dir.exists .dir.cleanup_dir/.dir.cleanup)
	assertEquals "Second .dir.cleanup_file exists" $FALSE $(file.exists .dir.cleanup_dir/.dir.cleanup/.dir.cleanup_file)
	
	rmdir .dir.cleanup_dir
}

testDirAbsolutePath()
{
	local READLINK=$(which greadlink || which readlink)
	assertEquals "Absolute path for input directory" $($READLINK -f .) $(dir.absolute_path .)
}

source $(which shunit2)
