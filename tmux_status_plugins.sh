#!/bin/bash

echo "============================="
echo " jrCuLiTe TMUX PLUGIN STATUS "
echo "============================="
echo

# TPM installed?
TPM_INSTALLED=$( [ -d ~/.tmux/plugins/tpm ] && echo yes || echo no )
echo "TPM installed:        $TPM_INSTALLED"

# TPM active?
TPM_ACTIVE=$( tmux list-keys | grep -q install_plugins && echo yes || echo no )
echo "TPM active:           $TPM_ACTIVE"

# List plugins dynamically
echo
echo "Plugins:"
tmux show-options -g | grep '^@plugin' | sed 's/^@plugin "\(.*\)"/ - \1/' || echo " - none"

# Count plugins
PLUGIN_COUNT=$( tmux show-options -g | grep -c '^@plugin' )
echo
echo "Plugin count:         $PLUGIN_COUNT"

# Dependencies
GIT=$( command -v git >/dev/null && echo yes || echo no )
CURL=$( command -v curl >/dev/null && echo yes || echo no )
echo
echo "Git available:        $GIT"
echo "Curl available:       $CURL"

echo
echo "=========================="
