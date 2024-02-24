OVERVIEW
--------
This directory contains mkinitramfs, a tool used to create a Linux boot image
(initramfs).

This distribution is a fork of illiliti's tinyramfs as of commit 8abfcc9
(Fri May 21 2021) with the following differences:
- bash completion
- GNU-style options/help/usage
- switch to the GNU getopt(1) for command-line parsing
- "local"s to prevent namespace violations
- support "rootdelay" kernel's command-line parameter
- experimental smdev hook
- luks hook: ask for password if header/keyfile is not specified
- manual pages in mdoc(7) format
- new "extrafiles" directive to copy additional files
- "resume" hook to resume machines from hibernation

See git log for complete/further differences.

The original sources can be downloaded from:
1. https://github.com/illiliti/tinyramfs
2. https://github.com/illiliti/tinyramfs/archive/8abfcc9/tinyramfs-8abfcc9.zip


FEATURES
--------
The following advantages can be distinguished:
- no bashisms, only POSIX shell (with "local"s exception)
- portable, no distro specific
- easy to use configuration
- build time and init time hooks
- LUKS (detached header, key, password), LVM
- smdev, mdev, mdevd, eudev, systemd-udevd


REQUIREMENTS
------------
**Kernel**:

You need a kernel built with the following features (statically or as modules):
```
  General setup
    [*] Initial RAM filesystem and RAM disk (initramfs/initrd) support
        CONFIG_BLK_DEV_INITRD=y

  Device Drivers
    Generic Driver Options
      [*] Maintain a devtmpfs filesystem to mount at /dev
          CONFIG_DEVTMPFS=y
```

To use `mkinitramfs` with encrypted root is needed to include the following
features too:
```
  Device Drivers --->
    Multiple devices driver support (RAID and LVM) --->
      [*] Device mapper support
      [*] Crypt target support

  Cryptographic API --->
    <*> XTS support
    <*> SHA224 and SHA256 digest algorithm
    <*> AES cipher algorithms
    <*> AES cipher algorithms (x86_64)
    <*> User-space interface for hash algorithms
    <*> User-space interface for symmetric key cipher algorithms
```

**Build time**:
- POSIX sh(1p), make(1p) and "mandatory utilities"

**Runtime**:
- POSIX sh(1p) and standard POSIX utilities
- GNU getopt(1), switch_root(8), mount(8), cpio(1)

The following runtime dependencies are optional:

- ldd(1): for copying binary dependencies
- strip(1p): for reducing image size by stripping binaries
- blkid(8): for UUID, LABEL, PARTUUID support
- smdev OR mdev OR mdevd OR eudev OR systemd-udevd or CONFIG_UEVENT_HELPER:
  for modular kernel, /dev/mapper/* and /dev/disk/*
- lvm(8): for LVM support
- cryptsetup(8): for LUKS support
- busybox' loadkmap: for keymap support
- kmod OR busybox' modutils+[patch][1]: for non-monolithic kernel

[1]: /patches/modprobe-kernel-version.patch


INSTALL
-------
The shell command `make install` should install this package.
The shell command `make install_bashcomp` should install bash
completion script.

See `config.mk` file for configuration parameters.


USAGE
-----
To use mkinitramfs, read [mkinitramfs.config(5)][2] and setup
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

[2]: http://zeppel.ink/mkinitramfs.config.5.html


CREDITS
-------
- illiliti    <https://github.com/illiliti>
- E5ten       <https://github.com/E5ten>
- dylanaraps  <https://github.com/dylanaraps>

You can donate if you like this project to the original author:
- illiliti / (BTC) 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK
- https://patreon.com/illiliti


LICENSE
-------
mkinitramfs is licensed through the GNU General Public License v3 or later
<https://gnu.org/licenses/gpl.html>.
Read the COPYING file for copying conditions.
Read the COPYRIGHT file for copyright notices.
