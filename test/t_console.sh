#!/usr/bin/env bash

source ../lib.bash

testConsoleLog()
{
	assertEquals "Function console_log exists" "function" $(type -t console_log)
	assertNotNull "STDOUT is not empty" "$(console_log message)"
}

testConsoleError()
{
	assertEquals "Function console_error exists" "function" $(type -t console_error)
	assertNull "STDOUT is empty" "$(console_error error 2>/dev/null)"
	assertNull "STDERR is not empty" "$(console_error error >/dev/null 2>&1)"
}

testConsoleFatal()
{
	assertEquals "Function console_fatal exists" "function" $(type -t console_fatal)
	assertNull "STDOUT is empty" "$(console_fatal error 2>/dev/null)"
	assertNull "STDERR is not empty" "$(console_fatal error >/dev/null 2>&1)"
	./s_console.fatal_1
	assertEquals "Standard exit code matches" $FALSE $?
	./s_console.fatal_2
	assertEquals "Custom exit code matches" 255 $?
}

testConsoleConditionalLog()
{
	assertEquals "Function console_conditional_log exists" "function" $(type -t console_conditional_log)
	assertEquals "Output matches" "output" $(console_conditional_log output)
	assertNull "STDOUT is empty" "$(console_conditional_log output $FALSE)"
}

testConsoleStripColors()
{
	local string="\e[32;1mPASS\e[0m"
	string=$(console_strip_colors "$string")
	assertEquals "Function console_strip_colors exists" "function" $(type -t console_strip_colors)
	assertEquals "Output matches" "PASS" "$string"
}

source $(which shunit2)
