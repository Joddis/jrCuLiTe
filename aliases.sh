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
alias jrI='cat ~/jrCuLiTe/info.txt'

# oppdater lokale versjoner fra GitHub
alias jrCuLiTe_update='\
LOGFILE=~/jrCuLiTe/update.log; \
echo "[jrCuLiTe] Starter oppdatering..." | tee -a "$LOGFILE"; \

echo "[jrCuLiTe] Henter install.sh..." | tee -a "$LOGFILE"; \
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/install.sh -o ~/jrCuLiTe/install.sh && \
echo "[jrCuLiTe] install.sh oppdatert." | tee -a "$LOGFILE"; \

echo "[jrCuLiTe] Henter aliases.sh..." | tee -a "$LOGFILE"; \
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/aliases.sh -o ~/jrCuLiTe/aliases.sh && \
echo "[jrCuLiTe] aliases.sh oppdatert." | tee -a "$LOGFILE"; \

echo "[jrCuLiTe] Henter tmux.conf..." | tee -a "$LOGFILE"; \
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux.conf -o ~/.tmux.conf && \
echo "[jrCuLiTe] tmux.conf oppdatert." | tee -a "$LOGFILE"; \

echo "[jrCuLiTe] Oppdaterer info.txt..." | tee -a "$LOGFILE"; \
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/info.txt -o ~/jrCuLiTe/info.txt && \
echo "[jrCuLiTe] info.txt oppdatert." | tee -a "$LOGFILE"; \

echo "[jrCuLiTe] Oppdaterer shell..." | tee -a "$LOGFILE"; \
source ~/.bashrc && \
echo "[jrCuLiTe] Oppdatering fullført." | tee -a "$LOGFILE"'
