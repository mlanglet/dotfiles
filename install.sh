OS=$(uname -s)
MAC='Darwin'
if [[ $OS =~ $MAC ]]; then
  if ! [ -x "$(command -v brew)" ]; then
    echo "Homebrew is not installed! Please install homebrew manually before running this target again."
    exit 1
  fi
  brew tap homebrew/cask-fonts && brew install --cask font-roboto-mono-nerd-font
  xargs brew install <brew-packages.txt
else
  sudo apt-get update
  xargs sudo apt-get -y install <packages.txt
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl -s "https://get.sdkman.io" | bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

rsync -ar --exclude='Makefile' --exclude='.git/' --exclude='packages.txt' ./ ~/

TMUX_VERSION=$(tmux -V)
NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
if [[ $TMUX_VERSION =~ $NON_XDG_TMUX_VERSION ]]; then
  ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
  echo "Detected non-XDG installation of tmux, creating symlink in home directory!"
fi

echo "Installation completed."