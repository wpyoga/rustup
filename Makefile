SPLIT_SCRIPTS = \
	rustup-init-split.sh \
	sections/*.sh \
	functions/*.sh \
	steps/*.sh \

all: rustup-init-merged.sh

rustup-init-merged.sh: $(SPLIT_SCRIPTS)
	merge-shell.sh rustup-init-split.sh > rustup-init-merged.sh

test: rustup-init-merged.sh
	@diff -u rustup-init.sh rustup-init-merged.sh
	@echo "Test passed"

clean:
	rm -f rustup-init-merged.sh
