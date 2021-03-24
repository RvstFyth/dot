
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXITCODE="$?"

    local HOSTCOLOR="5"
    local USERCOLOR="3"
    local PATHCOLOR="4"

    PS1="\e[3${HOSTCOLOR}m \h  \e[3${USERCOLOR}m \u  \e[3${PATHCOLOR}m \w  \n";

    if [ $EXITCODE == 0 ]; then
        PS1+="\e[32m\$ \e[0m";
    else
        PS1+="\e[31m\$ \e[0m";
    fi
}

if [ -e ~/.bashrc.aliases ] ; then
   source ~/.bashrc.aliases
fi

if [ -e ~/.bashrc.functions ]; then
    source ~/.bashrc.functions
fi
if [ -e ~/.bashrc.private ] ; then
   source ~/.bashrc.private
fi

BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano

export HISTTIMEFORMAT="%F %T "

PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '

figlet "Sudo I Love You" | lolcat
export TERM=xterm-256color


# Commands to be executed before the prompt is displayed
# Save current working dir
PROMPT_COMMAND='pwd > "${HOME}/.cwd"'

# Change to saved working dir
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)"

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
alias ttcore="cd ~/projects/tt-core"
