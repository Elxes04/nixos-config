#!/usr/bin/env bash

# Memory usage bar graph
mem_usage=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

# Create bar
bar_length=10
filled=$((mem_usage / 10))
empty=$((bar_length - filled))

bar=""
for ((i=0; i<filled; i++)); do
    bar+="█"
done
for ((i=0; i<empty; i++)); do
    bar+="░"
done

# Color based on usage
if [ "$mem_usage" -gt 90 ]; then
    color="#ff0055"
elif [ "$mem_usage" -gt 70 ]; then
    color="#ff3333"
else
    color="#ee1111"
fi

echo "{\"text\":\"  $mem_usage% $bar\", \"class\":\"memory\", \"percentage\":$mem_usage}"
