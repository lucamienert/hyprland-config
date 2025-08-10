#!/bin/bash

# Get the focused window class from Hyprland
app_name=$(hyprctl activewindow -j | jq -r '.class')

# Check if empty or null
if [ -z "$app_name" ] || [ "$app_name" = "null" ]; then
  echo ""
else
  # Strip "org.gnome." prefix if it exists
  app_name=${app_name#org.gnome.}
  echo "[$app_name]"
fi
