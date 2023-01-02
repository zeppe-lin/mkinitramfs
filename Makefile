.POSIX:

# mkinitramfs version
VERSION = 0.2.2

all: mkinitramfs mkinitramfs.8 mkinitramfs.config.5 \
	mkinitramfs.cmdline.7 mkinitramfs.hooks.7

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' \
		-n $(basename $@) -s $(subst .,,$(suffix $@)) $< > $@

check:
	@podchecker *.pod
	@grep -Eiho "https?://[^\"\\'> ]+" *.* | httpx -silent -fc 200 -sc

install: all
	mkdir -p                       ${DESTDIR}/usr/sbin
	mkdir -p                       ${DESTDIR}/usr/share/man/man8
	mkdir -p                       ${DESTDIR}/usr/share/man/man7
	mkdir -p                       ${DESTDIR}/usr/share/man/man5
	mkdir -p                       ${DESTDIR}/usr/share/mkinitramfs
	cp -f mkinitramfs              ${DESTDIR}/usr/sbin/
	chmod 0755                     ${DESTDIR}/usr/sbin/mkinitramfs
	cp -f mkinitramfs.8            ${DESTDIR}/usr/share/man/man8/
	cp -f mkinitramfs.cmdline.7    ${DESTDIR}/usr/share/man/man7/
	cp -f mkinitramfs.hooks.7      ${DESTDIR}/usr/share/man/man7/
	cp -f mkinitramfs.config.5     ${DESTDIR}/usr/share/man/man5/
	cp -R hooks device-helper init ${DESTDIR}/usr/share/mkinitramfs

uninstall:
	rm -f  ${DESTDIR}/usr/sbin/mkinitramfs
	rm -f  ${DESTDIR}/usr/share/man8/mkinitramfs.8
	rm -f  ${DESTDIR}/usr/share/man7/mkinitramfs.cmdline.7
	rm -f  ${DESTDIR}/usr/share/man7/mkinitramfs.hooks.7
	rm -f  ${DESTDIR}/usr/share/man5/mkinitramfs.config.5
	rm -rf ${DESTDIR}/usr/share/mkinitramfs/

clean:
	rm -f mkinitramfs mkinitramfs.8 mkinitramfs.cmdline.7 \
		mkinitramfs.hooks.7 mkinitramfs.config.5

.PHONY: all install uninstall clean
