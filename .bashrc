# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 8-bits colors
R8="1;95"

# 24-bits colors
RED="\[\033[38;2;255;0;0m\]"
BLUE="\[\033[38;2;123;179;255m\]"
GREEN="\[\033[38;2;152;255;152m\]"
PINK="\[\033[38;2;255;152;255m\]"
YELLOW="\[\033[38;2;190;155;123m\]"
GREY="\[\033[38;2;41;39;36m\]"
ORANGE="\[\033[38;2;255;99;71m\]"
CYAN="\[\033[38;2;71;227;255m\]"
NORMAL="\[\033[0m\]"

# alias commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias update='sudo timedatectl set-ntp true && sudo pacman -Syu && yay -Syu && sudo pacman -Scc && yay -Scc && sudo pacman -Rns $(pacman -Qtdq)'

# Icons
ARCH_ICON=$(echo -e "\033[38;2;210;31;60m ")
FOLDER_ICON=$(echo -e "\033[38;2;255;152;255m ")
MULTI_LINE_ICON_1=$(echo -e "\033[38;2;190;155;123m╭─")
MULTI_LINE_ICON_2=$(echo -e "\033[38;2;190;155;123m╰─")
CIRCLE_ICON=$(echo -e "\033[38;2;41;39;36m ")
CIRCLE_DOT_ICON=$(echo -e "\033[38;2;152;255;152m ")
BRANCH_NAME_ICON=$(echo -e "\033[38;2;255;99;71m ")

COUNT=0

# Function get git branch name and display it (if available)
f1() {
    GET_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [ ! -z "$GET_BRANCH" ]; then
        #printf "\001\033[38;2;255;99;71m [\001\033[38;2;71;227;255m\002%s\001\033[38;2;255;99;71m\002]" $GET_BRANCH
        echo -e "${BRANCH_NAME_ICON}[${CYAN}${GET_BRANCH}${ORANGE}]"
    fi
}

# Funtion update and display PS0
f2() {
    tput cuu 2
}

# Function detect the first time running,
# Get exit status code and display it at right corner of terminal
f3() {
    ESC=$?

    if [ $COUNT == 0 ]; then
        COUNT=1
    else
        tput sc
        tput cuf $(($(tput cols) - 2))

        if [ $ESC == 0 ]; then
            echo -e "\033[38;2;0;255;0m "
        else
            echo -e "\033[38;2;255;0;0m✘ "
        fi

        tput rc
    fi

}

# Function move cursor down and back
f4() {
    tput cud 1
    tput cub 4
}

# PROMPT_COMMAND will be run before display PS1
PROMPT_COMMAND="f3${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# PS1 display before enter command
PS1="${MULTI_LINE_ICON_1}${ARCH_ICON} ${FOLDER_ICON}${PINK}[${GREEN}\W${PINK}] \[\$(f1)\]\r\n${MULTI_LINE_ICON_2}${CIRCLE_ICON}${NORMAL} "

# PS0 display after a command entered
PS0="\[\$(f2)\]${MULTI_LINE_ICON_1}${ARCH_ICON} ${FOLDER_ICON}${PINK}[${GREEN}\W${PINK}] \[\$(f1)\]\r\n${MULTI_LINE_ICON_2}${CIRCLE_DOT_ICON}${NORMAL}\[\$(f4)\]"

