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
	local status=$?
	
	if [ $status -ne 0 ]
	then
		console.fatal "The root must run this command!"
	fi
}
