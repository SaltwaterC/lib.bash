###
## Global module loader
###

export LIB_BASH_VERSION="0.1-dev"

readlink=$(which greadlink || which readlink)
this_dir="$(dirname $($readlink -f ${BASH_SOURCE[0]}))"
modules_dir="modules.lib.bash"

for module in $(ls ${this_dir}/${modules_dir}/*.sh)
do
	source "$module"
done
