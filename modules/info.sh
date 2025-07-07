#!/bin/bash

# System Info Dashboard (Zenity GUI version)

TMP_FILE="/tmp/system_info.txt"

# Gather system information
{
echo "🖥️  System Dashboard"
echo "════════════════════════════════════════"
echo ""
echo "📛 Hostname     : $(hostname)"
echo "👤 Current User : $USER"
echo "🕒 Uptime       : $(uptime -p)"
echo "🧠 Memory Usage : $(free -h | awk '/Mem:/ { print $3 " / " $2 }')"
echo "🧮 CPU Model    : $(lscpu | grep 'Model name' | awk -F ':' '{ print $2 }' | xargs)"
echo "📦 Kernel       : $(uname -r)"
echo "🌐 IP Address   : $(hostname -I | awk '{print $1}')"
echo "📅 Date & Time  : $(date)"
echo ""
echo "════════════════════════════════════════"
} > "$TMP_FILE"

# Display in a Zenity GUI box
zenity --text-info \
--title="System Info Dashboard" \
--filename="$TMP_FILE" \
--width=600 \
--height=400 \
--ok-label="Back"

