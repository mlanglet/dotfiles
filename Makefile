.ONESHELL:
.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install: 
	rsync -vr --exclude='Makefile' --exclude='.git/' ./ ~/
		
	TMUX_VERSION=$$(tmux -V)
	NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
	if [[ $$TMUX_VERSION =~ $$NON_XDG_TMUX_VERSION ]]; then
		ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf 
		echo "Detected non-XDG installation of tmux, creating symlink in home directory!" 
	fi

update: 
	rsync -vru --exclude='Makefile' --exclude='.git/' ./ ~/

sync: update
	rsync -vr ~/.config/nvim/ ./.config/nvim/
	rsync -vr ~/.config/tmux/ ./.config/tmux/


.PHONY: all install update sync
