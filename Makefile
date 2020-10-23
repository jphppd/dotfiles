.DEFAULT_GOAL := help
VPATH = skel

BASH_DEPS = .bash_login .bash_logout .bashrc $(wildcard .local/lib/shell/*)
BIN_DEPS = $(wildcard .local/bin/*)
DESKTOP_DEPS = .xinitrc .config/sway/config .i3status.conf
DEV_DEPS = .gitconfig .gdbinit $(wildcard .local/lib/git/*) $(wildcard .local/lib/git/templatehooks/*)
SSH_DEPS = .ssh
TERM_DEPS = .inputrc .tmux.conf .vimrc
X_TERM_DEPS = .config/alacritty/alacritty.yml .Xresources

skel.tar.gz: $(BASH_DEPS) $(BIN_DEPS) $(DEV_DEPS) $(SSH_DEPS) $(TERM_DEPS)
	tar --create --gzip --file $@ $^

x_skel.tar.gz: $(DESKTOP_DEPS) $(X_TERM_DEPS)
	tar --create --gzip --file $@ $^

.PHONY: build
build: skel.tar.gz x_skel.tar.gz ## Create all archives

.PHONY: install
install: build ## Extract archive to HOME
	mkdir --parents "${HOME}"
	tar --extract --gunzip --directory="${HOME}" --file skel.tar.gz

.PHONY: x-install
x-install: build ## Extract x archives to HOME
	mkdir --parents "${HOME}"
	tar --extract --gunzip --directory="${HOME}" --file x_skel.tar.gz

.PHONY: mrproper
mrproper: ## Clean the repository
	rm --force skel.tar.gz x_skel.tar.gz

.PHONY: help
help: ## Print the help and exit.
	@grep -E '^[\.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[96mmake %-20s\033[0m %s\n", $$1, $$2}'
