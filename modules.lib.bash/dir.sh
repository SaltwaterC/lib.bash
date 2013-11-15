###
## Directories module
## Depends on: console
###

# /*!
# @abstract Checks if a directory exists
# @discussion
#<strong>Example:</strong><pre>
#if [ $(dir_exists "${dir_path}") -eq $FALSE ]
#then
#	# do something about the missing directory
#fi</pre><strong>Notice:</strong> if the performance is a concern, use if with
#the -d flag. This function favors readability.
# @indexgroup dir
# @param $dir_path The directory path to check
# @param $no_print Don't print the output. Defaults to falsy
# @returns The exit code of test -d
# */
function dir_exists
{
	test -d "$1"
	local status=$?
	console_conditional_log $status "$2"
	return $status
}

# /*!
# @abstract Recursive delete of all the directories and their contents having the input
# name into the target directory
# @discussion
#<strong>Example:</strong><pre>
## cleanup a SVN working copy
#dir_cleanup "${working_copy_path}" ".svn"</pre>
# @indexgroup dir
# @param $target_dir The target directory containing all the subdirectories
# having the same name that you wish to remove
# @param $dir_name The directory name that you wish to remove
# @returns The exit code find | xargs execution
# */
function dir_cleanup
{
	find "$1" -name "$2" -type d -print0 | xargs -0 rm -rf
	return $?
}

# /*!
# @abstract Prints the absolute path of the input directory.
# Depends on: GNU readlink, "greadlink" on OS X and FreeBSD
# @discussion
#<strong>Example:</strong><pre>
## print the absolute path of the current directory
#dir_absolute_path .</pre>
# @indexgroup dir
# @param $dir_name The directory name for which you need an absolute path
# without the ending newline
# @returns The exit code of the readlink execution
# */
function dir_absolute_path
{
	local READLINK=$(which greadlink || which readlink)
	local absolute_path=$($READLINK -f "$1")
	local status=$?
	echo -n "${absolute_path}"
	return $status
}
