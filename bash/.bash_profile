# setup ble.sh
[[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh" --noattach

export BASH_SILENCE_DEPRECATION_WARNING=1

# set some homebrew environment variables
eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim"
# view man pages in nvim
export MANPAGER="nvim +Man!"

export FZF_TMUX_OPTS='-p'

# I guess I want this? cscp breaks without it due to glob excluding files
shopt -s extglob

# customize prompt
PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u\[$(tput sgr0)\] \[$(tput bold)\]@\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;82m\]\h\[$(tput sgr0)\] \w\[$(tput sgr0)\] > "
PROMPT_DIRTRIM=2

# aliases
alias gs="git status"
alias gl="git log --all --decorate --oneline --graph"
alias gb="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias ve="python3 -m venv venv; source venv/bin/activate; pip3 install --upgrade pip"
alias ac="source venv/bin/activate"
alias de="deactivate"
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d ' ' -f 2 | tr -d '\n' | pbcopy && pbpaste && echo"
alias tt="python3 ~/scripts/typingTest/typingTest.py"
alias ta="tmux attach"
alias n="nvim"
alias cat="bat -H 0:"
alias ls="lsd"
alias ll="lsd --long --almost-all --header"
alias lt='lsd --tree --all -I ".git" -I ".DS_Store" -I "venv" -I "*.pyc" -I "__pycache__" -I "node_modules"'
alias notify="osascript -e 'display notification \"The command finished!\"'; afplay /System/Library/Sounds/Blow.aiff -v 5"
alias dockertog="if docker ps &> /dev/null; then echo \"quitting Docker...\"; osascript -e 'quit app \"Docker\"'; else echo \"starting Docker...\"; open -a Docker; fi"
alias drmf='docker rm -f $(docker ps -q | head -n 1)'
alias drml='docker rm -f $(docker ps -q | tail -n 1)'
alias drm='docker rm -f $(docker ps -q)'
alias drma='docker rm -f $(docker ps -qa)'
alias drmi="docker images | grep '\<none\>' | awk '{ print \$3; }' | xargs docker rmi"
alias dps="docker ps"
alias iv="nvim ~/dotfiles/nvim/.config/nvim/init.lua"
alias pf="~/scripts/pipFreezePrune/outputDeps.sh"
alias memleak="top -pid $(pgrep a.out)"
alias ytvid="yt-dlp -f mp4 -o \"%(title)s.%(ext)s\""
# restart icloud drive upload when it hangs
alias drive="killall bird"

source ~/.bashrc

# create directory and cd into it
mk() {
	mkdir "$1"
	cd "$1"
}

# print number of files in given directory
countfiles() {
	\ls -1q "$1" | wc -l
}

export PTPYTHON_CONFIG_HOME="$HOME/.config/ptpython"
export PYTHONSTARTUP="$HOME/.config/ptpython/config.py"

# make bash completion work
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
# not sure why this doesn't already get sourced by the line above but make ssh completion work
. /opt/homebrew/Cellar/bash-completion@2/2.13.0/share/bash-completion/completions/ssh

# initialize zoxide
eval "$(zoxide init bash)"

# setup ble.sh
[[ ${BLE_VERSION-} ]] && ble-attach
