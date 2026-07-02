#!/bin/bash

clear
echo "==========================="
echo " jrCuLiTe TMUX STATUS MENU "
echo "==========================="
echo
echo "1) Plugin status"
echo "2) Keybindings (active)"
echo "3) Keybindings (default only)"
echo "4) Keybindings (custom only)"
echo
read -p "Choose option: " CHOICE

case "$CHOICE" in
    1) ~/jrCuLiTe/tmux_status_plugins.sh ;;
    2) ~/jrCuLiTe/tmux_status_kb.sh ;;
    3) ~/jrCuLiTe/tmux_status_kb2.sh ;;
    4) ~/jrCuLiTe/tmux_status_kb3.sh ;;
    *) echo "Invalid choice" ;;
esac
