#!/bin/bash

ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
ram_total=$(free -m | grep Mem | awk '{print $2}')
ram_available=$(free -m | grep Mem | awk '{print $7}')

log_message="[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$ram_available MB] - Details [Total: $ram_total MB, Available: $ram_available MB]"

echo $log_message >> ./logs/fragment.log
