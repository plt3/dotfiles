[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" -g "!venv" -g "!node_modules" -g "!__pycache__" -g "!.DS_Store"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# make sure jdtls installed with https://github.com/eruizc-dev/jdtls-launcher is in PATH
export PATH=$PATH:$HOME/.local/bin
