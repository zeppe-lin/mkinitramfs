TODO mkinitramfs
================


Next release
------------

  - [ ] Blacklisting modules in the initramfs:
        add an option and config setting to exclude kernel modules copying
        for hostonly or copyallmodules modes.
        kmod_blacklist="a b c" ? omit_drivers="..." ?


No milestone
------------

  - [ ] completion/bash_completion:
        fix shellcheck warnings, and add checking to CI.

  - [ ] resume hook: add resume from swap file?
        pass resume_offset? document grub2 config?
        https://github.com/zeppe-lin/mkinitramfs/issues/5

  - [ ] add font hook?
        https://github.com/zeppe-lin/mkinitramfs/issues/2

Done
----

  - [x] add support of loadkeys(1) from kbd package to keymap hook:
        https://github.com/zeppe-lin/mkinitramfs/issues/1
