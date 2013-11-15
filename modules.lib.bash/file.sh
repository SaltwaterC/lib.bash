###
## Files module
## Depends on: console
###

##
# Checks if a file exists
# @param $file_path
# @param $no_print - defaults to falsy
# @returns $status
#
function file.exists
{
	test -e "$1"
	local status=$?
	console.conditional_log $status "$2"
	return $status
}

##
# Recursive delete of all the files having the input name into the target
# directory
# @param $target_directory
# @param $file_name
# @returns $status
#
function file.cleanup
{
	find "$1" -name "$2" -type f -print0 | xargs -0 rm -f
	return $?
}

##
# Replace the target string with the source string in file
# Depends on: GNU sed, "gsed" on OS X and FreeBSD
# @param $target
# @param $source
# @param $file
#
function file.str_replace
{
	$SED_BIN -i "s/$1/$2/g" "$3"
}
