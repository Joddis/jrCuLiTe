#!/bin/bash
set -e

LOGFILE=~/jrCuLiTe/jrCuLiTe_update.log

echo "[jrCuLiTe] Starter oppdatering..." | tee -a "$LOGFILE"

TMPDIR=~/jrCuLiTe-temp
mkdir -p "$TMPDIR"

# --- Last ned alle filer fra GitHub ---
echo "[jrCuLiTe] Henter siste versjon fra GitHub..." | tee -a "$LOGFILE"
git clone https://github.com/joddis/jrCuLiTe.git "$TMPDIR"

# --- Kopier filer ---
echo "[jrCuLiTe] Oppdaterer lokale filer..." | tee -a "$LOGFILE"
cp "$TMPDIR"/*.sh ~/jrCuLiTe/
cp "$TMPDIR"/tmux.conf ~/.tmux.conf
cp "$TMPDIR"/aliases.sh ~/jrCuLiTe/aliases.sh
cp "$TMPDIR"/info.txt ~/jrCuLiTe/info.txt

# --- Rydd opp ---
rm -rf "$TMPDIR"

# --- Sett +x på alle scripts ---
echo "[jrCuLiTe] Setter kjørbarhet på scripts..." | tee -a "$LOGFILE"
chmod +x ~/jrCuLiTe/*.sh

# --- Reload shell ---
echo "[jrCuLiTe] Oppdaterer shell..." | tee -a "$LOGFILE"
source ~/.bashrc
source ~/jrCuLiTe/aliases.sh

echo "[jrCuLiTe] Oppdatering fullført." | tee -a "$LOGFILE"
