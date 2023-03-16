.POSIX:

include config.mk

BIN8 = mkinitramfs
MAN5 = mkinitramfs.config.5
MAN7 = mkinitramfs.cmdline.7 mkinitramfs.hooks.7
MAN8 = mkinitramfs.8
DATA = hooks device-helper init

all: ${BIN8} ${MAN5} ${MAN7} ${MAN8}

%: %.in
	sed "s/@VERSION@/${VERSION}/" $< > $@

%: %.pod
	pod2man --nourls -r "${NAME} ${VERSION}" -c ' ' \
		-n $(basename $@) -s $(subst .,,$(suffix $@)) $< > $@

install: all
	mkdir -p ${DESTDIR}/usr/sbin
	mkdir -p ${DESTDIR}/usr/share/man/man8
	mkdir -p ${DESTDIR}/usr/share/man/man7
	mkdir -p ${DESTDIR}/usr/share/man/man5
	mkdir -p ${DESTDIR}/usr/share/mkinitramfs
	cp -f ${BIN8} ${DESTDIR}/usr/sbin/
	cp -f ${MAN5} ${DESTDIR}/usr/share/man/man5/
	cp -f ${MAN7} ${DESTDIR}/usr/share/man/man7/
	cp -f ${MAN8} ${DESTDIR}/usr/share/man/man8/
	cp -R ${DATA} ${DESTDIR}/usr/share/mkinitramfs/
	cd ${DESTDIR}/usr/sbin              && chmod 0755 ${BIN8}
	cd ${DESTDIR}/usr/share/man/man5    && chmod 0644 ${MAN5}
	cd ${DESTDIR}/usr/share/man/man7    && chmod 0644 ${MAN7}
	cd ${DESTDIR}/usr/share/man/man8    && chmod 0644 ${MAN8}
	cd ${DESTDIR}/usr/share/mkinitramfs && chmod 0755 device-helper init

uninstall:
	cd ${DESTDIR}/usr/sbin           && rm -f ${BIN8}
	cd ${DESTDIR}/usr/share/man/man5 && rm -f ${MAN5}
	cd ${DESTDIR}/usr/share/man/man7 && rm -f ${MAN7}
	cd ${DESTDIR}/usr/share/man/man8 && rm -f ${MAN8}
	rm -rf ${DESTDIR}/usr/share/mkinitramfs/

clean:
	rm -f ${BIN8} ${MAN5} ${MAN7} ${MAN8}

.PHONY: all install uninstall clean
