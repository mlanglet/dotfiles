# Mathias Langlet's dotfiles repo

I collect my dotfiles here for easy setup of a new computer.

There are 3 make targets that can be used to manage the contents of the home directory.

`install` - installs all the packages and copies the files to the home directory

`update` - pulls latest and updates the files in the home directory, does not overwrite newer files

`sync` - runs the update and then syncs back any newer files and displays the changes 

## Supported platforms

- macOS - Homebrew (must be installed beforehand)
- Debian/Ubuntu - apt
- Fedora - dnf
- Immutable Fedora hosts (Silverblue, Bazzite) - Homebrew

`git` and `make` are needed to bootstrap, e.g. `sudo dnf install git make` on Fedora.