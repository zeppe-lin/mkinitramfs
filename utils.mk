GREP_DEFS = --exclude-dir=.git --exclude-dir=.github -R .
FIND_DEFS = -not \( -path "./.git*" -or -path ".*~" \)
MAXLINE   = 80

urlcodes:
	@echo "=======> Check URLs for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" ${GREP_DEFS}    \
		| xargs -P10 -I{} curl -o /dev/null        \
		 -sw "[%{http_code}] %{url}\n" '{}'        \
		| sort -u

podchecker:
	@echo "=======> Check PODs for syntax errors"
	@podchecker *.pod

shellcheck:
	@echo "=======> Check shell scripts for syntax errors"
	@grep -m1 -l '^#\s*!/bin/sh' ${GREP_DEFS} | xargs -L10 shellcheck -s sh

longlines:
	@echo "=======> Check for long lines (> ${MAXLINE})"
	@find . -type f ${FIND_DEFS} -exec awk -v ML=${MAXLINE} \
		'length > ML { print FILENAME ":" FNR " " $$0 }'  {} \;

.PHONY: urlcodes podchecker shellcheck longlines