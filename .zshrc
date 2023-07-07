

export GIT_CONFIG_GLOBAL=~/.config/git/config


export PATH=$(echo "$PATH:$HOME/.local/bin:/usr/local/go/bin")

. "$HOME/.cargo/env"


alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias lah='ls -lah'
alias pbc='xsel --clipboard --input'
alias pbp='xsel --clipboard --output'



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
