HACKING
=======

This file attempts to describe the rules and notes to use when hacking
the `mkinitramfs` sources cloned from the Zeppe-Lin's source code repository.


Coding style
------------

* Indent with tabs, align with spaces.

* Maintain a 71-column limit for code where possible, and enforce a
  strict 79-column limit for formatted output messages, such as usage,
  help, etc.


Documentation
-------------

* Check manual pages for misspells:

    hunspell -l man/*.scdoc
