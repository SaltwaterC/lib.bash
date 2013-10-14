###
## Console module
## Depends on: number
###

##
# Prints the message to STDOUT
# @param $message
#
function console.log
{
	echo "$@"
}

##
# Prints the message to STDERR
# @param $message
#
function console.error
{
	echo "$@" 1>&2
}

##
# Prints the message to STDERR then exists with 1
# @param $message
#
function console.fatal
{
	console.error "$@"
	exit 1
}

##
# Prints the message to STDOUT without ending newline if the second argument is null
# @param $message
# @param $no_print
#
function console.conditional_log
{
	if [ -z "$2" ]
	then
		echo -n "$1"
	fi
}
