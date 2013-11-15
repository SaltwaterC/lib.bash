###
## Console module
## Depends on: number
###

# /*!
# @abstract Prints the message to STDOUT
# @discussion
#<strong>Example:</strong><pre>
#console_log Text to output to STDOUT.</pre>
# @indexgroup console
# @param $message The message to print to STDOUT
# */
function console_log
{
	echo "$@"
}

# /*!
# @abstract Prints the message to STDERR
# @discussion
#<strong>Example:</strong><pre>
#console_error Text to output to STDERR.</pre>
# @indexgroup console
# @param $message The message to print to STDERR
# */
function console_error
{
	echo "$@" 1>&2
}

# /*!
# @abstract Prints the message to STDERR then exists with 1 or the code specified by
# $exit_code
# @discussion
#<strong>Examples:</strong><pre>
## notice the quoting of the string, unlike console_log and console_error
#
## exit with default code 1
#console_fatal "Fatal Error: reason"
#
## exit with custom code 255
#console_fatal 255 "Fatal Error: reason"</pre>
# @indexgroup console
# @param $exit_code Optional argument; The exit code
# @param $message The message to print to STDERR
# */
function console_fatal
{
	local status=$FALSE
	
	if [ $(number_is_int "$1") -eq $TRUE ]
	then
		status=$1
		shift
	fi
	
	console_error "$@"
	exit $status
}

# /*!
# @abstract Prints the message to STDOUT without ending newline if the second argument is
# null or non-zero
# @discussion
#<strong>Examples:</strong><pre>
## notice the quoting of the string, unlike console_log and console_error
#
## this shows up in STDOUT
#console_conditional_log "Text to output to STDOUT."
## this won't show up in STDOUT
#console_conditional_log "Text to output to STDOUT." $FALSE</pre>
# @indexgroup console
# @param $message The message to print to STDOUT if $no_print is null or
# non-zero
# @param $no_print Flag for turning off the print
# */
function console_conditional_log
{
	# no shorter or more elegant way to write this
	# unfortunately there's no lazy evaluation
	# and the type mismatch throws errors
	if [ -z "$2" ]
	then
		echo -n "$1"
	else
		if [ $2 -eq $TRUE ]
		then
			echo -n "$1"
		fi
	fi
}

# /*!
# @abstract Strips the color codes from the input string
# @discussion
#<strong>Example:</strong><pre>
## this is a green PASS
#console_strip_colors "\e[32;1mPASS\e[0m"
## outputs PASS</pre>
# @indexgroup console
# @param $string The string containing color codes that need to be stripped
# */
function console_strip_colors
{
	echo -e "$@" | $SED_BIN "s:\x1B\[[0-9;]*[mK]::g"
}
