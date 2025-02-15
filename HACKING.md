HACKING
=======

This file attempts to describe the rules and notes to use when hacking
the mkinitramfs sources cloned from the Zeppe-Lin's source code
repository.


Coding style
------------

* Indent with tabs, align with spaces.


Documentation
-------------

* Generate online references to the manual pages in README.md from Vim:

```
:r!ls *.[0-9] | sed 's/^man\/\(.*\)/- \[\1\]\(https:\/\/zeppe-lin.github.io\/\1.html\)/g' 
```
