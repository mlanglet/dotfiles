git pull
rsync -aru --exclude='README.md'  --exclude='.gitignore' --exclude='Makefile' --exclude='scripts/' --exclude='.git/' ./ ~/
echo "Update completed."