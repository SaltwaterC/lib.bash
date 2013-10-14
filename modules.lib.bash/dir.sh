###
## Directories module
## Depends on: console
###

##
# Checks if a directory exists
# @param $dir
# @param $no_print - defaults to false
#
function dir.exists
{
	test -d "$1"
	local status=$?
	console.conditional_log $status "$2"
	return $status
}
