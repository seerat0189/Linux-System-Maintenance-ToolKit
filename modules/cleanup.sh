#!/bin/bash

TMP_LOG="/tmp/cleanup_log.txt"
> "$TMP_LOG"

while true; do
    CHOICE=$(zenity --list \
        --title="🧹 Cleanup Utility" \
        --width=500 --height=360 \
        --column="Option" --column="Task" \
        1 "🧠 Clear Memory Cache" \
        2 "🗑️ Clean /tmp Directory" \
        3 "🖼️ Clear Thumbnail Cache" \
        4 "🗂️ Clean Journal Logs (older than 2 days)" \
        5 "📊 Show Disk Usage Summary" \
        6 "↩️ Back to Main Menu")

    case $CHOICE in
        1)
            sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null
            echo "[✓] Cleared memory cache" >> "$TMP_LOG"
            zenity --info --text="✅ Memory cache cleared successfully."
            ;;
        2)
            sudo rm -rf /tmp/*
            echo "[✓] Cleaned /tmp directory" >> "$TMP_LOG"
            zenity --info --text="✅ /tmp directory cleaned."
            ;;
        3)
            rm -rf ~/.cache/thumbnails/*
            echo "[✓] Cleared thumbnail cache" >> "$TMP_LOG"
            zenity --info --text="✅ Thumbnail cache cleared."
            ;;
        4)
            sudo journalctl --vacuum-time=2d >> "$TMP_LOG" 2>&1
            echo "[✓] Deleted old journal logs" >> "$TMP_LOG"
            zenity --info --text="✅ Journal logs older than 2 days deleted."
            ;;
        5)
            df -h > /tmp/before_cleanup.txt
            zenity --text-info --title="📊 Disk Usage Before Cleanup" --filename="/tmp/before_cleanup.txt" --width=700 --height=500
            ;;
        6|*)
            break ;;
    esac
done

