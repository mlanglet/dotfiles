.ONESHELL:
.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install: 
	rsync -ar --exclude='Makefile' --exclude='.git/' --exclude='packages.txt' ./ ~/
		
	TMUX_VERSION=$$(tmux -V)
	NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
	if [[ $$TMUX_VERSION =~ $$NON_XDG_TMUX_VERSION ]]; then
		ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf 
		echo "Detected non-XDG installation of tmux, creating symlink in home directory!" 
	fi

	xargs sudo apt-get -y install <packages.txt

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	echo "Installation completed."

update: 
	rsync -aru --exclude='Makefile' --exclude='packages.txt' --exclude='.git/' ./ ~/
	echo "Update completed."

sync: update
	rsync -ar ~/.config/nvim/ ./.config/nvim/
	rsync -ar ~/.config/tmux/ ./.config/tmux/
	rsync -ar ~/.config/git/ ./.config/git/
	cp -a ~/.bashrc ~/.zshrc ./
	echo "Sync completed."
	git status

.PHONY: all install update sync
