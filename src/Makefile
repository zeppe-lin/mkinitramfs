.POSIX:

include ../config.mk

BIN8 = mkinitramfs

all: $(BIN8)

$(BIN8):
	sed "s/@VERSION@/$(VERSION)/" $@.in > $@
	chmod 0755 $@

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/sbin
	cp -f $(BIN8) $(DESTDIR)$(PREFIX)/sbin
	chmod 0755 $(DESTDIR)$(PREFIX)/sbin/$(BIN8)
	mkdir -p $(DESTDIR)$(DATADIR)/mkinitramfs
	cp -R helpers/device-helper helpers/init hooks \
		$(DESTDIR)$(DATADIR)/mkinitramfs

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/sbin/$(BIN8)
	rm -rf $(DESTDIR)$(DATADIR)/mkinitramfs

clean:
	rm -f $(BIN8)

.PHONY: all install uninstall clean
