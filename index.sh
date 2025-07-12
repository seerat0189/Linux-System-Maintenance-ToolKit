#!/bin/bash

if ! command -v zenity &> /dev/null; then
    echo "'zenity' is not installed. Please install it using: sudo apt install zenity"
    exit 1
fi

# Welcome message
zenity --info \
--title="🛠️ Linux System Maintenance Assistant" \
--width=420 \
--text="👋 Welcome to the Linux System Maintenance Assistant.\n\nUse this tool to perform essential system tasks through a graphical menu."

# Main menu loop
while true; do
    CHOICE=$(zenity --list \
        --title="🧰 Main Menu" \
        --width=480 --height=400 \
        --column="ID" --column="🧭 Action" \
        1 "📊 System Info Dashboard" \
        2 "🧹 Cleanup Utility" \
        3 "📦 Package Manager" \
        4 "🔧 Service Manager" \
        5 "💽 Disk Usage Inspector" \
        6 "📁 Backup & Restore" \
        7 "🚪 Exit")

    case $CHOICE in
        1) bash modules/info.sh ;;
        2) bash modules/cleanup.sh ;;
        3) bash modules/packages.sh ;;  
        4) bash modules/service.sh ;;
        5) bash modules/disk.sh ;;
        6) bash modules/backup.sh ;;
        7|"")
            zenity --info \
            --title="👋 Exit" \
            --text="Thank you for using the Linux System Maintenance Assistant.\n\nHave a great day!"
            exit 0 ;;
    esac
done

