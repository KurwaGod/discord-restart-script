#!/bin/bash


echo "Searching for Discord processes..."

DISCORD_PIDS=$(pgrep -i discord)

# DISCORD_PIDS=$(ps aux | grep -i discord | grep -v grep | awk '{print $2}')

if [ -z "$DISCORD_PIDS" ]; then
    echo "No Discord processes found."
    exit 0
fi

echo "Found Discord processes with PIDs: $DISCORD_PIDS"

for PID in $DISCORD_PIDS; do
    echo "Killing Discord process with PID: $PID"
    kill -9 "$PID"

    if [ $? -eq 0 ]; then
        echo "Successfully killed process $PID"
    else
        echo "Failed to kill process $PID (may require sudo)"
    fi
done

echo "Discord kill operation completed."

sleep 1
REMAINING_PIDS=$(pgrep -i discord)
if [ -n "$REMAINING_PIDS" ]; then
    echo "Warning: Some Discord processes may still be running: $REMAINING_PIDS"
else
    echo "All Discord processes have been terminated."
fi
