#!/bin/bash

echo "=================================="
echo " jrCuLiTe TMUX KEYBINDINGS STATUS "
echo "=================================="
echo

# Tmux version
TMUX_VERSION=$(tmux -V | awk '{print $2}')
echo "Tmux version:         $TMUX_VERSION"
echo

# Active keybindings
echo "Active keybindings:"
tmux list-keys | sed 's/^/ - /'
echo

# Default keybindings
echo "Default keybindings:"
tmux list-keys -T root | sed 's/^/ - /'
echo

# Differences (custom keybindings)
echo "Custom keybindings (differences):"
comm -13 \
    <(tmux list-keys -T root | sort) \
    <(tmux list-keys | sort) \
    | sed 's/^/ - /' \
    || echo " - none"

echo
echo "=========================="
