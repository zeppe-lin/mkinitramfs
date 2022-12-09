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

check:
	@podchecker *.pod
	@grep -Eiho "https?://[^\"\\'> ]+" *.* | httpx -silent -fc 200 -sc

install: all
	mkdir -p ${DESTDIR}${BINDIR}
	mkdir -p ${DESTDIR}${MANDIR}/man5
	mkdir -p ${DESTDIR}${MANDIR}/man7
	mkdir -p ${DESTDIR}${MANDIR}/man8
	mkdir -p ${DESTDIR}${DATADIR}/mkinitramfs
	cp -f mkinitramfs              ${DESTDIR}${BINDIR}/
	chmod 0755 ${DESTDIR}${BINDIR}/mkinitramfs
	cp -f mkinitramfs.8            ${DESTDIR}${MANDIR}/man8/
	cp -f mkinitramfs.cmdline.7    ${DESTDIR}${MANDIR}/man7/
	cp -f mkinitramfs.hooks.7      ${DESTDIR}${MANDIR}/man7/
	cp -f mkinitramfs.config.5     ${DESTDIR}${MANDIR}/man5/
	cp -R hooks device-helper init ${DESTDIR}${DATADIR}/mkinitramfs

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
