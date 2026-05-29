#!/usr/bin/env bash
# bashtidy.sh
# https://github.com/bashtidy/bashtidy
# Ref: https://github.com/tourcoder/larn.zsh-theme

# ---------------------------------------------------------------
# Colors — use \001\002 inside functions (equivalent to \[\] in PS1)
# ---------------------------------------------------------------
_BLUE='\[\033[38;5;75m\]'
_ORANGE='\[\033[38;5;214m\]'
_YELLOW='\[\033[38;5;226m\]'
_WHITE='\[\033[38;5;255m\]'
_GREEN='\[\033[38;5;40m\]'
_RESET='\[\033[0m\]'

# Same colors wrapped for use inside functions
_F_BLUE='\001\033[38;5;75m\002'
_F_ORANGE='\001\033[38;5;214m\002'
_F_YELLOW='\001\033[38;5;226m\002'
_F_GREEN='\001\033[38;5;40m\002'
_F_RESET='\001\033[0m\002'

# ---------------------------------------------------------------
# Git helpers
# ---------------------------------------------------------------
_parse_git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null
}

_parse_git_status() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local changes
    changes=$(git status --porcelain 2>/dev/null)
    local state=""
    [[ "$changes" == *M* || "$changes" == *A* || "$changes" == *D* ]] && state+="*"
    [[ "$changes" == *\?* ]] && state+="+"
    [[ "$changes" == *U* ]] && state+="!"
    echo "$state"
}

_get_branch_color() {
    local branch
    branch=$(_parse_git_branch)
    case "$branch" in
        main|master) echo "$_F_GREEN"  ;;
        dev)         echo "$_F_YELLOW" ;;
        feature-*)   echo "$_F_BLUE"   ;;
        *)           echo "$_F_ORANGE" ;;
    esac
}

_is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

# ---------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------
_set_prompt() {
    if _is_git_repo; then
        local branch color status
        branch=$(_parse_git_branch)
        color=$(_get_branch_color)
        status=$(_parse_git_status)
        PS1="${_BLUE}[\w${_WHITE} :: ${_RESET}${color}${branch}${_F_YELLOW}${status}${_BLUE}] ${_BLUE}➜ ${_RESET}"
    else
        PS1="${_BLUE}[\w] ${_BLUE}➜ ${_RESET}"
    fi
}

PROMPT_COMMAND="_set_prompt"

# ---------------------------------------------------------------
# ls
# ---------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    export LSCOLORS="ExFxCxDxBxegedabagacad"
    alias ls='ls -G'
else
    export LS_COLORS='di=1;34:ln=36:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:fi=0'
    alias ls='ls --color=auto'
fi
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'

# ---------------------------------------------------------------
# grep / diff
# ---------------------------------------------------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

# ---------------------------------------------------------------
# Navigation
# ---------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# ---------------------------------------------------------------
# Git aliases
# ---------------------------------------------------------------

# Basics
alias g='git'
alias gi='git init'
alias gcl='git clone'

# Status / log
alias gst='git status'
alias gss='git status -s'
alias gl='git log --oneline --graph --decorate --all'
alias glo='git log --oneline -20'
alias gd='git diff'
alias gds='git diff --staged'

# Branches
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'

# Stage / commit
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcane='git commit --amend --no-edit'

# Stash
alias gsh='git stash'
alias gshl='git stash list'
alias gshp='git stash pop'
alias gshd='git stash drop'

# Remote
alias gf='git fetch'
alias gfa='git fetch --all'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsu='git push -u origin HEAD'
alias gpsf='git push --force-with-lease'

# Merge / rebase
alias gm='git merge'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'

# Undo
alias grh='git reset HEAD'
alias grhh='git reset --hard HEAD'
alias gclean='git clean -fd'

# Tags
alias gt='git tag'
alias gtl='git tag -l'

# Shortcuts
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git reset HEAD~1'

# ---------------------------------------------------------------
# History
# ---------------------------------------------------------------
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s checkwinsize

# history prefix search: type partial command, use up/down to filter
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null

# ---------------------------------------------------------------
# bashtidy command
# ---------------------------------------------------------------
bashtidy() {
    echo ""
    echo "bashtidy — A lightweight shell configuration framework for bash"
    echo "https://github.com/bashtidy/bashtidy"
    echo ""
    echo "Aliases:"
    echo ""
    grep "^alias" /etc/bashtidy.sh 2>/dev/null \
      | sed "s/^alias //" \
      | sed "s/['\"]$//" \
      | awk -F"=['\"]" '{printf "  %-12s →  %s\n", $1, $2}'
    echo ""
}
