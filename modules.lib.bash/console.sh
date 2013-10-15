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
# Prints the message to STDERR then exists with 1 or input code
# @param $exit_code - optional argument
# @param $message
#
function console.fatal
{
	local status=1
	
	if [ $(number.is_int "$1") -eq 0 ]
	then
		status=$1
		shift
	fi
	
	console.error "$@"
	exit $status
}

##
# Prints the message to STDOUT without ending newline if the second argument is
# null or non-zero
# @param $message
# @param $no_print
#
function console.conditional_log
{
	# no shorter or more elegant way to write this
	# unfortunately there's no lazy evaluation
	# and the type mismatch throws errors
	if [ -z "$2" ]
	then
		echo -n "$1"
	else
		if [ $2 -eq 0 ]
		then
			echo -n "$1"
		fi
	fi
}
