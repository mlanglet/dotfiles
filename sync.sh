rsync -ar ~/.config/nvim/ ./.config/nvim/
rsync -ar ~/.config/tmux/ ./.config/tmux/
rsync -ar ~/.config/git/ ./.config/git/
cp -a ~/.bashrc ~/.zshrc ~/.p10k.zsh ./
echo "Sync completed."
git status