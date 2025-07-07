#!/bin/bash

LOG="/tmp/syscare_pkg.log"
> "$LOG"

while true; do
    CHOICE=$(zenity --list \
        --title="📦 Package Manager" \
        --width=480 --height=300 \
        --column="Option" --column="Action" \
        1 "🔄 Update Package List" \
        2 "⬆️ Upgrade All Packages" \
        3 "🧹 Autoremove Unused Packages" \
        4 "📋 View Installed Packages" \
        5 "↩️ Back to Main Menu")

    case $CHOICE in
        1)
            echo "🔄 Updating package list..." > "$LOG"
            sudo apt update >> "$LOG" 2>&1
            zenity --text-info --title="Update Complete" --filename="$LOG" --width=700 --height=500
            ;;
        2)
            echo "⬆️ Upgrading all packages..." > "$LOG"
            sudo apt upgrade -y >> "$LOG" 2>&1
            zenity --text-info --title="Upgrade Complete" --filename="$LOG" --width=700 --height=500
            ;;
        3)
            echo "🧹 Autoremoving unused packages..." > "$LOG"
            sudo apt autoremove -y >> "$LOG" 2>&1
            zenity --text-info --title="Autoremove Complete" --filename="$LOG" --width=700 --height=500
            ;;
        4)
            dpkg --get-selections | grep -v deinstall > "$LOG"
            zenity --text-info --title="📋 Installed Packages" --filename="$LOG" --width=700 --height=500
            ;;
        5|*)
            break ;;
    esac
done

