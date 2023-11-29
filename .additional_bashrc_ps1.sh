COLOR_RESET=$(echo -en '\001\033[0m\002')
COLOR_RED=$(echo -en '\001\033[00;31m\002')
COLOR_GREEN=$(echo -en '\001\033[00;32m\002')
COLOR_YELLOW=$(echo -en '\001\033[00;33m\002')
COLOR_BLUE=$(echo -en '\001\033[00;34m\002')
COLOR_MAGENTA=$(echo -en '\001\033[00;35m\002')
COLOR_PURPLE=$(echo -en '\001\033[00;35m\002')
COLOR_CYAN=$(echo -en '\001\033[00;36m\002')
COLOR_LIGHTGRAY=$(echo -en '\001\033[00;37m\002')
COLOR_LRED=$(echo -en '\001\033[01;31m\002')
COLOR_LGREEN=$(echo -en '\001\033[01;32m\002')
COLOR_LYELLOW=$(echo -en '\001\033[01;33m\002')
COLOR_LBLUE=$(echo -en '\001\033[01;34m\002')
COLOR_LMAGENTA=$(echo -en '\001\033[01;35m\002')
COLOR_LPURPLE=$(echo -en '\001\033[01;35m\002')
COLOR_LCYAN=$(echo -en '\001\033[01;36m\002')
COLOR_WHITE=$(echo -en '\001\033[01;37m\002')


# Set Terminal title - current folder
function userTerminalTitlePwd {
    echo -e '\033]2;' # open terminal title
    # content of the terminal window:
    echo -e '${HOST_DISPLAY_NAME}: \w'
    echo -e '\007' # close terminal title
}

# Render exit code
function exitCodeWarning {
    code=$?
    if [[ $code != 0 ]]; then
        echo -e "${COLOR_RED}✗✗✗ exit code was ${code} ✗✗✗\n\n${COLOR_RESET}"
    fi
}

# Render Git branch for PS1
function renderGitBranch {
    if [ -f $(which git) ]; then
        echo "${COLOR_YELLOW}$(__git_ps1)"
    fi
}

function customPrompt {
  # this function is only there that it can be overwritten in with your own custom prompt
  true
}

# Style bash prompt
PS1=''
PS1+='\033]2;${HOST_DISPLAY_NAME}: \w\007' # terminal Title
PS1+='$(exitCodeWarning)' # git information
#PS1+='$(if [[ $? != 0 ]]; then echo "\n"; fi)'
PS1+='${COLOR_CYAN}['

PS1+='${COLOR_LRED}\u' # user
PS1+='${COLOR_CYAN}@'
PS1+='${COLOR_LBLUE}${HOST_DISPLAY_NAME}' # container name
PS1+='${COLOR_CYAN}: '
PS1+='${COLOR_RESET}\w' # working directory

PS1+='${COLOR_CYAN}]'

PS1+='$(renderGitBranch)' # git information
PS1+='$(customPrompt)' # git information

PS1+='${COLOR_CYAN}> '
PS1+='${COLOR_RESET} ';
PS1+='\n'
PS1+='\$ '
