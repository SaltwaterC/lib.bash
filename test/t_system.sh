#!/usr/bin/env bash

source ../lib.bash

testSystemDenyNonRoot()
{
	assertEquals "Function system_deny_non_root exists" "function" $(type -t system_deny_non_root)
	if [ $(id -u) -eq 0 ]
	then
		console_log Superuser test
		# running under superuser, test success
		assertNull "STDOUT is empty" "$(system_deny_non_root)"
		assertNull "STDERR is empty" "$(system_deny_non_root 2>&1)"
		./s_system.deny_non_root
		assertEquals "Exit code matches" $TRUE $?
	else
		console_log User test
		# running under user, test failure
		assertNull "STDOUT is empty" "$(system_deny_non_root 2>/dev/null)"
		assertNull "STDERR is not empty" "$(system_deny_non_root >/dev/null 2>&1)"
		./s_system.deny_non_root
		assertEquals "Exit code matches" $FALSE $?
	fi
}

source $(which shunit2)
