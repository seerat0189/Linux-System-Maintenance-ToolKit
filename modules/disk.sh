#!/bin/bash

while true; do
    CHOICE=$(zenity --list \
        --title="💽 Disk Usage Inspector" \
        --width=480 --height=300 \
        --column="Option" --column="Action" \
        1 "📊 Show Disk Usage (df -h)" \
        2 "🧱 Show Mounted Partitions (lsblk)" \
        3 "🔍 Find Large Files in Directory" \
        4 "↩️ Back to Main Menu")

    case $CHOICE in
        1)
            df -h > /tmp/disk_usage.txt
            zenity --text-info --title="💽 Disk Usage" --filename="/tmp/disk_usage.txt" --width=700 --height=500
            ;;
        2)
            lsblk > /tmp/partitions.txt
            zenity --text-info --title="🧱 Mounted Partitions" --filename="/tmp/partitions.txt" --width=700 --height=500
            ;;
        3)
            DIR=$(zenity --entry \
                --title="🔍 Find Large Files" \
                --text="Enter directory to scan:" \
                --entry-text="/home")
            [ -z "$DIR" ] && continue
            du -ah "$DIR" 2>/dev/null | sort -rh | head -n 20 > /tmp/large_files.txt
            zenity --text-info --title="Top 20 Largest Files in $DIR" --filename="/tmp/large_files.txt" --width=700 --height=500
            ;;
        4|*)
            break ;;
    esac
done

