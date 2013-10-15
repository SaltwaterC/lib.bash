###
## Global module loader and variable definitions
###

export LIB_BASH_VERSION="0.1-dev"

# boolean stuff
export TRUE=0
export FALSE=1

# color stuff
test -z "$TERM" && export TERM=xterm-color
export BOLD=$(tput bold)
export NORM=$(tput sgr0)

this_dir="$(dirname $BASH_SOURCE[0])"
for module in $(ls ${this_dir}/modules.lib.bash/*.sh)
do
	source "$module"
done
