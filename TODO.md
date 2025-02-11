TODO mkinitramfs
================


No milestone
------------
  - [ ] add an option and config setting to not include kernel modules.
        kmod_blacklist="a b c" ? omit_drivers="..." ?

  - [ ] completion/bash_completion:
        fix shellcheck warnings, and add checking to CI.

  - [ ] resume hook: add resume from swap file?
        https://github.com/zeppe-lin/mkinitramfs/issues/5

  - [ ] add font hook?
        https://github.com/zeppe-lin/mkinitramfs/issues/2

  - [ ] add support of loadkeys(1) from kbd package to keymap hook:
        https://github.com/zeppe-lin/mkinitramfs/issues/1
