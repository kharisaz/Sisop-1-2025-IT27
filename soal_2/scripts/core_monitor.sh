#!/bin/bash

# Mendapatkan persentase penggunaan CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
cpu_model=$(lscpu | grep "Model name" | sed 's/Model name:\s*//')

# Format log untuk CPU
log_message="[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]"

# Tulis log ke file core.log
echo $log_message >> ./logs/core.log
