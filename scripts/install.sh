OS=$(uname -s)
MAC='Darwin'
if [[ $OS =~ $MAC ]]; then
  if ! [ -x "$(command -v brew)" ]; then
    echo "Homebrew is not installed! Please install homebrew manually before running this target again."
    exit 1
  fi
  brew tap homebrew/cask-fonts && brew install --cask font-roboto-mono-nerd-font
  brew install --cask iterm2
  xargs brew install <scripts/brew-packages.txt
elif [ -x "$(command -v apt-get)" ]; then
  sudo apt-get update
  xargs sudo apt-get -y install <scripts/packages.txt
elif [ -x "$(command -v dnf)" ] && [ ! -e /run/ostree-booted ]; then
  xargs sudo dnf -y install <scripts/dnf-packages.txt
elif [ -x "$(command -v brew)" ]; then
  # Other distros (e.g. immutable Fedora/Bazzite hosts) use Homebrew, zsh is not preinstalled there
  xargs brew install zsh <scripts/brew-packages.txt
else
  echo "No supported package manager found (apt-get, dnf or brew)!"
  exit 1
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl -s "https://get.sdkman.io" | bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  OMZ_TMP=$(mktemp -d)
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_TMP" && rsync -a "$OMZ_TMP/" ~/.oh-my-zsh/
  rm -rf "$OMZ_TMP"
fi
P10K_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
[ -d "$P10K_DIR" ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

# Make zsh the login shell
ZSH_PATH=$(command -v zsh)
if [ -z "$ZSH_PATH" ]; then
  echo "zsh was not installed, cannot set it as the default shell!"
elif [ "$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)" != "$ZSH_PATH" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
  grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  if [ -x "$(command -v chsh)" ]; then
    chsh -s "$ZSH_PATH"
  else
    sudo usermod -s "$ZSH_PATH" "$USER"
  fi
  echo "Default shell set to $ZSH_PATH, log out and back in for it to take effect."
fi

./scripts/update.sh

TMUX_VERSION=$(tmux -V)
NON_XDG_TMUX_VERSION='tmux ([0-2]\.[0-9]+[A-Za-z]?|3\.[0-2][A-Za-z]?)'
if [[ $TMUX_VERSION =~ $NON_XDG_TMUX_VERSION ]]; then
  ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
  echo "Detected non-XDG installation of tmux, creating symlink in home directory!"
fi

echo "Installation completed."
if [[ $OS =~ $MAC ]]; then
  echo "Remember to import the iTerm2 profile!"
fi
