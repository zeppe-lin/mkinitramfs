.POSIX:

include config.mk

all: mkinitramfs mkinitramfs.8 mkinitramfs.config.5 \
	mkinitramfs.cmdline.7 mkinitramfs.hooks.7

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r ${VERSION} -c ' ' \
		-n $(basename $@) -s $(subst .,,$(suffix $@)) $< > $@

check:
	@echo "=======> Check PODs for errors"
	@podchecker *.pod
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.* | xargs -P10 -I{} \
		curl -o /dev/null -sw "%{url} [%{http_code}]\n" '{}'

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
	cp -R hooks device-helper init ${DESTDIR}/usr/share/mkinitramfs/
	chmod 0755 ${DESTDIR}/usr/share/mkinitramfs/device-helper
	chmod 0755 ${DESTDIR}/usr/share/mkinitramfs/init

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
