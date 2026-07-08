#!/bin/bash
set -e

# Finn absolutt sti til scriptets mappe
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOGFILE="$SCRIPT_DIR/update.log"
TMPDIR="$SCRIPT_DIR/tmp-update"

echo "[jrCuLiTe] Starter oppdatering..." | tee -a "$LOGFILE"

# Rydd opp gammel TMPDIR
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"

echo "[jrCuLiTe] Henter siste versjon fra GitHub..." | tee -a "$LOGFILE"

# Last ned ren UTF-8 tarball fra GitHub
curl -L https://github.com/joddis/jrCuLiTe/archive/refs/heads/main.tar.gz -o "$TMPDIR/archive.tar.gz"

# Pakk ut innholdet
tar -xzf "$TMPDIR/archive.tar.gz" -C "$TMPDIR" --strip-components=1

echo "[jrCuLiTe] Oppdaterer lokale filer..." | tee -a "$LOGFILE"

# Kopier filer tilbake til scriptets mappe
cp "$TMPDIR"/*.sh "$SCRIPT_DIR/"
cp "$TMPDIR"/tmux.conf ~/.tmux.conf
cp "$TMPDIR"/aliases.sh "$SCRIPT_DIR/aliases.sh"
cp "$TMPDIR"/info.txt "$SCRIPT_DIR/info.txt"

echo "[jrCuLiTe] Setter kjørbarhet på scripts..." | tee -a "$LOGFILE"
chmod +x "$SCRIPT_DIR"/*.sh

echo "[jrCuLiTe] Rydder opp midlertidige filer..." | tee -a "$LOGFILE"
rm -rf "$TMPDIR"

echo "[jrCuLiTe] Oppdaterer shell..." | tee -a "$LOGFILE"

# Reload bashrc og alias-fil
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f "$SCRIPT_DIR/aliases.sh" ]; then
    source "$SCRIPT_DIR/aliases.sh"
fi

# Kjør NAS-tilkobling
CONNECT_SCRIPT="$(dirname "$0")/Connect2linuxShare.sh"
if [ -f "$CONNECT_SCRIPT" ]; then
    echo "[linuxShare] Kjør NAS-tilkobling..."
    chmod +x "$CONNECT_SCRIPT"
    "$CONNECT_SCRIPT"
else
    echo "[linuxShare] Connect2linuxShare.sh ikke funnet – hopper over."
fi


echo "[jrCuLiTe] Oppdatering fullført." | tee -a "$LOGFILE"
