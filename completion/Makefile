.POSIX:

include ../config.mk

all:

install:
	mkdir -p $(DESTDIR)$(BASHCOMPDIR)
	cp -f bash_completion $(DESTDIR)$(BASHCOMPDIR)/mkinitramfs

uninstall:
	rm -f $(DESTDIR)$(BASHCOMPDIR)/mkinitramfs

clean:

.PHONY: all install uninstall clean
