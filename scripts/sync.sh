OS=$(uname -s)
MAC='Darwin'
if [[ $OS =~ $MAC ]]; then
  rsync -ar ~/.config/iterm2/ ./.config/iterm2/
fi

rsync -ar ~/.config/nvim/ ./.config/nvim/
rsync -ar ~/.config/tmux/ ./.config/tmux/
rsync -ar ~/.config/git/ ./.config/git/
[ -d ~/.config/ghostty ] && rsync -ar ~/.config/ghostty/ ./.config/ghostty/

cp -a ~/.bashrc ~/.zshrc ~/.p10k.zsh ./
mkdir -p ./.claude && cp -a ~/.claude/settings.json ~/.claude/statusline-command.sh ./.claude/
echo "Sync completed."
git status