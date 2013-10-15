#!/usr/bin/env bash

source ../lib.bash

testConsoleLog()
{
	assertEquals "Function console.log exists" "function" $(type -t console.log)
	assertNotNull "STDOUT is not empty" "$(console.log message)"
}

testConsoleError()
{
	assertEquals "Function console.error exists" "function" $(type -t console.error)
	assertNull "STDOUT is empty" "$(console.error error 2>/dev/null)"
	assertNull "STDERR is not empty" "$(console.error error >/dev/null 2>&1)"
}

testConsoleFatal()
{
	assertEquals "Function console.fatal exists" "function" $(type -t console.fatal)
	assertNull "STDOUT is empty" "$(console.fatal error 2>/dev/null)"
	assertNull "STDERR is not empty" "$(console.fatal error >/dev/null 2>&1)"
	./s_console.fatal_1
	assertEquals "Standard exit code matches" $FALSE $?
	./s_console.fatal_2
	assertEquals "Custom exit code matches" 255 $?
}

testConsoleConditionalLog()
{
	assertEquals "Function console.conditional_log exists" "function" $(type -t console.conditional_log)
	assertEquals "Output matches" "output" $(console.conditional_log output)
	assertNull "STDOUT is empty" "$(console.conditional_log output $FALSE)"
}

source $(which shunit2)
