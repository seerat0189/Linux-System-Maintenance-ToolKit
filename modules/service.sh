#!/bin/bash

while true; do
    CHOICE=$(zenity --list \
        --title="🔧 Service Manager" \
        --width=460 --height=310 \
        --column="Option" --column="Action" \
        1 "📋 List Active Services" \
        2 "▶️ Start a Service" \
        3 "⏹️ Stop a Service" \
        4 "🔄 Restart a Service" \
        5 "🔍 Check Service Status" \
        6 "↩️ Back to Main Menu")

    case $CHOICE in
        1)
            systemctl list-units --type=service --no-pager > /tmp/services.txt
            zenity --text-info --title="📋 Active Services" --filename="/tmp/services.txt" --width=800 --height=600
            ;;
        2)
            SERVICE=$(zenity --entry --title="▶️ Start Service" --text="Enter service name to start:")
            [ -n "$SERVICE" ] && sudo systemctl start "$SERVICE" && \
            zenity --info --text="✅ Service '<b>$SERVICE</b>' started."
            ;;
        3)
            SERVICE=$(zenity --entry --title="⏹️ Stop Service" --text="Enter service name to stop:")
            [ -n "$SERVICE" ] && sudo systemctl stop "$SERVICE" && \
            zenity --info --text="✅ Service '<b>$SERVICE</b>' stopped."
            ;;
        4)
            SERVICE=$(zenity --entry --title="🔄 Restart Service" --text="Enter service name to restart:")
            [ -n "$SERVICE" ] && sudo systemctl restart "$SERVICE" && \
            zenity --info --text="✅ Service '<b>$SERVICE</b>' restarted."
            ;;
        5)
            SERVICE=$(zenity --entry --title="🔍 Service Status" --text="Enter service name to check:")
            [ -n "$SERVICE" ] && systemctl status "$SERVICE" > /tmp/svc_status.txt && \
            zenity --text-info --title="🔍 Status of $SERVICE" --filename="/tmp/svc_status.txt" --width=800 --height=600
            ;;
        6|*)
            break ;;
    esac
done

