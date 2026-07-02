#!/bin/bash
set -e

echo "[jrCuLiTe] Starter installasjon..."

# --- Installer tmux + curl + git ---
if command -v apt >/dev/null; then
    echo "[jrCuLiTe] Installerer tmux, curl og git..."
    sudo apt update -y
    sudo apt install -y tmux curl git
elif command -v dnf >/dev/null; then
    sudo dnf install -y tmux curl git
elif command -v pacman >/dev/null; then
    sudo pacman -Sy --noconfirm tmux curl git
fi

# --- Last ned tmux.conf ---
echo "[jrCuLiTe] Laster ned tmux.conf..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux.conf -o ~/.tmux.conf

# --- Opprett jrCuLiTe-katalog ---
echo "[jrCuLiTe] Oppretter jrCuLiTe-katalog..."
mkdir -p ~/jrCuLiTe

# --- Last ned aliases.sh ---
echo "[jrCuLiTe] Laster ned aliases.sh..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/aliases.sh -o ~/jrCuLiTe/aliases.sh

# --- Last ned info.txt ---
echo "[jrCuLiTe] Laster ned info.txt..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/info.txt -o ~/jrCuLiTe/info.txt

# --- Last ned update.sh ---
echo "[jrCuLiTe] Laster ned update.sh..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/update.sh -o ~/jrCuLiTe/update.sh

# --- Last ned status-scripts ---
echo "[jrCuLiTe] Laster ned status-scripts..."
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux_status.sh -o ~/jrCuLiTe/tmux_status.sh
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux_status_plugins.sh -o ~/jrCuLiTe/tmux_status_plugins.sh
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux_status_kb.sh -o ~/jrCuLiTe/tmux_status_kb.sh
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux_status_kb2.sh -o ~/jrCuLiTe/tmux_status_kb2.sh
curl -fsSL https://raw.githubusercontent.com/joddis/jrCuLiTe/main/tmux_status_kb3.sh -o ~/jrCuLiTe/tmux_status_kb3.sh

# --- Sett +x på alle .sh-filer ---
echo "[jrCuLiTe] Setter kjørbarhet på alle scripts..."
chmod +x ~/jrCuLiTe/*.sh

# --- Oppdater .bashrc ---
echo "[jrCuLiTe] Oppdaterer .bashrc..."
if ! grep -q "jrCuLiTe/aliases.sh" ~/.bashrc; then
    {
        echo ""
        echo "# jrCuLiTe aliases"
        echo "source ~/jrCuLiTe/aliases.sh"
    } >> ~/.bashrc
fi

# --- Installer TPM (Tmux Plugin Manager) ---
echo "[jrCuLiTe] Sjekker TPM..."
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    echo "[jrCuLiTe] Installerer TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "[jrCuLiTe] TPM allerede installert."
fi

# --- Reload tmux + installer plugins ---
if tmux has-session 2>/dev/null; then
    echo "[jrCuLiTe] Reloading tmux config..."
    tmux source-file ~/.tmux.conf

    echo "[jrCuLiTe] Installerer tmux-plugins..."
    ~/.tmux/plugins/tpm/bin/install_plugins
else
    echo "[jrCuLiTe] Ingen tmux-session aktiv."
    echo "[jrCuLiTe] Start tmux og trykk prefix + I for å installere plugins."
fi

echo "[jrCuLiTe] Ferdig! Start en ny terminal for å aktivere alias."
