deadlinks:
	@echo "=======> deadlinks"
	@grep -EIihor "https?://[^\"\\'> ]+" --exclude-dir=.git*      \
		| xargs -P10 -r -I{}                                  \
		  curl -o/dev/null -sw "[%{http_code}] %{url}\n" '{}' \
		| grep -v '^\[200\]'                                  \
		| sort -u

podchecker:
	@echo "=======> podchecker"
	@podchecker *.pod

shellcheck:
	@echo "=======> shellcheck"
	@grep -m1 -Irl '^#\s*!/bin/sh' --exclude-dir=.git* \
		| xargs -L10 -r shellcheck -s sh

longlines:
	@echo "=======> longlines"
	@grep -PIrn '^.{81,}$$' --exclude-dir=.git* || :

.PHONY: deadlinks podchecker shellcheck longlines
