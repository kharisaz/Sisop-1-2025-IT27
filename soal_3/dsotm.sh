#!/bin/bash

clear

# Fungsi untuk Speak to Me
speak_to_me() {
    while true; do
        affirmation=$(curl -s https://www.affirmations.dev/ | jq -r '.affirmation')
        printf "\e[1;32m%s\e[0m\n" "$affirmation"  
        sleep 1
    done
}

# Fungsi untuk On the Run
on_the_run() {
    total=50  # Panjang progress bar
    progress=0
    while [ $progress -le $total ]; do
        bar=$(printf "%-${total}s" "=" | sed "s/ /=/g")
        printf "[\e[1;34m%s\e[0m] %d%%\r" "${bar:0:$progress}" $((progress * 100 / total))
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')  # Interval acak 0.1 - 1s
        ((progress++))
    done
    echo ""
}

# Fungsi untuk Time
time_display() {
    while true; do
        clear
        date +"📅 %Y-%m-%d ⏰ %H:%M:%S"
        sleep 1
    done
}

# Fungsi untuk Money
money_matrix() {
    symbols=('$' '€' '£' '¥' '¢' '₹' '₩' '₿' '₣') 
    cols=$(tput cols)  
    rows=$(tput lines) 

    declare -A matrix  

    # Inisialisasi setiap kolom dengan posisi acak
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

# Fungsi untuk Brain Damage
brain_damage() {
    while true; do
        clear
        echo -e "\e[1;31m=== TASK MANAGER ===\e[0m"
        ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 10  # 10 proses konsumsi memori tertinggi
        sleep 1
    done
}

# Menjalankan fitur
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
