# jrCuLiTe alias-fil
####################

# system
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo apt update && sudo apt upgrade -y'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# docker
alias jrDocStat='clear && docker ps --format "table {{.Names}}\t{{.Status}}"'

# tmux quality-of-life
alias tm='tmux attach || tmux new'
alias tml='tmux ls'
alias tmk='tmux kill-session -t'

# vis min nyttige info/tips/triks notat
alias jrI='clear && cat ~/jrCuLiTe/info.txt'

# oppdater lokale versjoner fra GitHub
alias jrCuLiTe_update='~/jrCuLiTe/update.sh'
