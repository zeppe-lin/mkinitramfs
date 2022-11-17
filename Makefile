# This file is a part of mkinitramfs.
# See COPYING and COPYRIGHT files for corresponding information.

.POSIX:

VERSION = 0.2.2

PREFIX  = /usr/local
BINDIR  = ${PREFIX}/sbin
DATADIR = ${PREFIX}/share
MANDIR  = ${PREFIX}/share/man

all: mkinitramfs mkinitramfs.8 mkinitramfs.config.5 \
	mkinitramfs.cmdline.7 mkinitramfs.hooks.7

%: %.in
	sed "s/@VERSION@/${VERSION}/" $^ > $@

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' \
		-n $(basename $@) -s $(subst .,,$(suffix $@)) $< > $@

install: all
	install -d ${DESTDIR}${DATADIR}/mkinitramfs
	cp -R hooks device-helper init \
		${DESTDIR}${DATADIR}/mkinitramfs/
	install -m 0755 -Dt ${DESTDIR}${BINDIR}/       mkinitramfs
	install -m 0644 -Dt ${DESTDIR}${MANDIR}/man8/  mkinitramfs.8
	install -m 0644 -Dt ${DESTDIR}${MANDIR}/man7/ \
		mkinitramfs.cmdline.7 mkinitramfs.hooks.7
	install -m 0644 -Dt ${DESTDIR}${MANDIR}/man5/ \
		mkinitramfs.config.5

uninstall:
	rm -f  ${DESTDIR}${BINDIR}/mkinitramfs
	rm -f  ${DESTDIR}${MANDIR}/man8/mkinitramfs.8
	rm -f  ${DESTDIR}${MANDIR}/man7/mkinitramfs.cmdline.7
	rm -f  ${DESTDIR}${MANDIR}/man7/mkinitramfs.hooks.7
	rm -f  ${DESTDIR}${MANDIR}/man5/mkinitramfs.config.5
	rm -rf ${DESTDIR}${DATADIR}/mkinitramfs/

clean:
	rm -f mkinitramfs mkinitramfs.8 mkinitramfs.cmdline.7 \
		mkinitramfs.hooks.7 mkinitramfs.config.5

.PHONY: all install uninstall clean

# vim:cc=72:tw=70
# End of file.
