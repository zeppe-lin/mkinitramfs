.POSIX:

include config.mk

all lint install uninstall clean:
	cd completion && $(MAKE) $@
	cd man && $(MAKE) $@
	cd src && $(MAKE) $@

.PHONY: all lint install uninstall clean
