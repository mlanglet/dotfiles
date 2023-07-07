.ONESHELL:
.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install: 
	rsync -ar --exclude='Makefile' --exclude='.git/' ./ ~/
		
	TMUX_VERSION=$$(tmux -V)
	NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
	if [[ $$TMUX_VERSION =~ $$NON_XDG_TMUX_VERSION ]]; then
		ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf 
		echo "Detected non-XDG installation of tmux, creating symlink in home directory!" 
	fi
	echo "Installation completed."

update: 
	rsync -aru --exclude='Makefile' --exclude='.git/' ./ ~/
	echo "Update completed."

sync: update
	rsync -ar ~/.config/nvim/ ./.config/nvim/
	rsync -ar ~/.config/tmux/ ./.config/tmux/
	rsync -ar ~/.config/git/ ./.config/git/
	cp -a ~/.bashrc ~/.zshrc ./
	echo "Sync completed."
	git status

.PHONY: all install update sync
