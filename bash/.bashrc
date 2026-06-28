if [[ -s $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
  . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# make sure jdtls installed with https://github.com/eruizc-dev/jdtls-launcher is in PATH
# ~/.local/bin is also where all my scripts reside
export PATH=$PATH:$HOME/.local/bin
