###
## Directories module
## Depends on: console
###

##
# Checks if a directory exists
# @param $dir_name
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
# @param $target_dir
# @param $dir_name
# @returns $status
#
function dir.cleanup
{
	find "$1" -name "$2" -type d -print0 | xargs -0 rm -rf
	return $?
}

##
# Prints the absolute path of the input directory
# Depends on: GUN readlink, "greadlink" on OS X and FreeBSD
# @param $dir_name
# @returns $status
#
function dir.absolute_path
{
	local READLINK=$(which greadlink || which readlink)
	local absolute_path=$($READLINK -f "$1")
	local status=$?
	echo -n "${absolute_path}"
	return $status
}
