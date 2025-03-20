#!/bin/bash

echo "ARCAEA TERMINAL"

# Menu utama sebelum login
while true; do
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    read -p "Enter option [1-3]: " choice

    case $choice in
        1)
            # Panggil skrip register.sh untuk registrasi
            ./register.sh
            ;;
        2)
            # Panggil skrip login.sh untuk login
            ./login.sh
            if [[ $? -eq 0 ]]; then
                # Jika login berhasil, tampilkan menu post-login
                while true; do
                    echo "POST-LOGIN MENU"
                    echo "1. Crontab Manager (Add/Remove CPU & Fragment Usage)"
                    echo "2. Exit Arcaea Terminal"
                    read -p "Enter option [1-2]: " post_login_choice

                    case $post_login_choice in
                        1)
                            # Panggil manager.sh untuk menambah/menghapus pekerjaan crontab
                            ./scripts/manager.sh
                            ;;
                        2)
                            # Keluar dari aplikasi dan kembali ke menu utama
                            echo "Exiting Post-Login Menu. Returning to Arcaea Terminal."
                            break
                            ;;
                        *)
                            echo "Invalid option. Please try again."
                            ;;
                    esac
                done
            else
                echo "Login failed. Please try again."
            fi
            ;;
        3)
            # Keluar dari program
            echo "Exiting Arcaea Terminal."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
done
