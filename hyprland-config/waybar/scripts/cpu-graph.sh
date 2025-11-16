#!/usr/bin/env bash

# Simple CPU usage bar graph
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)}')

# Create bar
bar_length=10
filled=$((cpu_usage / 10))
empty=$((bar_length - filled))

bar=""
for ((i=0; i<filled; i++)); do
    bar+="█"
done
for ((i=0; i<empty; i++)); do
    bar+="░"
done

# Color based on usage
if [ "$cpu_usage" -gt 90 ]; then
    color="#ff0055"
elif [ "$cpu_usage" -gt 70 ]; then
    color="#ff3333"
else
    color="#ee1111"
fi

echo "{\"text\":\"  $cpu_usage% $bar\", \"class\":\"cpu\", \"percentage\":$cpu_usage}"
