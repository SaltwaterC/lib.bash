###
## System module
## Depends on: console
###

# /*!
# @abstract Checks if the current user is root. Exit the script with error
# status otherwise
# @discussion
#<strong>Example:</strong><pre>
## simply add this at the top of the section of the code requiring superuser
#system_deny_non_root</pre>
# @indexgroup system
# */
function system_deny_non_root
{
	test $(id -u) -eq 0
	test $? -ne $TRUE && console_fatal "The root user must run this script."
}
