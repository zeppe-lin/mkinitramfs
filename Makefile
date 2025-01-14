.POSIX:

include config.mk

all lint install uninstall clean:
	cd completion && $(MAKE) $@
	cd man && $(MAKE) $@
	cd src && $(MAKE) $@

release:
	git tag -a v$(VERSION) -m v$(VERSION)

.PHONY: all lint install uninstall clean release
