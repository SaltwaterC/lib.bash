###
## Number module
## Depends on: console
###

# /*!
# @abstract Checks if the argument is an integer
# @discussion
#<strong>Examples:</strong><pre>
## this is an int
#number_is_int 1
## outputs 0, returns 0
#
## this is not an int
#number_is_int a
## outputs 1, returns 1
#
## this is not an int
#number_is_int 1.1 $FALSE
## returns 1</pre>
# @indexgroup number
# @param $int Supposedly an integer value
# @param $no_print Don't print the output. Defaults to falsy
# @returns The exit code of printf
# */
function number_is_int
{
	test "$1" && printf "%d" "$1" >/dev/null 2>&1
	local status=$?
	console_conditional_log $status "$2"
	return $status
}
