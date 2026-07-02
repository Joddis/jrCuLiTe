#!/bin/bash

echo "==================================="
echo " jrCuLiTe TMUX DEFAULT KEYBINDINGS "
echo "==================================="
echo

tmux list-keys -T root | sed 's/^/ - /'

echo
echo "=========================="
