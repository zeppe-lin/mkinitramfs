OVERVIEW
========

`mkinitramfs` generates bootable initramfs images for Linux systems.

It is a fork of illiliti's `tinyramfs` at commit `8abfcc9`
(Fri May 21 2021), with the following changes:
  * Bash completion support
  * GNU-style options and usage output
  * Command-line parsing via GNU `getopt(1)`
  * Use of `local` to prevent namespace pollution
  * Support for `rootdelay` kernel parameter
  * Experimental `smdev` hook
  * `luks` hook: prompts for password if header/keyfile is missing
  * `extrafiles` directive: copy arbitrary files into image
  * `resume` hook: supports hibernation resume from swap partitions or
    files
  * Split `keymap` hook into `loadkmap` and `loadkeys` (supports
    BusyBox and kmod)

See the git log for full history.

The original sources can be downloaded from:
  1. https://github.com/illiliti/tinyramfs
  2. https://github.com/illiliti/tinyramfs/archive/8abfcc9/tinyramfs-8abfcc9.zip

---

FEATURES
========

The following advantages can be distinguished:
  * No bashisms, only POSIX `sh(1p)` (with `local` exception)
  * Portable, no distribution-specific
  * Simple configuration
  * Build-time and init-time hooks
  * LUKS (detached header, key, password), LVM
  * smdev, mdev, mdevd, eudev, systemd-udevd

---

REQUIREMENTS
============

Kernel Configuration
--------------------

The kernel must be built with:

```
General setup
  [*] Initial RAM filesystem and RAM disk (initramfs/initrd) support
      CONFIG_BLK_DEV_INITRD=y

Device Drivers
  Generic Driver Options
    [*] Maintain a devtmpfs filesystem to mount at /dev
        CONFIG_DEVTMPFS=y
```

For encrypted root support, enable:

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

Build-time
----------
  * POSIX `sh(1p)`, `make(1p)`, and "mandatory utilities"
  * `scdoc(1)` to generate manual pages

Runtime
-------
  * Any POSIX-compatible shell with `local` support
  (e.g., `dash(1)`, Busybox `ash(1)`)
  * GNU `getopt(1)`, `switch_root(8)`, `mount(8)`, `cpio(1)`

**Optional runtime dependencies:**
  * `ldd(1)` for copying binary dependencies
  * `strip(1p)` for reducing image size by stripping binaries
  * `blkid(8)` for UUID, LABEL, PARTUUID support
  * `smdev` OR `mdev` OR `mdevd` OR `eudev` OR `systemd-udevd` or
    `CONFIG_UEVENT_HELPER`
  * `lvm(8)` for LVM support
  * `cryptsetup(8)` for LUKS support
  * Busybox `loadkmap` or kbd `loadkeys(8)` for keymap support
  * `kmod(8)` OR Busybox modutils+[patch][1] for non-monolithic
    kernels

[1]: /patches/modprobe-kernel-version.patch

---

INSTALLATION
============

To install:

```sh
# as root
make install
```

Configuration parameters are defined in `config.mk`.

---

DOCUMENTATION
=============

Basic usage
-----------

Configure `/etc/mkinitramfs/config` conform your needs (see
`mkinitramfs.config(5)`).

Generate the initramfs:

```sh
# as root
mkinitramfs -o "/boot/initramfs-$(uname -r).img"
```

Update your bootloader configuration (example for GRUB2):

```sh
# as root
grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot.

Online documentation
--------------------

Provided in `/man` and installed under the system manual hierarchy.

---

CREDITS
=======

Original developers:
  * illiliti    <https://github.com/illiliti>
  * E5ten       <https://github.com/E5ten>
  * dylanaraps  <https://github.com/dylanaraps>

Support the original author:
  * illiliti / (BTC) 1BwrcsgtWZeLVvNeEQSg4A28a3yrGN3FpK
  * https://patreon.com/illiliti

---

LICENSE
=======

`mkinitramfs` is licensed under the
[GNU General Public License v3 or later](https://gnu.org/licenses/gpl.html).

See `COPYING` for license terms and `COPYRIGHT` for notices.
