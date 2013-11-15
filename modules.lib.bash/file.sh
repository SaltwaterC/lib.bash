###
## Files module
## Depends on: console
###

# /*!
# @abstract Checks if a file exists
# @discussion
#<strong>Example:</strong><pre>
#if [ $(file_exists "${file_path}") -eq $FALSE ]
#then
#	# do something about the missing file
#fi</pre><strong>Notice:</strong> if the performance is a concern, use if with 
#the -e flag (or any appropriate file related flag). This function favors 
#readability.
# @indexgroup file
# @param $file_path The file path to check
# @param $no_print Don't print the output. Defaults to falsy
# @returns The exit status of test -e
# */
function file_exists
{
	test -e "$1"
	local status=$?
	console_conditional_log $status "$2"
	return $status
}

# /*!
# @abstract Recursive delete of all the files having the input name into the
# target directory
# @discussion
#<strong>Example:</strong><pre>
## remove all the .gitignore files from the current directory and subdirectories
#file_cleanup . .gitignore</pre>
# @indexgroup file
# @param $target_directory The target directory containing the files with the
# name that you wish to remove
# @param $file_name The file name that you wish to remove
# @returns The exit code of find | xargs
# */
function file_cleanup
{
	find "$1" -name "$2" -type f -print0 | xargs -0 rm -f
	return $?
}

# /*!
# @abstract Replace the search string with the replace string in input file.
# Depends on: GNU sed, "gsed" on OS X and FreeBSD
# @discussion
#<strong>Example:</strong><pre>
## replace all appearances of "foo" with "bar" from file targeted by "${file_path}"
#file_str_replace "foo" "bar" "${file_path}"
# @indexgroup file
# @param $search The string value being searched for
# @param $replace The replacement value that replaces the found $search
# @param $file The file path
# */
function file_str_replace
{
	$SED_BIN -i "s/$1/$2/g" "$3"
}
