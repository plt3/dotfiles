export BASH_SILENCE_DEPRECATION_WARNING=1

# set some homebrew environment variables
eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim -u ~/scripts/manInit.vim"

# I guess I want this? cscp breaks without it due to glob excluding files
shopt -s extglob

# view man pages in nvim with light config file
export MANPAGER="/bin/sh -c \"col -b | nvim -u ~/scripts/manInit.vim -c 'set ft=man ts=8 nomod nolist noma' -\""

# customize prompt
PS1="\[$(tput bold)\]\[\033[38;5;196m\]\u\[$(tput sgr0)\] \[$(tput bold)\]@\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;82m\]\h\[$(tput sgr0)\] \w\[$(tput sgr0)\] > "
PROMPT_DIRTRIM=2

# aliases
alias gs="git status"
alias go="git log --all --decorate --oneline --graph"
alias gb="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias ve="python3 -m venv venv; source venv/bin/activate; pip3 install --upgrade pip; pip3 install ptpython"
alias ac="source venv/bin/activate"
alias de="deactivate"
alias gpp="~/scripts/compileCpp.sh"
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d ' ' -f 2 | tr -d '\n' | pbcopy && pbpaste && echo"
alias tt="python3 ~/scripts/typingTest/typingTest.py"
alias n="nvim"
alias cat="bat -H 0:"
alias ls="exa"
alias ll="exa -lahg --color-scale"
alias lt='exa -aT -I "venv|*.pyc|__pycache__|.git|.DS_Store|node_modules"'
alias notify="osascript -e 'display notification \"The command finished!\"'; afplay /System/Library/Sounds/Blow.aiff -v 5"
alias dockertog="if docker ps &> /dev/null; then echo \"quitting Docker...\"; osascript -e 'quit app \"Docker\"'; else echo \"starting Docker...\"; open -a Docker; fi"
alias drmf='docker rm -f $(docker ps -q | head -n 1)'
alias drml='docker rm -f $(docker ps -q | tail -n 1)'
alias drm='docker rm -f $(docker ps -q)'
alias drma='docker rm -f $(docker ps -qa)'
alias drmi="docker images | grep '\<none\>' | awk '{ print \$3; }' | xargs docker rmi"
alias dps="docker ps"
alias note="~/scripts/openNotes.sh"
alias iv="cd ~/.config/nvim; nvim init.vim; cd -"
alias pf="~/scripts/pipFreezePrune/outputDeps.sh"
alias memleak="top -pid $(pgrep a.out)"

# delete after this semester?
alias cssh="ssh plt15@class-1.cs.georgetown.edu"
alias runquiz="pbpaste > tmpfile.cpp && g++ -std=c++11 -o paste.out tmpfile.cpp; ./paste.out; rm tmpfile.cpp paste.out"
alias agrader="~/scripts/readAutograderResults.sh"
# this gives cscp command
source ~/scripts/copyFilesToCsclass.sh

source ~/.bashrc

# create directory and cd into it
mk () {
    mkdir "$1"
    cd "$1"
}

export PTPYTHON_CONFIG_HOME="/Users/pault/.config/ptpython"
export PYTHONSTARTUP="/Users/pault/.pythonrc.py"

# make bash completion work
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
