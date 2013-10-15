###
## Global module loader
###

export LIB_BASH_VERSION="0.1-dev"
this_dir="$(dirname $BASH_SOURCE[0])"

for module in $(ls ${this_dir}/modules.lib.bash/*.sh)
do
	source "$module"
done
