#!/usr/bin/env bash

source ../lib.bash

testFileExists()
{
	# function exists
	assertEquals "Function file_exists exists" "function" $(type -t file_exists)
	
	# test with output
	assertEquals "Output success case" $TRUE $(file_exists $0)
	assertEquals "Output failure case" $FALSE $(file_exists do-not-exist)

	# test with return
	file_exists $0 $FALSE
	assertEquals "Status success case" $TRUE $?
	file_exists do-not-exist $FALSE
	assertEquals "Status failure case" $FALSE $?
}

testFileCleanup()
{
	assertEquals "Function file_cleanup exists" "function" $(type -t file_cleanup)
	
	touch .file.cleanup
	assertEquals "First .file.cleanup file exists" $TRUE $(file_exists .file.cleanup)
	
	mkdir -p .file.cleanup_dir/
	touch .file.cleanup_dir/.file.cleanup
	assertEquals "Second .file.cleanup file exists" $TRUE $(file_exists .file.cleanup_dir/.file.cleanup)
	
	file_cleanup . .file.cleanup
	assertEquals "Exists with success" $TRUE $?
	
	assertEquals "First .file.cleanup gone" $FALSE $(file_exists .todelete)
	assertEquals "Second .file.cleanup gone" $FALSE $(file_exists .todelete_dir/.todelete)
	
	rmdir .file.cleanup_dir/
}

testFileStrReplace()
{
	local str="ab"
	local file=".file.str_replace"
	
	assertEquals "Function file_str_replace exists" "function" $(type -t file_str_replace)
	echo "abcd" > "$file"
	
	file_str_replace "$str" "cd" "$file"
	file_str_replace "cd" "$str" "$file"
	
	assertEquals "The string is succesfully replaced" "abab" $(cat "$file") 
	
	rm -f "$file"
}

source $(which shunit2)
