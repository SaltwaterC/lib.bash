#!/usr/bin/env bash

source ../lib.bash

testTrue()
{
	assertEquals "Testing the shell TRUE value" 0 $TRUE
}

testFalse()
{
	assertEquals "Testing the shell FALSE value" 1 $FALSE
}

source $(which shunit2)
