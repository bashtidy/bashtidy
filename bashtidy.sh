#!/usr/bin/env bash
# bashtidy.sh
# https://github.com/bashtidy/bashtidy

# ---------------------------------------------------------------
# Colors
# ---------------------------------------------------------------
_C_CYAN="\[\033[0;36m\]"
_C_RESET="\[\033[0m\]"

# ---------------------------------------------------------------
# Prompt: working directory + git branch + status
# ---------------------------------------------------------------
_git_prompt() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return

    local state=""

    # Untracked files
    git ls-files --others --exclude-standard --quiet --error-unmatch . 2>/dev/null \
        && state="${state}?"

    # Unstaged changes
    git diff --quiet 2>/dev/null || state="${state}!"

    # Staged but uncommitted
    git diff --cached --quiet 2>/dev/null || state="${state}+"

    # Commits ahead of upstream
    local ahead
    ahead=$(git rev-list @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    [ "$ahead" -gt 0 ] 2>/dev/null && state="${state}↑${ahead}"

    # Color: green = clean, yellow = dirty, red = conflict
    local color
    if [ -z "$state" ]; then
        color="\[\033[0;32m\]"
    else
        color="\[\033[0;33m\]"
    fi

    git diff --name-only --diff-filter=U 2>/dev/null | grep -q . \
        && color="\[\033[0;31m\]"

    [ -n "$state" ] && state=" ${state}"
    echo -e " ${color}(${branch}${state})\[\033[0m\]"
}

PS1="${_C_CYAN}\w${_C_RESET}\$(_git_prompt) → "

# ---------------------------------------------------------------
# ls
# ---------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lAh --color=auto'
alias l='ls -CF --color=auto'

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