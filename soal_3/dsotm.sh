#!/bin/bash

clear

header() {
    echo -e "\e[1;36m========================================\e[0m"
    echo -e "\e[1;33m        $1        \e[0m"
    echo -e "\e[1;36m========================================\e[0m"
}

speak_to_me() {
    while true; do
        clear
        header "Speak to Me - Affirmation"
        affirmation=$(curl -s https://www.affirmations.dev/ | jq -r '.affirmation')
        echo -e "\e[1;32m$affirmation\e[0m"
        sleep 3
    done
}

on_the_run() {
    cols=$(tput cols)
    total=$((cols - 10))
    progress=0

    echo -e "\n\e[1;34mOn the Run - Loading...\e[0m"
    echo -n "["

    while [ $progress -lt $total ]; do
        printf "\e[1;34m=\e[0m"
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        ((progress++))
        percent=$(( (progress * 100) / total ))
        printf "\r[%-*s] %3d%%" "$total" "$(printf '=%.0s' $(seq 1 $progress))" "$percent"
    done

    echo -e "\n\e[1;32mLoading Complete!\e[0m"
}


time_display() {
    while true; do
        clear
        header "Time - Real Time Clock"
        echo -e "\e[1;32m⏳ Current Date and Time\e[0m"
        echo -e "\e[1;34m-----------------------------\e[0m"
        echo -e "\e[1;33m📅 Date : $(date +"%A, %d %B %Y")\e[0m"
        echo -e "\e[1;33m⏰ Time : $(date +"%H:%M:%S")\e[0m"
        echo -e "\e[1;34m-----------------------------\e[0m"
        sleep 1
    done
}

money_matrix() {
    symbols=('$' '€' '£' '¥' '¢' '₹' '₩' '₿' '₣') 
    cols=$(tput cols)  
    rows=$(tput lines) 

    declare -A matrix  

    for ((i=0; i<cols; i++)); do
        matrix[$i]=$((RANDOM % rows))
    done

    clear
    while true; do
        for ((i=0; i<cols; i++)); do
            rand_symbol=${symbols[RANDOM % ${#symbols[@]}]}  
            tput cup ${matrix[$i]} $i  
            printf "\e[1;32m%s\e[0m" "$rand_symbol" 
            ((matrix[$i]++)) 

            if ((matrix[$i] >= rows)); then
                matrix[$i]=0
            fi
        done
        sleep 0.05  
    done
}

brain_damage() {
    while true; do
        clear
        echo -e "\e[1;36m========================================\e[0m"
        echo -e "\e[1;33m        Brain Damage - Task Monitor        \e[0m"
        echo -e "\e[1;36m========================================\e[0m"
        printf "\e[1;34m%-10s │ %-20s │ %-10s │ %-10s\e[0m\n" "PID" "COMMAND" "CPU%" "MEM%"
        echo -e "\e[1;36m--------------------------------------------------------------\e[0m"
	ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 11 | tail -n 10 | awk '{printf "\033[1;33m%-10s │ %-20s │ %-10s │ %-10s\033[0m\n", $1, $2, $3, $4}'
        sleep 1
    done
}

case "$1" in
  --play="Speak to Me")
    speak_to_me
    ;;
  --play="On the Run")
    on_the_run
    ;;
  --play="Time")
    time_display
    ;;
  --play="Money")
    money_matrix
    ;;
  --play="Brain Damage")
    brain_damage
    ;;
  *)
    echo "Usage: $0 --play=\"<Track>\""
    echo "Available Tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
    ;;
esac
