.POSIX:

VERSION = 0.2

PREFIX  = /usr
BINDIR  = ${PREFIX}/sbin
DATADIR = ${PREFIX}/share
MANDIR  = ${PREFIX}/share/man

all: tinyramfs tinyramfs.8 tinyramfs.config.5 tinyramfs.cmdline.7 tinyramfs.hooks.7

%: %.in
	sed "s/@VERSION@/$(VERSION)/" $^ > $@

%: %.pod
	pod2man --nourls -r $(VERSION) -c ' ' \
		-n $(basename $@) -s $(subst .,,$(suffix $@)) $< > $@

install: all
	install -d ${DESTDIR}${DATADIR}/tinyramfs
	cp -R hooks device-helper init        ${DESTDIR}${DATADIR}/tinyramfs/
	install -m 755 -D tinyramfs           ${DESTDIR}${BINDIR}/tinyramfs
	install -m 644 -D tinyramfs.8         ${DESTDIR}${MANDIR}/man8/tinyramfs.8
	install -m 644 -D tinyramfs.cmdline.7 ${DESTDIR}${MANDIR}/man7/tinyramfs.cmdline.7
	install -m 644 -D tinyramfs.hooks.7   ${DESTDIR}${MANDIR}/man7/tinyramfs.hooks.7
	install -m 644 -D tinyramfs.config.5  ${DESTDIR}${MANDIR}/man5/tinyramfs.config.5

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/tinyramfs
	rm -rf ${DESTDIR}${DATADIR}/tinyramfs
	rm -f  ${DESTDIR}${MANDIR}/man8/tinyramfs.8
	rm -f  ${DESTDIR}${MANDIR}/man7/tinyramfs.cmdline.7
	rm -f  ${DESTDIR}${MANDIR}/man7/tinyramfs.hooks.7
	rm -f  ${DESTDIR}${MANDIR}/man5/tinyramfs.config.5

clean:
	rm -f tinyramfs tinyramfs.8 tinyramfs.cmdline.7 tinyramfs.hooks.7 tinyramfs.config.5

.PHONY: all install uninstall clean
