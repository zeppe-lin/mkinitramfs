ABOUT
-----
This directory contains _mkinitramfs_, a tool used to create a Linux
boot image (initramfs).

This _mkinitramfs_ distribution is a fork of illiliti's _tinyramfs_ as
of commit 8abfcc9 (Fri May 21 2021) with the following differences:
  * the man pages have been completely rewritten
  * added smdev hook
  * luks hook have been modified to ask the password if
    header/key-file is not defined
  * added resume hook (to resume machines from hibernation)
  * added a possibility to copy _modprobe.d_ configuration files
  * added bash completion

See git log for complete/further differences.

The original sources can be downloaded from:
  1. https://github.com/illiliti/tinyramfs
  2. https://github.com/illiliti/tinyramfs/archive/8abfcc9/tinyramfs-8abfcc9.zip

FEATURES
--------
  * no "local"s, no bashisms, only POSIX shell
  * portable, no distro specific
  * easy to use configuration
  * build time and init time hooks
  * LUKS (detached header, key, password), LVM
  * smdev, mdev, mdevd, eudev, systemd-udevd

REQUIREMENTS
------------
Build time:
  * POSIX sh(1p), make(1p) and "mandatory utilities"
  * pod2man(1pm) to build man pages

Runtime:
  * POSIX sh(1p) and standard POSIX utilities
  * switch_root(8), mount(8), cpio(1)

  The following runtime dependencies are optional:

  * ldd(1) required for copying binary dependencies
  * strip(1p) required for reducing image size by stripping binaries
  * blkid(8) required for UUID, LABEL, PARTUUID support
  * smdev OR mdev OR mdevd OR eudev OR systemd-udevd or CONFIG_UEVENT_HELPER
    required for modular kernel, `/dev/mapper/*` and `/dev/disk/*`
  * lvm(8) required for LVM support
  * cryptsetup(8) required for LUKS support
  * busybox' loadkmap required for keymap support
  * kmod OR busybox' modutils+[patch](patches/modprobe-kernel-version.patch)
    required for monolithic kernel

Tests:
  * podchecker(1pm) to check PODs for errors
  * curl(1) to check URLs for response code

INSTALL
-------
The shell commands `make && make install` should build and install
this package.

The shell command `make check` should start some tests.

USAGE
-----
To use _mkinitramfs_, read [mkinitramfs.config(5)](mkinitramfs.config.5.pod)
and setup `/etc/mkinitramfs/config` file conform your needs.  Next,
run the following command:

```sh
sudo mkinitramfs -o "/boot/initramfs-$(uname -r).img"
```
Then update your bootloader config (i.e. grub):
```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
Reboot.

CREDITS
-------
  * illiliti    <https://github.com/illiliti>
  * E5ten       <https://github.com/E5ten>
  * dylanaraps  <https://github.com/dylanaraps>

You can donate if you like this project to the original author:
illilliti: (BTC) 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK

LICENSE
-------
_mkinitramfs_ is licensed through the GNU General Public License v3 or
later <https://gnu.org/licenses/gpl.html>.
Read the _COPYING_ file for copying conditions.
Read the _COPYRIGHT_ file for copyright notices.

<!-- vim:sw=2:ts=2:sts=2:et:cc=72:tw=70
End of file. -->
