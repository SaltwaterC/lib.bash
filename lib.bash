###
## Global module loader and variable definitions
###

export LIB_BASH_VERSION="0.1-dev"

# boolean stuff
export TRUE=0
export FALSE=1

# color stuff
export BOLD=$(tput -T xterm-color bold)
export NORM=$(tput -T xterm-color sgr0)

this_dir="$(dirname $BASH_SOURCE[0])"
for module in $(ls ${this_dir}/modules.lib.bash/*.sh)
do
	source "$module"
done
