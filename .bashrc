#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# 8-bits colors
RED_8BIT=$'\e[1;31m'
GREEN_8BIT=$'\e[1;32m'

# 24-bits colors
RED_24BIT=$'\e[38;2;210;31;60m'
BLUE_24BIT=$'\e[38;2;123;179;255m'
GREEN_24BIT=$'\e[38;2;152;255;152m'
PINK_24BIT=$'\e[38;2;255;152;255m'
YELLOW_24BIT=$'\e[38;2;190;155;123m'
GREY_24BIT=$'\e[38;2;41;39;36m'
ORANGE_24BIT=$'\e[38;2;255;99;71m'
CYAN_24BIT=$'\e[38;2;71;227;255m'
BROWN_24BIT=$'\e[38;2;190;155;123m'
NORMAL=$'\e[0m'

# Icons
ARCH_ICON=" "
FOLDER_ICON=" "
MULTI_LINE_ICON_1="╭─"
MULTI_LINE_ICON_2="╰─"
CIRCLE_ICON=" "
CIRCLE_DOT_ICON=" "
BRANCH_NAME_ICON=" "

# GIT branch (fast & safe)
git_branch() {
    local BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    printf "%s%s[%s]%s" "$ORANGE_24BIT$BRANCH_NAME_ICON" "$CYAN_24BIT" "$BRANCH" "$NORMAL"
}

# Exit status indicator
prompt_exit_status() {
    local STATUS=$?

    # Skip first prompt
    if [ -z ${__PROMPT_INIT+x} ]; then
        __PROMPT_INIT=1
        return
    fi

    tput sc
    tput cuf $(( $(tput cols) - 2 ))

    if [ $STATUS -eq 0 ]; then
        printf "%b%s" "$GREEN_8BIT" " "
    else
        printf "%b%s" "$RED_8BIT" "✘ "
    fi

    tput rc
}

# Cursor helpers (PS0)
ps0_up() {
    tput cuu 2
}

ps0_down() {
    tput cud 1
    tput cub 4
}

# PROMPT_COMMAND (append-safe)
PROMPT_COMMAND="prompt_exit_status${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# PS1 (before typing)
PS1="\[${BROWN_24BIT}\]${MULTI_LINE_ICON_1}\[${RED_24BIT}\]${ARCH_ICON} \[${PINK_24BIT}\]${FOLDER_ICON}\[\${PINK_24BIT}\][\[\${GREEN_24BIT}\]\W\[\${PINK_24BIT}\]] \[\$(git_branch)\]\r\n\[${BROWN_24BIT}\]${MULTI_LINE_ICON_2}\[${GREY_24BIT}\]${CIRCLE_ICON}\[\${NORMAL}\] "

# PS0 (after enter)
PS0="\[\$(ps0_up)\]\[${BROWN_24BIT}\]${MULTI_LINE_ICON_1}\[${RED_24BIT}\]${ARCH_ICON} \[${PINK_24BIT}\]${FOLDER_ICON}\[\${PINK_24BIT}\][\[\${GREEN_24BIT}\]\W\[\${PINK_24BIT}\]] \[\$(git_branch)\]\r\n\[${BROWN_24BIT}\]${MULTI_LINE_ICON_2}\[${GREEN_24BIT}\]${CIRCLE_DOT_ICON}\[\${NORMAL}\]\[\$(ps0_down)\]"

