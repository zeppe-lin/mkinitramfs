.POSIX:

include ../config.mk

MAN5 = mkinitramfs.config.5
MAN7 = mkinitramfs.cmdline.7 mkinitramfs.hooks.7
MAN8 = mkinitramfs.8

all: $(MAN5) $(MAN7) $(MAN8)

$(MAN5) $(MAN7) $(MAN8):
	scdoc < $@.scdoc > $@

lint:
	mandoc -Tlint $(MAN5) $(MAN7) $(MAN8)

install: all
	mkdir -p $(DESTDIR)$(MANPREFIX)/man5
	mkdir -p $(DESTDIR)$(MANPREFIX)/man7
	mkdir -p $(DESTDIR)$(MANPREFIX)/man8
	cp -f $(MAN5) $(DESTDIR)$(MANPREFIX)/man5
	cp -f $(MAN7) $(DESTDIR)$(MANPREFIX)/man7
	cp -f $(MAN8) $(DESTDIR)$(MANPREFIX)/man8
	cd $(DESTDIR)$(MANPREFIX)/man5 && chmod 0644 $(MAN5)
	cd $(DESTDIR)$(MANPREFIX)/man7 && chmod 0644 $(MAN7)
	cd $(DESTDIR)$(MANPREFIX)/man8 && chmod 0644 $(MAN8)

uninstall:
	cd $(DESTDIR)$(MANPREFIX)/man5 && rm -f $(MAN5)
	cd $(DESTDIR)$(MANPREFIX)/man7 && rm -f $(MAN7)
	cd $(DESTDIR)$(MANPREFIX)/man8 && rm -f $(MAN8)

clean:
	rm -f $(MAN5) $(MAN7) $(MAN8)

.PHONY: all lint install uninstall clean
