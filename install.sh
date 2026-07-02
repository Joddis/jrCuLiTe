#!/bin/bash
set -e

echo "[jrCustom] Starter installasjon..."

if command -v apt >/dev/null; then
    echo "[jrCustom] Installerer tmux..."
    sudo apt update -y
    sudo apt install -y tmux curl
elif command -v dnf >/dev/null; then
    sudo dnf install -y tmux curl
elif command -v pacman >/dev/null; then
    sudo pacman -Sy --noconfirm tmux curl
fi

echo "[jrCustom] Laster ned tmux.conf..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux.conf -o ~/.tmux.conf

echo "[jrCustom] Oppretter jrCustom-katalog..."
mkdir -p ~/jrCustom

echo "[jrCustom] Installerer alias-fil..."
cp "$(dirname "$0")/aliases.sh" ~/jrCustom/aliases.sh

echo "[jrCustom] Oppdaterer .bashrc..."
if ! grep -q "jrCustom/aliases.sh" ~/.bashrc; then
    {
        echo ""
        echo "# jrCustom aliases"
        echo "source ~/jrCustom/aliases.sh"
    } >> ~/.bashrc
fi

echo "[jrCustom] Ferdig! Start en ny terminal for å aktivere alias."
