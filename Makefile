.POSIX:

include config.mk

all:

install:
	mkdir -p ${DESTDIR}${PREFIX}/sbin
	mkdir -p ${DESTDIR}${MANPREFIX}/man8
	mkdir -p ${DESTDIR}${MANPREFIX}/man7
	mkdir -p ${DESTDIR}${MANPREFIX}/man5
	mkdir -p ${DESTDIR}${DATADIR}
	sed "s/@VERSION@/${VERSION}/" mkinitramfs > \
		${DESTDIR}${PREFIX}/sbin/mkinitramfs
	sed "s/@VERSION@/${VERSION}/" mkinitramfs.config.5 > \
		${DESTDIR}${MANPREFIX}/man5/mkinitramfs.config.5
	sed "s/@VERSION@/${VERSION}/" mkinitramfs.cmdline.7 > \
		${DESTDIR}${MANPREFIX}/man7/mkinitramfs.cmdline.7
	sed "s/@VERSION@/${VERSION}/" mkinitramfs.hooks.7 > \
		${DESTDIR}${MANPREFIX}/man7/mkinitramfs.hooks.7
	sed "s/@VERSION@/${VERSION}/" mkinitramfs.8 > \
		${DESTDIR}${MANPREFIX}/man8/mkinitramfs.8
	cp -R hooks device-helper init ${DESTDIR}${DATADIR}/
	chmod 0755 ${DESTDIR}${PREFIX}/sbin/mkinitramfs
	chmod 0644 ${DESTDIR}${MANPREFIX}/man5/mkinitramfs.config.5
	chmod 0644 ${DESTDIR}${MANPREFIX}/man7/mkinitramfs.cmdline.7
	chmod 0644 ${DESTDIR}${MANPREFIX}/man7/mkinitramfs.hooks.7
	chmod 0644 ${DESTDIR}${MANPREFIX}/man8/mkinitramfs.8

uninstall:
	rm -f  ${DESTDIR}${PREFIX}/sbin/mkinitramfs
	rm -f  ${DESTDIR}${MANPREFIX}/man5/mkinitramfs.config.5
	rm -f  ${DESTDIR}${MANPREFIX}/man7/mkinitramfs.cmdline.7
	rm -f  ${DESTDIR}${MANPREFIX}/man7/mkinitramfs.hooks.7
	rm -f  ${DESTDIR}${MANPREFIX}/man8/mkinitramfs.8
	rm -rf ${DESTDIR}${DATADIR}

install_bashcomp:
	mkdir -p ${DESTDIR}${BASHCOMPDIR}
	cp -f bash_completion ${DESTDIR}${BASHCOMPDIR}/mkinitramfs

uninstall_bashcomp:
	rm -f ${DESTDIR}${BASHCOMPDIR}/mkinitramfs

clean:
	rm -f ${DIST}.tar.gz

dist: clean
	git archive --format=tar.gz -o ${DIST}.tar.gz --prefix=${DIST}/ HEAD

.PHONY: all install uninstall install_bashcomp uninstall_bashcomp clean dist
