#!/bin/bash
set -e

# Fast installasjonsmappe
INSTALL_DIR="$HOME/jrCuLiTe"

LOGFILE="$INSTALL_DIR/install.log"
TMPDIR="$INSTALL_DIR/tmp-install"

echo "[jrCuLiTe] Starter installasjon..."

# Opprett installasjonsmappe hvis den ikke finnes
mkdir -p "$INSTALL_DIR"

# Rydd opp gammel TMPDIR
rm -rf "$TMPDIR"
mkdir -p "$TMPDIR"

echo "[jrCuLiTe] Henter siste versjon fra GitHub..."

# Last ned ren UTF-8 tarball fra GitHub
curl -L https://github.com/joddis/jrCuLiTe/archive/refs/heads/main.tar.gz -o "$TMPDIR/archive.tar.gz"

# Pakk ut innholdet
tar -xzf "$TMPDIR/archive.tar.gz" -C "$TMPDIR" --strip-components=1

echo "[jrCuLiTe] Installerer filer..."

# Kopier filer inn i installasjonsmappen
cp "$TMPDIR"/*.sh "$INSTALL_DIR/"
cp "$TMPDIR"/tmux.conf ~/.tmux.conf
cp "$TMPDIR"/aliases.sh "$INSTALL_DIR/aliases.sh"
cp "$TMPDIR"/info.txt "$INSTALL_DIR/info.txt"

echo "[jrCuLiTe] Setter kjørbarhet på scripts..."
chmod +x "$INSTALL_DIR"/*.sh

echo "[jrCuLiTe] Rydder opp midlertidige filer..."
rm -rf "$TMPDIR"

echo "[jrCuLiTe] Oppdaterer shell..."

# Reload bashrc og alias-fil
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f "$INSTALL_DIR/aliases.sh" ]; then
    source "$INSTALL_DIR/aliases.sh"
fi

# Kjør NAS-tilkobling
if [ -f "./Connect2linuxShare.sh" ]; then
    chmod +x ./Connect2linuxShare.sh
    ./Connect2linuxShare.sh
fi

echo "[jrCuLiTe] Installasjon fullført."
