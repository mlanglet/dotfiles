# Mathias Langlet's dotfiles repo

I collect my dotfiles here for easy setup of a new computer.

## Install

On a new computer, run:

```sh
curl -fsSL https://raw.githubusercontent.com/mlanglet/dotfiles/master/scripts/install.sh | bash
```

This installs `git` if it is missing, clones the repo to `~/code/dotfiles` (set `DOTFILES_DIR` to use another location) and runs the install from there. From an existing clone, run `./scripts/install.sh` or `make install` instead.

## Make targets

There are 3 make targets that can be used to manage the contents of the home directory.

`install` - installs all the packages (including `git` and `make`) and copies the files to the home directory

`update` - pulls latest and updates the files in the home directory, does not overwrite newer files

`sync` - runs the update and then syncs back any newer files and displays the changes 

## Supported platforms

- macOS - Homebrew (must be installed beforehand)
- Debian/Ubuntu - apt
- Fedora - dnf
- Immutable Fedora hosts (Silverblue, Bazzite) - Homebrew
