.PHONY: all
.DEFAULT: all

all:
	@tools/test.sh

doc:
	headerdoc2html -o docs framework.hdoc lib.bash modules.lib.bash
	gatherheaderdoc docs

test: all
tests: all
check: all

install:
	install -o root -m 644 lib.bash /usr/lib
	install -o root -m 755 -d /usr/lib/modules.lib.bash
	install -o root -m 644 modules.lib.bash/*.sh /usr/lib/modules.lib.bash

uninstall:
	rm -v "/usr/lib/lib.bash"
	rm -rfv "/usr/lib/modules.lib.bash"
