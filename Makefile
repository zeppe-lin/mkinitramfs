.POSIX:

include config.mk

SUBDIRS = completion man src

all lint install uninstall clean:
	for subdir in $(SUBDIRS); do (cd $$subdir; $(MAKE) $@); done

release:
	git tag -a v$(VERSION) -m v$(VERSION)

.PHONY: all lint install uninstall clean release
