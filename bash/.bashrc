eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

. "$HOME/.cargo/env"

# make sure jdtls installed with https://github.com/eruizc-dev/jdtls-launcher is in PATH
# ~/.local/bin is also where all my scripts reside
export PATH=$PATH:$HOME/.local/bin
