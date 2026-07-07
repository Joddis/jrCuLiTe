#!/bin/bash
set -e

INSTALL_DIR="$HOME/jrCuLiTe"
LOGFILE="$INSTALL_DIR/uninstall.log"

echo "[jrCuLiTe] Starter full avinstallasjon..." | tee -a "$LOGFILE"

# Fjern aliaser fra shell-profiler
echo "[jrCuLiTe] Fjerner aliaser fra shell-profiler..." | tee -a "$LOGFILE"

# Fjern jrCuLiTe aliaser fra .bashrc
if grep -q "jrCuLiTe" ~/.bashrc; then
    sed -i '/jrCuLiTe/d' ~/.bashrc
fi

# Fjern jrCuLiTe aliaser fra .bash_profile hvis den finnes
if [ -f ~/.bash_profile ] && grep -q "jrCuLiTe" ~/.bash_profile; then
    sed -i '/jrCuLiTe/d' ~/.bash_profile
fi

# Fjern tmux.conf hvis den ble installert av jrCuLiTe
if [ -f ~/.tmux.conf ]; then
    echo "[jrCuLiTe] Fjerner ~/.tmux.conf..." | tee -a "$LOGFILE"
    rm ~/.tmux.conf
fi

# Fjern hele jrCuLiTe-mappen
if [ -d "$INSTALL_DIR" ]; then
    echo "[jrCuLiTe] Sletter $INSTALL_DIR..." | tee -a "$LOGFILE"
    rm -rf "$INSTALL_DIR"
fi

echo "[jrCuLiTe] Rydder opp i shell..." | tee -a "$LOGFILE"

# Reload shell-profiler
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
fi

echo "[jrCuLiTe] Full avinstallasjon fullført." | tee -a "$LOGFILE"
