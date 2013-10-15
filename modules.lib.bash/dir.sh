###
## Directories module
## Depends on: console
###

##
# Checks if a directory exists
# @param $dir
# @param $no_print - defaults to falsy
#
function dir.exists
{
	test -d "$1"
	local status=$?
	console.conditional_log $status "$2"
	return $status
}

##
# Recursive delete of all the directories and their contents having the input
# name into the target directory
# @param $target_directory
# @param $directory_name
#
function dir.cleanup
{
	find "$1" -name "$2" -type d -print0 | xargs -0 rm -rf
	return $?
}
