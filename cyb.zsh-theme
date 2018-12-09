# Use extended color palette if available
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="$fg[cyan]"
    orange="$fg[yellow]"
    purple="$fg[magenta]"
    hotpink="$fg[red]"
    limegreen="$fg[green]"
fi

# See http://geoff.greer.fm/lscolors/
#export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
#export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

# Git
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=""
ZSH_THEME_GIT_PROMPT_SHA_AFTER=""

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[magenta]%} ☂"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ☀"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✱"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[yellow]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[green]%} ⚡"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%} ="

ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%} ▴"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} ▾"

# More symbols to choose from:
# ⚒ ⚑ ⚐ ♺ ♻ ✔ ✖ ✚ ✱ ✤ ✦ ❤ ➜ 𝝙

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"

cyb_get_space() {
    local STR=$1$2
    local zero='%([BSUbfksu]|([FB]|){*})'
    local LENGTH=${#${(S%%)STR//$~zero/}}
    local SPACES=""
    (( LENGTH = ${COLUMNS} - $LENGTH - 1))

    for i in {0..$LENGTH}; do
        SPACES="$SPACES "
    done
    echo $SPACES
}

cyb_prompt_color_palette() {
    local palette
    palette=()

    palette+="%{$FG[075]%}●"
    palette+="%{$FG[111]%}●"
    palette+="%{$FG[117]%}●"
    palette+="%{$FG[105]%}●"
    palette+="%{$FG[032]%}●"
    palette+=" "

    palette+="%{$FG[237]%}●"
    palette+="%{$FG[103]%}●"
    palette+="%{$FG[242]%}●"
    palette+=" "

    palette+="%{$FG[133]%}●"
    palette+="%{$FG[124]%}●"
    palette+="%{$FG[208]%}●"
    palette+="%{$FG[214]%}●"
    palette+=" "

    palette+="%{$FG[148]%}●"
    palette+="%{$FG[077]%}●"
    palette+="%{$FG[118]%}●"
    palette+="%{$FG[078]%}●"
    palette+=" "

    if [[ -n "$palette" ]]; then
        palette+="%{$reset_color%}"
    fi;
    echo "$palette";
}

cyb_prompt_status() {
    local symbols
    symbols=()

    # Was there an error
    if [[ $RETVAL -ne 0 ]]; then
        symbols+="%{$fg[red]%}✘"
    fi;

    # Are there background jobs?
    if [[ $(jobs -l | wc -l) -gt 0 ]]; then
        symbols+="%{$fg[cyan]%}⚙"
    fi;

    # Am I root
    if [[ $EUID -eq 0 ]]; then
        symbols+="%{$fg_bold[red]%}➤"
    else
        symbols+="%{$fg_bold[green]%}➤"
    fi;
    if [[ -n "$symbols" ]]; then
        symbols+="%{$reset_color%}"
    fi;
    echo "$symbols";
}

cyb_prompt_git_hash() {
    local text
    text=()
    text+="$(git_prompt_short_sha)"

    if [[ -n "$text" ]]; then
        text+="| "
    fi;
    echo "$text";
}

precmd() {
    if [[ $EUID -eq 0 ]]; then
        _USERNAME="%{$fg_bold[red]%}%n%{$reset_color%}"
    else
        _USERNAME="%{$fg_bold[green]%}%n%{$reset_color%}"
    fi
    _HOSTNAME="%{$fg_bold[blue]%}%m%{$reset_color%}"
    _PATH="%~"
    _TIME="%T"

    LEFT="%{$fg[cyan]%}[$_USERNAME%{$fg[cyan]%}@$_HOSTNAME%{$fg[cyan]%}: %{$reset_color%}$_PATH%{$fg[cyan]%}]%{$reset_color%}"
    RIGHT="%{$fg_bold[grey]%}$(cyb_prompt_git_hash)$_TIME%{$reset_color%} "

    RIGHTWIDTH=$(($COLUMNS-${#LEFT}))
    #print -rP $LEFT${(l:$RIGHTWIDTH::.:)RIGHT}
    print -rP "$LEFT$(cyb_get_space $LEFT $RIGHT)$RIGHT";
}

setopt prompt_subst
PROMPT='$(cyb_prompt_status)'
RPROMPT='$(git_prompt_info)$(git_prompt_status)$(git_prompt_ahead)%{$reset_color%}'
