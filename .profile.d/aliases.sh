# shellcheck shell=bash
alias grep='grep --color'

[[ $(command -v vim) != "" ]] && alias vi='vim'

# Prevent accidents - use \rm if you want all the power back.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias gla='git logdog --all'

alias l="ls"
alias ll="ls -lAhG"
alias la='ls -Alh'         # show hidden files
alias lk='ls -lSr -h'      # sort by size, biggest last
alias lc='ls -ltcr -h'     # sort by and show change time, most recent last
alias lu='ls -ltur -h'     # sort by and show access time, most recent last
alias lt='ls -ltr -h'      # sort by date, most recent last
alias lm='ls -al |more'    # all, long piped through more
alias lr='ls -lR -h'       # recursive ls

alias cls='\clear && printf '\''\033[3J'\'''
