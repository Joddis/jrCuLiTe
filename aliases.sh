# jrCuLiTe alias-fil
####################

# === jrCuLiTe shortcuts commands ===
alias jrI='clear && cat ~/jrCuLiTe/info.txt'   # vis min nyttige info/tips/triks notat
alias jrCuLiTe_update='~/jrCuLiTe/update.sh && source ~/jrCuLiTe/aliases.sh'   # oppdater lokale versjoner fra GitHub

# === egne kommandoer som kjører egne scripts ===
alias jrDocStat='clear && docker ps --format "table {{.Names}}\t{{.Status}}"'   # viser egenversjon av docker stats
alias jrCleanHDD='clear && sudo ~/jrCuLiTe/jrCleanHDD.sh'                       # rydder søppel fra disken

# === TMUX ===
alias tm='tmux attach || tmux new'
alias tml='tmux ls'
alias tmk='tmux kill-session -t'

# system
alias cls='history -c && tmux clear-history && clear'
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo apt update && sudo apt upgrade -y'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
