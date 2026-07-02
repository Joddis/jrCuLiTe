#!/bin/bash

echo "=================================="
echo " jrCuLiTe TMUX CUSTOM KEYBINDINGS "
echo "=================================="
echo

comm -13 \
    <(tmux list-keys -T root | sort) \
    <(tmux list-keys | sort) \
    | sed 's/^/ - /' \
    || echo " - none"

echo
echo "=========================="
