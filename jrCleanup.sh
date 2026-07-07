#!/bin/bash

LOGFILE="/var/log/ultimate-cleanup.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== ULTIMATE CLEANUP SCRIPT ==="
echo "Loggfil: $LOGFILE"
echo

echo "[$TIMESTAMP] Starter opprydding..." | tee -a "$LOGFILE"

echo "Måler diskforbruk før opprydding..."
BEFORE=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "Ledig plass før: ${BEFORE} GB" | tee -a "$LOGFILE"
echo

echo "[1/15] Stopper Docker containere som ikke kjører..."
docker container prune -f

echo "[2/15] Fjerner ubrukte Docker images..."
docker image prune -a -f

echo "[3/15] Fjerner dangling Docker layers..."
docker system prune -a -f

echo "[4/15] Fjerner ubrukte Docker volumes..."
docker volume prune -f

echo "[5/15] Rydder containerd images..."
nerdctl image prune -a -f 2>/dev/null

echo "[6/15] Rydder containerd containere..."
nerdctl container prune -f 2>/dev/null

echo "[7/15] Rydder containerd system..."
nerdctl system prune -a -f 2>/dev/null

echo "[8/15] Fjerner gamle containerd snapshots..."
find /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/ \
     -maxdepth 1 -type d -exec rm -rf {}/fs 2>/dev/null \;

echo "[9/15] Fjerner APT cache..."
apt-get clean
apt-get autoclean

echo "[10/15] Fjerner ubrukte pakker..."
apt-get autoremove --purge -y

echo "[11/15] Fjerner orphaned packages..."
deborphan | xargs apt-get -y remove --purge 2>/dev/null

echo "[12/15] Fjerner gamle kernels..."
CURRENT_KERNEL=$(uname -r)
dpkg -l 'linux-image-*' | awk '/^ii/{print $2}' | grep -v "$CURRENT_KERNEL" | xargs apt-get -y purge 2>/dev/null

echo "[13/15] Rydder journal logs..."
journalctl --vacuum-size=200M

echo "[14/15] Rydder /tmp og /var/tmp..."
rm -rf /tmp/*
rm -rf /var/tmp/*

echo "[15/15] Rydder brukercache..."
rm -rf ~/.cache/*

echo
echo "Måler diskforbruk etter opprydding..."
AFTER=$(df -BG / | tail -1 | awk '{print $4}' | sed 's/G//')
echo "Ledig plass etter: ${AFTER} GB" | tee -a "$LOGFILE"

FREED=$((AFTER - BEFORE))

echo
echo "=== OPPSUMMERING ==="
echo "Frigjort plass: ${FREED} GB" | tee -a "$LOGFILE"
echo "Opprydding fullført." | tee -a "$LOGFILE"
echo "======================" | tee -a "$LOGFILE"
