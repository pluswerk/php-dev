#!/usr/bin/env bash

# Set Terminal title - current folder
function userTerminalTitlePwd {
    echo -e '\033]2;'$(pwd)'\007'
}

# Set current user color
function userColorUser {
    if [[ $EUID -eq 0 ]]; then
        echo -e '\e[1;31m';
    else
        echo -e '\e[1;32m';
    fi
}

# Render Git branch for PS1
function renderGitBranch {
    if [ -f $(which git) ]; then
        echo -e "\e[0;33m$(__git_ps1)"
    fi
}

# Style bash prompt
function stylePS1 {
    VAR_HOSTNAME=`hostname`
    if [ ! -z "$1" ]; then
        VAR_HOSTNAME="${1}"
    fi;

    PS1='$(userTerminalTitlePwd)\[\e[0;36m\][$(userColorUser)\u\[\e[0;36m\]@\[\e[1;34m\]${VAR_HOSTNAME}\[\e[0;36m\]: \[\e[0m\]\w\[\e[0;36m\]]$(renderGitBranch)\[\e[0;36m\]> $(userColorUser)\n\$\[\e[0m\] ';
}
