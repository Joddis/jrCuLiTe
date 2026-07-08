#!/usr/bin/env bash

# ============================================================
# Connect2linuxShare.sh
# Sikker mount av NAS-share + symlink til linuxShare
# ============================================================

NAS_IP="192.168.1.95"
NAS_SHARE="homejoddis"
MOUNT_POINT="/mnt/homejoddis"
SYMLINK="/mnt/linuxShare"
CREDENTIALS_FILE="/etc/jrshare.credentials"
ENV_FILE="./.env"

echo "[linuxShare] Starter sjekk..."

# ------------------------------------------------------------
# 1. Last inn credentials fra .env hvis den finnes
# ------------------------------------------------------------
if [ -f "$ENV_FILE" ]; then
    echo "[linuxShare] Fant .env – bruker lagrede credentials."
    source "$ENV_FILE"
else
    echo "[linuxShare] Ingen .env – ber om credentials."
    read -p "NAS brukernavn: " NAS_USERNAME
    read -s -p "NAS passord: " NAS_PASSWORD
    echo

    echo "NAS_USERNAME=\"$NAS_USERNAME\"" > "$ENV_FILE"
    echo "NAS_PASSWORD=\"$NAS_PASSWORD\"" >> "$ENV_FILE"
fi

# ------------------------------------------------------------
# 2. Sjekk om NAS er online
# ------------------------------------------------------------
if ping -c1 -W1 "$NAS_IP" >/dev/null 2>&1; then
    echo "[linuxShare] NAS online."
else
    echo "[linuxShare] NAS offline – avbryter."
    exit 1
fi

# ------------------------------------------------------------
# 3. Opprett mount-punkt hvis mangler
# ------------------------------------------------------------
if [ ! -d "$MOUNT_POINT" ]; then
    echo "[linuxShare] Oppretter mount-punkt: $MOUNT_POINT"
    sudo mkdir -p "$MOUNT_POINT"
fi

# ------------------------------------------------------------
# 4. Installer cifs-utils hvis mangler
# ------------------------------------------------------------
if ! command -v mount.cifs >/dev/null 2>&1; then
    echo "[linuxShare] Installerer cifs-utils..."
    sudo apt install -y cifs-utils
fi

# ------------------------------------------------------------
# 5. Opprett credentials-fil hvis mangler
# ------------------------------------------------------------
if [ ! -f "$CREDENTIALS_FILE" ]; then
    echo "[linuxShare] Oppretter credentials-fil..."
    echo "username=$NAS_USERNAME" | sudo tee "$CREDENTIALS_FILE" >/dev/null
    echo "password=$NAS_PASSWORD" | sudo tee -a "$CREDENTIALS_FILE" >/dev/null
    sudo chmod 600 "$CREDENTIALS_FILE"
fi

# ------------------------------------------------------------
# 6. Legg inn fstab-linje hvis mangler
# ------------------------------------------------------------
if ! grep -q "$NAS_IP/$NAS_SHARE" /etc/fstab; then
    echo "[linuxShare] Legger inn fstab-linje..."
    echo "//$NAS_IP/$NAS_SHARE $MOUNT_POINT cifs credentials=$CREDENTIALS_FILE,uid=1000,gid=1000,iocharset=utf8,file_mode=0777,dir_mode=0777,vers=1.0,nofail 0 0" \
        | sudo tee -a /etc/fstab >/dev/null
fi

# ------------------------------------------------------------
# 7. Sjekk om share allerede er mountet
# ------------------------------------------------------------
if mountpoint -q "$MOUNT_POINT"; then
    echo "[linuxShare] Share allerede mountet."
else
    echo "[linuxShare] Ikke mountet – forsøker mount..."
    sudo mount -a
fi

# ------------------------------------------------------------
# 8. Verifiser mount
# ------------------------------------------------------------
if mountpoint -q "$MOUNT_POINT"; then
    echo "[linuxShare] Share er nå mountet."
else
    echo "[linuxShare] Mount feilet."
    exit 1
fi

# ------------------------------------------------------------
# 9. Opprett symlink til linuxShare undermappen
# ------------------------------------------------------------
if [ ! -L "$SYMLINK" ]; then
    if [ -d "$MOUNT_POINT/linuxShare" ]; then
        echo "[linuxShare] Oppretter symlink: $SYMLINK"
        sudo ln -s "$MOUNT_POINT/linuxShare" "$SYMLINK"
    else
        echo "[linuxShare] Undermappen linuxShare finnes ikke på NAS."
        exit 1
    fi
else
    echo "[linuxShare] Symlink allerede eksisterer."
fi

echo "[linuxShare] Alt klart!"
exit 0
