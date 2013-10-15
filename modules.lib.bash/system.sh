###
## System module
## Depends on: console
###

##
# Checks if the current user is root
#
function system.deny_non_root
{
	test $(id -u) -eq 0
	test $? -ne 0 && console.fatal "The root user must run this script."
}
