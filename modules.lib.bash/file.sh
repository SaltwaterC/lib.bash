###
## Files module
## Depends on: console
###

##
# Checks if a file exists
# @param $file
# @param $no_print - defaults to false
# @returns $status
#
function file.exists
{
	test -e "$1"
	local status=$?
	console.conditional_log $status "$2"
	return $status
}
