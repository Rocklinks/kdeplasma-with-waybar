#!/usr/bin/env bash
# powermenu.sh — Power menu launcher for Rofi
# Author: Rocklin K S (2025)
# Description: Presents a simple power menu using the theme provided.
# Dependencies: rofi, systemctl, loginctl, i3lock (or any lock tool)



# Commands
uptime="$(uptime -p | sed -e 's/up //g')"
host="$(hostname)"

# Options
options=(
  " "
  ""
  " "
  ""
  "⏻"
)

# Run rofi menu with only icons as options
chosen="$(printf '%s\n' "${options[@]}" | rofi \
  -theme "~/.config/rofi/powermenu.rasi" \
  -dmenu -i \
  -p "$host@$USER" \
  -mesg "Uptime: $uptime" \
  -me-select-entry '' \
  -me-accept-entry 'MousePrimary')"

# Assign chosen option to $1 for use
set -- $chosen

case "$1" in
  "")
    qdbus6 org.freedesktop.ScreenSaver /ScreenSaver Lock ;;
  "")
    qdbus6 org.freedesktop.PowerManagement /org/freedesktop/PowerManagement Suspend ;;
  "")
    systemctl reboot ;;
  "")
    systemctl poweroff ;;
  "")
    qdbus6 org.kde.Shutdown /Shutdown org.kde.Shutdown.logout ;;
  *)
    exit 0 ;;
esac
