.ONESHELL:
.SILENT:
SHELL := /bin/bash

all:
	echo "Select a target: install, update, sync"

install: 
	xargs sudo apt-get -y install <packages.txt

	rsync -ar --exclude='Makefile' --exclude='.git/' --exclude='packages.txt' ./ ~/
		
	TMUX_VERSION=$$(tmux -V)
	NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
	if [[ $$TMUX_VERSION =~ $$NON_XDG_TMUX_VERSION ]]; then
		ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf 
		echo "Detected non-XDG installation of tmux, creating symlink in home directory!" 
	fi

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) <<< 'Y' && exit"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-$$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	echo "Installation completed."

update: 
	rsync -aru --exclude='Makefile' --exclude='packages.txt' --exclude='.git/' ./ ~/
	echo "Update completed."

sync: update
	rsync -ar ~/.config/nvim/ ./.config/nvim/
	rsync -ar ~/.config/tmux/ ./.config/tmux/
	rsync -ar ~/.config/git/ ./.config/git/
	cp -a ~/.bashrc ~/.zshrc ~/.p10k.zsh ./
	echo "Sync completed."
	git status

.PHONY: all install update sync
