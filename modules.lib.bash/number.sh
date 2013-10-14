###
## Number module
## Depends on: console
###

##
# Checks if the argument is an integer
# @param $int
# @param $no_print - defaults to false
# @returns $status
#
function number.is_int
{
	test "$1" && printf "%d" "$1" >/dev/null 2>&1
	local status=$?
	console.conditional_log $status "$2"
	return $status
}
