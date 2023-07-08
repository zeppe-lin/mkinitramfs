# utils.mk

urlcodes:
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" *.*      \
		| xargs -P10 -I{} curl -o /dev/null \
		 -sw "[%{http_code}] %{url}\n" '{}' \
		| sort -u

podchecker:
	@echo "=======> Check PODs for syntax errors"
	@podchecker *.pod

shellcheck:
	@echo "=======> Check shell scripts for syntax errors"
	@grep -m1 -l '^#\s*!/bin/sh' -R .                 \
		 --exclude-dir=.git --exclude-dir=.github \
		| xargs -L10 shellcheck -s sh

.PHONY: urlcodes podchecker shellcheck
