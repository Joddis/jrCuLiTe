#!/bin/bash
set -e

echo "[jrCuLiTe] Starter installasjon..."

if command -v apt >/dev/null; then
    echo "[jrCuLiTe] Installerer tmux..."
    sudo apt update -y
    sudo apt install -y tmux curl
elif command -v dnf >/dev/null; then
    sudo dnf install -y tmux curl
elif command -v pacman >/dev/null; then
    sudo pacman -Sy --noconfirm tmux curl
fi

echo "[jrCuLiTe] Laster ned tmux.conf..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux.conf -o ~/.tmux.conf

echo "[jrCuLiTe] Oppretter jrCuLiTe-katalog..."
mkdir -p ~/jrCuLiTe

echo "[jrCuLiTe] Laster ned aliases.sh..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/aliases.sh -o ~/jrCuLiTe/aliases.sh

echo "[jrCuLiTe] Laster ned info.txt..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/info.txt -o ~/jrCuLiTe/info.txt

echo "[jrCuLiTe] Oppdaterer .bashrc..."
if ! grep -q "jrCuLiTe/aliases.sh" ~/.bashrc; then
    {
        echo ""
        echo "# jrCuLiTe aliases"
        echo "source ~/jrCuLiTe/aliases.sh"
    } >> ~/.bashrc
fi

echo "[jrCustom] Ferdig! Start en ny terminal for å aktivere alias."
