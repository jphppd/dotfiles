.DEFAULT_GOAL := help

ALACRITTY_DEPS = .config/alacritty/alacritty.yml
BASH_DEPS = .bash_login .bash_logout .bashrc $(wildcard .local/lib/shell/*) $(wildcard .local/share/bash-completion/*)
BIN_DEPS = $(wildcard .local/bin/*)
DEV_DEPS = .gdbinit $(wildcard .config/git/*)
SSH_DEPS = .ssh
SWAY_DEPS = .config/sway/config $(wildcard .config/i3status-rust/*)
TERM_DEPS = .inputrc .tmux.conf .vimrc $(wildcard .terminfo/*)
URXVT_DEPS = .Xresources

skel.tar.gz: $(BASH_DEPS) $(BIN_DEPS) $(DEV_DEPS) $(SSH_DEPS) $(TERM_DEPS)
	tar --create --gzip --file $@ $^

desktop_skel.tar.gz:  $(ALACRITTY_DEPS) $(SWAY_DEPS) $(URXVT_DEPS)
	tar --create --gzip --file $@ $^

.PHONY: build
build: skel.tar.gz desktop_skel.tar.gz ## Create all archives

.PHONY: install
install: build ## Extract archive to HOME
	mkdir --parents "${HOME}"
	tar --extract --gunzip --directory="${HOME}" --file skel.tar.gz

.PHONY: desktop-install
desktop-install: build ## Extract desktop archive to HOME
	mkdir --parents "${HOME}"
	tar --extract --gunzip --directory="${HOME}" --file desktop_skel.tar.gz

.PHONY: clean
clean: ## Clean the repository
	rm --force skel.tar.gz desktop_skel.tar.gz

.PHONY: help
help: ## Print the help and exit.
	@grep -E '^[\.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[96mmake %-20s\033[0m %s\n", $$1, $$2}'
