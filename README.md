mkinitramfs - tiny initramfs generator
======================================
mkinitramfs is a tool used to create a Linux boot image (initramfs).

This mkinitramfs distribution is a fork of illiliti's tinyramfs as of
commit 8abfcc9 (Fri May 21 2021).  The man pages have been completely
rewritten.  Added [smdev](hooks/smdev) hook.  [LUKS](hooks/luks)
hook have been modified to ask the password if header/key-file is not
defined.  Added [resume](hooks/resume) hook to resume machines from
hibernation.  Added a possibility to copy *modprobe.d* configuration
files.  Added bash completion.

The original sources can be downloaded from:
1.
   ```sh
   git clone https://github.com/illiliti/tinyramfs
   git checkout 8abfcc9
   ```
2. https://github.com/illiliti/tinyramfs/archive/8abfcc9/tinyramfs-8abfcc9.zip


Features
--------
* no "local"s, no bashisms, only POSIX shell
* portable, no distro specific
* easy to use configuration
* build time and init time hooks
* LUKS (detached header, key, password), LVM
* smdev, mdev, mdevd, eudev, systemd-udevd


Dependencies
------------
**Build time:**
- make(1p), sh(1p) and standard POSIX utilities like sed(1p),
  mkdir(1p), cp(1p), rm(1p)
- podchecker(1pm) and pod2man(1pm) from perl distribution

**Runtime:**
- sh(1p) and standard POSIX utilities
- switch_root(8), mount(8), cpio(1)
- ldd(1) is optional, required for copying binary dependencies
- strip(1p) is optional, required for reducing image size by
  stripping binaries
- blkid(8) is optional, required for `UUID`, `LABEL`, `PARTUUID`
  support
- smdev OR mdev OR mdevd OR eudev OR systemd-udevd OR
  [CONFIG_UEVENT_HELPER][1] is/are optional, required for modular
  kernel, `/dev/mapper/*` and `/dev/disk/*`)
- lvm(8) is optional, required for LVM support
- cryptsetup(8) is optional, required for LUKS support
- busybox' loadkmap is optional, required for keymap support
- kmod OR (busybox' modutils + `patches/modprobe-kernel-version.patch`)
  is/are optional, not required for monolithic kernel


Install
-------
The shell commands `make; make install` should build and install this
package.  See `Makefile` for configuration parameters.


Usage
-----
To use mkinitramfs, read
[mkinitramfs.config(5)](mkinitramfs.config.5.pod) and setup
`/etc/mkinitramfs/config` file conform your needs.  Next, run as root:

```sh
mkinitramfs -o "/boot/initramfs-$(uname -r).img"
```

Then update your bootloader config (i.e. grub):

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

And reboot.


Credits
-------
- illiliti <https://github.com/illiliti>
- E5ten <https://github.com/E5ten>
- dylanaraps <https://github.com/dylanaraps>

You can donate if you like this project to the original author:
illilliti: (BTC) 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK .


License and Copyright
---------------------
mkinitramfs is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.<br>
Read the COPYING file for copying conditions.<br>
Read the COPYRIGHT file for copyright notices.


[1]: https://cateee.net/lkddb/web-lkddb/UEVENT_HELPER.html

<!-- vim:ft=markdown:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->
