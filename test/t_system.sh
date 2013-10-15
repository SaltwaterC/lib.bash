#!/usr/bin/env bash

source ../lib.bash

testSystemDenyNonRoot()
{
	assertEquals "Function system.deny_non_root exists" "function" $(type -t system.deny_non_root)
	if [ $(id -u) -eq 0 ]
	then
		console.log Superuser test
		# running under superuser, test success
		assertNull "STDOUT is empty" "$(system.deny_non_root)"
		assertNull "STDERR is empty" "$(system.deny_non_root 2>&1)"
		./s_system.deny_non_root
		assertEquals "Exit code matches" 0 $?
	else
		console.log User test
		# running under user, test failure
		assertNull "STDOUT is empty" "$(system.deny_non_root 2>/dev/null)"
		assertNull "STDERR is not empty" "$(system.deny_non_root >/dev/null 2>&1)"
		./s_system.deny_non_root
		assertEquals "Exit code matches" 1 $?
	fi
}

source $(which shunit2)
