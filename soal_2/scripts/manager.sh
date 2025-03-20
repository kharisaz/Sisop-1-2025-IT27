#!/bin/bash

# Loop untuk terus menunjukkan menu Crontab Manager
while true; do
    echo "ARCAEA Crontab Manager"
    echo "1. Add CPU - Core Monitor to Crontab"
    echo "2. Add RAM - Fragment Monitor to Crontab"
    echo "3. Remove CPU - Core Monitor from Crontab"
    echo "4. Remove RAM - Fragment Monitor from Crontab"
    echo "5. View All Scheduled Monitoring Jobs"
    echo "6. Exit Crontab Manager"
    read -p "Enter option [1-6]: " choice

    case $choice in
        1)
            crontab -l | { cat; echo "*/5 * * * * $(pwd)/scripts/core_monitor.sh >> $(pwd)/logs/core.log"; } | crontab -
            echo "CPU - Core Monitor added to Crontab."
            ;;
        2)
            crontab -l | { cat; echo "*/5 * * * * $(pwd)/scripts/frag_monitor.sh >> $(pwd)/logs/fragment.log"; } | crontab -
            echo "RAM - Fragment Monitor added to Crontab."
            ;;
        3)
            crontab -l | grep -v "$(pwd)/scripts/core_monitor.sh" | crontab -
            echo "CPU - Core Monitor removed from Crontab."
            ;;
        4)
            crontab -l | grep -v "$(pwd)/scripts/frag_monitor.sh" | crontab -
            echo "RAM - Fragment Monitor removed from Crontab."
            ;;
        5)
            crontab -l
            ;;
        6)
            echo "Exiting Crontab Manager."
            break  # Kembali ke Post-Login Menu setelah keluar
            ;;
        *)
            echo "Invalid option. Please select a valid option [1-6]."
            ;;
    esac
done
