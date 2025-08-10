#!/bin/bash

# Get list of open windows and their workspaces
mapfile -t entries < <(hyprctl clients -j | jq -r '.[] | "\(.initialTitle)::\(.workspace.id)"')

# Use wofi to let user pick one
selected=$(printf '%s\n' "${entries[@]}" | awk -F'::' '{print $1}' | wofi --show dmenu -p "Open Apps:" -I )

# Find workspace for selected window
workspace=$(printf '%s\n' "${entries[@]}" | grep "^$selected::" | awk -F'::' '{print $2}' | head -n1)

# Dispatch to the workspace if found
if [[ -n "$workspace" ]]; then
    hyprctl dispatch workspace "$workspace"
fi
