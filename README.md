OVERVIEW
--------
This directory contains mkinitramfs, a tool used to create a Linux boot image
(initramfs).

This distribution is a fork of illiliti's tinyramfs as of commit 8abfcc9 (Fri
May 21 2021) with the following differences:
- the man pages have been completely rewritten
- added smdev hook
- luks hook have been modified to ask the password if header/key-file is not
  defined
- added resume hook (to resume machines from hibernation)
- added a possibility to copy modprobe.d configuration files
- added bash completion

See git log for complete/further differences.

The original sources can be downloaded from:
1. https://github.com/illiliti/tinyramfs
2. https://github.com/illiliti/tinyramfs/archive/8abfcc9/tinyramfs-8abfcc9.zip


FEATURES
--------
The following advantages can be distinguished:
- no "local"s, no bashisms, only POSIX shell
- portable, no distro specific
- easy to use configuration
- build time and init time hooks
- LUKS (detached header, key, password), LVM
- smdev, mdev, mdevd, eudev, systemd-udevd


REQUIREMENTS
------------
**Build time**:
- POSIX sh(1p), make(1p) and "mandatory utilities"
- pod2man(1pm) to build man pages

**Runtime**:
- POSIX sh(1p) and standard POSIX utilities
- switch_root(8), mount(8), cpio(1)

The following runtime dependencies are optional:

- ldd(1) required for copying binary dependencies
- strip(1p) required for reducing image size by stripping binaries
- blkid(8) required for UUID, LABEL, PARTUUID support
- smdev OR mdev OR mdevd OR eudev OR systemd-udevd or CONFIG_UEVENT_HELPER
  required for modular kernel, /dev/mapper/* and /dev/disk/*
- lvm(8) required for LVM support
- cryptsetup(8) required for LUKS support
- busybox' loadkmap required for keymap support
- kmod OR busybox' modutils+[patch][1] required for monolithic kernel

[1]: /patches/modprobe-kernel-version.patch


INSTALL
-------
The shell commands `make && make install` should build and install this
package.


USAGE
-----
To use mkinitramfs, read mkinitramfs.config(5) and setup
/etc/mkinitramfs/config file conform your needs.  Next, run the following
command:

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
- illiliti    <https://github.com/illiliti>
- E5ten       <https://github.com/E5ten>
- dylanaraps  <https://github.com/dylanaraps>

You can donate if you like this project to the original author:
illilliti / (BTC) 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK


LICENSE
-------
mkinitramfs is licensed through the GNU General Public License v3 or later
<https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.
