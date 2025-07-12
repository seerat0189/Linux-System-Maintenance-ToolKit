#!/bin/bash

while true; do
    CHOICE=$(zenity --list \
        --title="🗂️ Backup & Restore Utility" \
        --width=450 --height=280 \
        --column="Option" --column="Action" \
        1 "🗜️ Create Backup" \
        2 "📦 Restore Backup" \
        3 "↩️ Back to Main Menu")

    case $CHOICE in
        1)
            DIR=$(zenity --file-selection --directory --title="📁 Select Folder to Backup")
            [ -z "$DIR" ] && continue

            DEST=$(zenity --file-selection --save --confirm-overwrite --title="💾 Save Backup As (.tar.gz)")
            [ -z "$DEST" ] && continue

            tar -czf "$DEST" "$DIR" 2>/tmp/bkp_error.log
            if [ $? -eq 0 ]; then
                zenity --info --title="✅ Backup Success" --text="Backup created at:\n<b>$DEST</b>"
            else
                zenity --text-info --title="❌ Backup Error" --filename=/tmp/bkp_error.log --width=600 --height=400
            fi
            ;;
        2)
            FILE=$(zenity --file-selection --title="📂 Select Backup File (.tar.gz)")
            [ -z "$FILE" ] && continue

            DEST=$(zenity --file-selection --directory --title="📁 Select Destination to Restore")
            [ -z "$DEST" ] && continue

            mkdir -p "$DEST"
            tar -xzf "$FILE" -C "$DEST" 2>/tmp/restore_error.log
            if [ $? -eq 0 ]; then
                zenity --info --title="✅ Restore Success" --text="Backup restored to:\n<b>$DEST</b>"
            else
                zenity --text-info --title="❌ Restore Error" --filename=/tmp/restore_error.log --width=600 --height=400
            fi
            ;;
        3|*)
            break ;;
    esac
done

