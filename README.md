===================[Kelompok IT27]======================

Khumaidi Kharis Az-zacky     - 5027241049

Mohamad Arkan Zahir Asyafiq  - 5027241120

Abiyyu Raihan Putra Wikanto  - 5027241042

============[Laporan Resmi Penjelasan Soal]=============

#soal_1

Pada soal ini, kita diminta untuk membuat sebuah program Bash yang memproses file `reading_data.csv` menggunakan kombinasi perintah `awk`, `sort`, dan kondisi `if else`. Program ini terdiri dari beberapa logika utama sesuai instruksi soal, yaitu:

1. Langkah pertama adalah menghitung jumlah buku yang dibaca oleh Chris Hemsworth

        chris_books=$(awk -F, '$2 == "Chris Hemsworth" {count++} END {print count+0}' reading_data.csv)
           echo "Chris Hemsworth membaca $chris_books buku."

Penjelasannya: 
- Menggunakan awk dengan delimiter koma -F, untuk memisahkan kolom.
- memfilter data yang memiliki nama "Chris Hemsworth" di kolom kedua
- Menghitung jumlah baris yang cocok, lalu mencetak totalnya.

2. Langkah kedua adalah menghitung rata-rata durasi membaca untuk pembaca yang menggunakan media Tablet.

        avg_duration=$(awk -F, '$8 == "Tablet" && $6 > 0 {sum+=$6; count++} END {if (count > 0) print sum/count; else print 0}' reading_data.csv)
        echo "Rata-rata durasi membaca dengan Tablet adalah $avg_duration menit."

Penjelasannya: 
- Memfilter baris dengan media membaca "Tablet" (kolom ke-8) dan durasi baca > 0
- menjumlahkan durasi (kolom ke-6) ke variabel sum, serta menghitung jumlah data valid dengan count.
- membagi total durasi dengan jumlah pembaca untuk mendapatkan rata-rata.

3. Langkah selanjutnya adalah mencari siapa pembaca dengan rating tertinggi, sekaligus menampilkan nama pembaca dan judul buku.
   
        highest_rating=$(awk -F, 'NR > 1 && $7 >= 0 && $7 <= 10 {if ($7+0 > max+0) {max=$7; name=$2; title=$3}} END {print name, "-", title, "-", max+0}>if [ -z         "$highest_rating" ]; then
           highest_rating="Tidak ada data"
           fi
           echo "Pembaca dengan rating tertinggi: $highest_rating"
Penjelasannya:
- NR > 1 digunakan untuk melewati baris header CSV.
- Memastikan rating berada di rentang 0-10
- Menyimpan data rating tertinggi beserta nama dan judul buku
- Jika tidak ada data valid, akan menampilkan "Tidak ada data".

4. Terakhir, kita diminta mencari genre paling populer di wilayah Asia setelah tanggal 31 Desember 2023.

       popular_genre=$(awk -F, '$9 == "Asia" && $5 > "2023-12-31" {count[$4]++} END {for (genre in count) print genre, count[genre]}' reading_data.csv>
        if [ -z "$popular_genre" ]; then
           echo "Genre paling populer di Asia setelah 2023 adalah Tidak ada data"
           else
           genre_name=$(echo "$popular_genre" | awk '{print $1}')
           genre_count=$(echo "$popular_genre" | awk '{print $2}')
           echo "Genre paling populer di Asia setelah 2023 adalah $genre_name dengan $genre_count buku."
           fi
Penjelasannya: 
- Memfilter data berdasarkan wilayah Asia (kolom ke-9) dan tanggal membaca setelah 2023-12-31 (kolom ke-5).
- Menghitung frekuensi genre (kolom ke-4) dengan associative array di awk.
- Sorting hasil berdasarkan jumlah terbanyak dan mengambil genre terpopuler dengan head -n1.

#soal_2
Pada soal ini, Anda diminta untuk menambahkan folder soal_2 beserta seluruh isinya ke dalam proyek. Folder ini berisi beberapa file yang digunakan untuk:
- Memantau penggunaan CPU dan RAM pada sistem.
- Mengelola tugas-tugas crontab untuk menjalankan proses monitoring secara otomatis.
- Menyediakan antarmuka pengguna untuk interaksi dengan sistem.
  
Langkah-langkah untuk Menyelesaikan soal_2

Langkah 1: Membuat Folder soal_2 dan File-Filenya
- Buka terminal dan navigasikan ke direktori proyek Anda.

	cd ~/soal_1/Sisop-1-2025-IT27

- Buat folder soal_2 dan struktur direktori di dalamnya:

	mkdir -p soal_2/data mkdir -p soal_2/scripts mkdir -p soal_2/logs

Perintah ini akan membuat tiga folder di dalam soal_2:
data/: Untuk menyimpan file data seperti player.csv.
scripts/: Untuk menyimpan skrip yang digunakan untuk monitoring CPU, RAM, dan pengelolaan crontab.
logs/: Untuk menyimpan file log yang mencatat penggunaan CPU dan RAM.

- Buat file di dalam folder yang baru saja Anda buat:

	touch soal_2/data/player.csv touch soal_2/scripts/core_monitor.sh touch soal_2/scripts/frag_monitor.sh touch soal_2/scripts/manager.sh touch 		 
 soal_2/terminal.sh

Penjelasan tentang file-file yang akan Anda buat:

player.csv: Data CSV yang berisi informasi tentang pemain.
core_monitor.sh: Skrip untuk memantau penggunaan CPU.
frag_monitor.sh: Skrip untuk memantau penggunaan RAM.
manager.sh: Skrip untuk mengelola jadwal crontab.
terminal.sh: Skrip utama untuk menjalankan sistem dan interaksi dengan pengguna.

Langkah 2: Menambahkan Skrip untuk Monitoring CPU dan RAM

- Buka file frag_monitor.sh dan masukkan kode berikut:

	cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}') cpu_model=$(lscpu | grep "Model name" | sed 's/Model name:\s*//') log_message="[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" echo $log_message >> ./logs/core.log

Penjelasan:
top -b -n1: Menjalankan perintah top untuk mendapatkan snapshot penggunaan CPU satu kali dalam mode batch.
grep "Cpu(s)": Menyaring output untuk mendapatkan data penggunaan CPU.
sed "s/.*, *\([0-9.]*\)%* id.*/\1/": Mengambil nilai idle CPU dari output top.
awk '{print 100 - $1 "%"}': Menghitung penggunaan CPU dengan mengurangi nilai idle dari 100%.
echo "Core Usage: $cpu_usage": Menampilkan penggunaan CPU di terminal.
echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage] - Terminal Model [$(lscpu | grep 'Model name' | cut -d ':' -f2)]" >> $(pwd)/soal_2/logs/core.log: Mencatat penggunaan CPU ke dalam file core.log dengan timestamp dan model CPU.

- Buka file frag_monitor.sh dan masukkan kode berikut:

	ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}') ram_total=$(free -m | grep Mem | awk '{print $2}') ram_available=$(free -m | grep Mem | awk 		'{print $7}') log_message="[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$ram_available MB] -Details[Total:$ram_totalMB, 	Available: $ra> echo $log_message >> ./logs/fragment.log

Penjelasan:
ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}'):
Menggunakan perintah free untuk mendapatkan informasi penggunaan RAM, kemudian menghitung persentase penggunaan RAM.
ram_total=$(free -m | grep Mem | awk '{print $2}'):
Mengambil total RAM dalam megabyte dengan perintah free -m.
ram_available=$(free -m | grep Mem | awk '{print $7}'):
Mengambil RAM yang tersedia dalam megabyte.
log_message="[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$ram_available MB] - Details [Total: $ram_total MB, Available: $ram_available MB]":
Menyusun pesan log dengan format timestamp, penggunaan RAM, RAM yang tersedia, serta total dan RAM yang tersedia.
echo $log_message >> ./logs/fragment.log:
Menulis pesan log ke dalam file fragment.log di folder logs/.

- Buka file manager.sh dan masukkan kode berikut:

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

Penjelasan:
Menu berbasis teks yang memungkinkan pengguna untuk:
Menambahkan atau menghapus monitoring CPU dan RAM ke dalam crontab.
Melihat semua pekerjaan yang terjadwal dalam crontab.
Keluar dari Crontab Manager dan kembali ke menu post-login.
Perintah crontab yang digunakan:
crontab -l: Menampilkan daftar pekerjaan crontab yang ada.
crontab -: Menulis kembali perubahan yang baru.
grep -v: Menghapus entri tertentu dari crontab.
Log Monitoring: Semua aktivitas dari core_monitor.sh dan frag_monitor.sh akan tercatat di core.log dan fragment.log.

Langkah 3: Menambahkan Format Log untuk Monitoring
- Format log untuk penggunaan CPU (core.log):
Log yang dihasilkan oleh core_monitor.sh akan mencatat data dalam format berikut di logs/core.log:

	CPU[2025-03-20 23:58:36] - Core Usage [0.6%] - Terminal Model [12th Gen Intel(R) Core(TM) i5-12500H]

- Format log untuk penggunaan RAM (fragment.log):

	RAM[2025-03-20 23:58:46] - Fragment Usage [15.6066%] - Fragment Count [3246 MB] - Details [Total: 3847 MB, Available: 3246 MB]

Langkah 4: Menambahkan Terminal untuk Pengguna (terminal.sh)

- Membuat Antarmuka Pengguna: Buka file terminal.sh dan masukkan kode berikut untuk menyediakan antarmuka pengguna:

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

Penjelasan Skrip terminal.sh:
Menampilkan Menu Utama Sebelum Login:
echo "ARCAEA TERMINAL": Menampilkan judul "ARCAEA TERMINAL".
while true; do ... done: Loop tak terbatas untuk menampilkan menu utama sampai pengguna memilih opsi yang valid.
Menu Pilihan:
Opsi 1 (Register): Menjalankan skrip register.sh untuk proses registrasi pengguna.
Opsi 2 (Login): Menjalankan skrip login.sh untuk proses login pengguna. Jika login berhasil, masuk ke menu post-login.
Opsi 3 (Exit): Keluar dari program.
Post-Login Menu:
Jika login berhasil (if [[ $? -eq 0 ]]), menampilkan menu post-login dengan dua opsi:
Opsi 1 (Crontab Manager): Menjalankan manager.sh untuk mengelola pekerjaan crontab (menambah/menghapus monitoring CPU & RAM).
Opsi 2 (Exit): Keluar dari menu post-login dan kembali ke menu utama.
Handling Invalid Options:
Jika pengguna memilih opsi yang tidak valid, akan muncul pesan "Invalid option. Please try again."


#soal_3

1. Soal 3 meminta untuk membuat program bash yang dapat melakukan beberapa fitur interaktif dengan menulis ./dsotm.sh --play="NAMATRACK" lalu menggantikan NAMATRACK dengan salah satu track yaitu Speak to Me, On the Run, Time, Money, Brain Damage.
   
2. Yang pertama dilakukan adalah membuat file dsotm.sh serta menambahkan header yang akan muncul ketika memanggil fungsi

        nano dsotm.sh

   lalu masukkan

		#!/bin/bash
		
		clear
		
		header() {
		    echo -e "\e[1;36m========================================\e[0m"
		    echo -e "\e[1;33m        $1        \e[0m"
		    echo -e "\e[1;36m========================================\e[0m"
		}


4. Untuk membuat fungsi Speak to Me diperlukan fungsi yang mengutip kutipan afirmasi menggunakan API berkala-kala

		  speak_to_me() {
		  while true; do
		        clear
		        header "Speak to Me - Affirmation"
		        affirmation=$(curl -s https://www.affirmations.dev/ | jq -r '.affirmation')
		        echo -e "\e[1;32m$affirmation\e[0m"
		        sleep 3
		  done
		}

Ketika fungsi tersebut dipanggil, fungsi akan mengambil kutipan afirmasi dari https://www.affirmations.dev/ menggunakan curl lalu mengekstrak data json menggunakan jq. \e[1;32m digunakan untuk menghasilkan teks warna hijau dan sleep 1 agar loop dilakukan setiap detik.

4. Untuk fungsi On the Run yaitu membuat animasi progress bar/loading bar dengan Waktu yang beracak.

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


5. Fungsi selanjutnya, Time digunakan untuk menampilkan Waktu dan tanggal saat ini.

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

6. Fungsi Money digunakan untuk memunculkan Cmatrix dengan symbol uang

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

7. Selanjutnya, fungsi Brain Damage digunakan untuk menampilkan 10 proses yang mengambil memori tertinggi tanpa menggunakan htop

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

8. Di akhir program, fungsi akan dipanggil berdasarkan input pegguna

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

#soal_4
1. Pada soal ini kita ingin membuat program mengguanakan C++. Kita ingin membuat beberapa fitur dengan menyelami file csv (pokemon_usage.csv). Pertama kita mendownload filenya untuk dianalisis lebih dalam.

2. Untuk fitur pertama, kita ditugaskan untuk mencari data mengenai pokemon yang memiliki nilai pada kolom usage dan rawUsage tertinggi

        info(){
        usage=`awk 'BEGIN {FS=","; col1=""; col2=0} NR>2 {{sub(/%/, "", $2); if($2+0>col2) {col1=$1; col2=$2+0}}} END{print "Highest Adjusted Usage: " col1 " with " col2 "%"}'   pokemon_usage.csv`
        rawUsage=`awk 'BEGIN {FS=",";col1="";col3=0} NR>2 {if($3 > col3){col1=$1; col3=$3}} END{print "Highest Raw Usage: " col1 " with " col3 " uses"}' pokemon_usage.csv`
        
        echo "=====[The greatest attacking pokemon detected]====="
        echo "here is information about the pokemon"
        echo $usage
        echo $rawUsage
        exit 0
        }
   
3. Fitur berikutnya adalah fitur sorting secara descending berdasarkan kolom pada file.csv
   
       sorting(){
        case "$3" in
                "usage")
                head -n1 "$1" && tail -n +2 "$1" | awk 'BEGIN {FS=","; OFS=","} {sub(/%/, "", $2); print $0}' | sort -t, -nr -k2 | awk 'BEGIN {FS=","; OFS=","} {$2 = $2 "%"; print $0}'
                ;;
                "raw")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 3
                ;;
                "name")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -k 1
                ;;
                "type1")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -k 4
                ;;
                "type2")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -k 5
                ;;
                "hp")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 6
                ;;
                "atk")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 7
                ;;
                "def")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 8
                ;;
                "spatk")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 9
                ;;
                "spdef")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 10
                ;;
                "speed")
                head -n1 "$1" && tail -n +2 "$1" | sort -t, -nr -k 11
                ;;
                *)
                error
                ;;
        esac
        exit 0
        }

5. Fitur ketiga adalah fitur untuk mencari data pokemon berdasarkan nama yang diinput
   
        greping(){
        nama="$3"

        if [ -z "$nama" ]; then
                echo "Error: no file provided"
                echo "Use -h or --help for more information"

        exit 1
        fi
 
        head -n1 "$1" && tail -n +2 "$1" | awk  -v nama="$nama" 'BEGIN{FS=","} tolower($1) ~ ("^" tolower(nama)) {print}' | awk 'BEGIN {FS=","; OFS=","} {sub(/%/, "", $2); print $0}' | sort -t, -nr -k2 | awk 'BEGIN {FS=","; OFS=","} {$2 = $2 "%"; print $0}'
        exit 0
           }


6. Fitur keempat adalah fitur filter, dimana kita bisa mencari data pokemon sesuai dengan type pokemon (di file.csv terdapat 2 jenis type)

        filter(){

        fil="$3"

        if [ -z "$fil" ]; then
                echo "Error: no file provided"
                echo "Use -h or --help for more information"
        exit 1
        fi

        head -n1 "$1" && tail -n +2 "$1" | awk -v fil="$fil" 'BEGIN{FS=","} tolower($4) ~ tolower(fil) || tolower($5) ~ tolower(fil) {print}' | awk 'BEGIN {FS=","; OFS=","} {sub(/%/, "", $2); print $0}' | sort -t, -nr -k2 | awk 'BEGIN {FS=","; OFS=","} {$2 = $2 "%"; print $0}'
        exit 0
        }

7. Fitur kelima adalah error handling, di sini saya membuat 2 jenis error handling, error1() -argumen 1/file- dan error() -argument 2 dan 3-

        error1(){
            if [ -z "$1" ] || [ ! -f "$1" ]; then
                echo "Error: no file provided"
                echo "Use -h or --help for more information"
                exit 1
            fi
        }
        
        error(){
                echo "Error: no option provided"
                echo "Use -h or --help for more information"
                exit 1
        }

5. FItur terakhir adalah fitur help, dimana fitur ini menampilkan fitur-fitur tersedia yang bisa diakses oleh user.

		help(){
		cat << "logo"
		                                                                          %%%##                                                            
		                                                                        %%%#####                                                           
		                                                                       %%###**###                                                          
		                                                                     %%%##*++**###                                                         
		                                                     ## @%%         %%##*+++*#####                                                         
		               %########%%                    ########%%%####     %%###***#####      ###################                                   
		         %%%#################%           %#########*##%%#######  %@%%##########    %%############****###       %%%#####                    
		     %%######***+++++++****#####       %%%###**++++*####*+**##### %%##############%%%##*++++**##++++*###       %%%#############            
		  %%%####*+++++++++++++++++***####     %%%##***++++*###*++++**#######*+++++++***###%%##++++++*##++++*####      %%%##******####%%########   
		@@%###+++++++++++++++++++++++**###     %%%#####++++*##++++++++*###*++++*##*+++++*#####*++++++*#*+++++*###      %%%###*+++++*###%##*########
		%%%%%##+++++++++++++++***+++++**###    %%%%%%##++++**++++++++####++++*######+++*###%##*++++++***+++++*### #######%%%#*+++++**####*+++***###
		 %%%%%##++++++++++++*####%#++++*###  #####%%%##*+++++++++++#####*+++*## ##*++*####%%##++++++++*++++++*#######****####*++++++*####+++++*### 
		  %%%%%##**#*+++++++*######*+++*########**#####*+++++++++*######*+++*####+++##########+++++++++++++++*###****#*++***###+++++**##*+++++#### 
		   %%%%%#####++++++++*#%###*++*####*++*#*+++**###+++++++#########++++*#+++###*++**####*++++++++++++++###++*##++++****##*+++++*##+++++*###  
		    %%%%%%%###+++++++*#%%#*++*###*++*##++++****##*+++++++***#####*++++++++++++++++*###*+++*#++++++++###++*####***#*+**##+++++*#*++++*###   
		      %% %%%###+++++++*#*+++####*++*####++*#*+**##++++++++++++**###*++++++++++++*####+++++*#*+++*#+*##+++**#######+++*##+**++**+++++*###   
		         %%%%%#*++++++++++######+++**#######+++*##++*###*++++++**#####******#####%##*++++*###*+*##+*##+++++*****++++*##*+**++++++++*###    
		          %%%%##*++++++*###%%%#*++++******++++*##*++*#######*++++***########%%%@%%##*++++*########**##*++++++++++++*##*++#*++++++++####    
		           %%%%##++++++**##%%%##++++++++++++++###+++*##%%%%#####*++++++*##%@@  @%%######*##%%#####***##*++++++++++*##*++*#*+++++++*###     
		            %%%%##++++++*##%%%%#*+++++++++++*###*+++*###%%%%%%%####*+++*###    %%%%%%%%%%##%%%#%##*+**####*****####*++++*##++++++*###      
		            @@@%%##+++++**##%%%%##*+++++++####%#*+++*###    %%%%%%%########        %%%%%%%%%%%%%%##+++***######%%%#*++++###++++++####      
		             %@%%%##+++++*###@%%%%########%%%%%#########        %%%%%%%####                 % %%%###########@  %%####***###+++++*###       
		              @%%%##*++++**### @@%%%%%%%@@ @@%%%%%%%%@@             %%%%%%%                   %%%%%%%%%%%%### @%%%%%%######++++*###        
		               @@%%##*++++*####    @%@      @@@@                       %%                             @%%%%      %%%%%%%%##*+++*###        
		                @%%%##*#######%                                                                                       %%%#########@@@      
		                 %%%%##%%%%%%                                                                                         %%%%%%%%%###         
		                 @@%@@@                                                                                                     %%%            
		                                                                                                                                           
		                                                                                   @@%#####%@                                              
		                                                                                 @############@                                            
		                                                                                 %%############@                                           
		                                                                                @+#######%%%%###@                                          
		                                                        @@##***##%@            @@@#######%@=####@                                    @@@@  
		            @@                                        @#*****#******%@       @%#%########%@%@###@      @@@@                         @@@@@  
		           @#%@                                     @#****#++%*******#@      @%###########%%%###@      @@@@@@@@                    @%@@@@  
		      @%##@%#####%%%%@@@@@                         @%****#@@@@#*****##%       @%@%#############%         @@@%++#@                 @*+#@@   
		      @%####%#############%#%@                @%@  @#****#%%%%*******#@        @%#****###%#####@          @@@++++*@               #++*@@   
		      @%#####%##############@#%@            @@%*%#@##***#**%%#******#@@         @#%##%%#######%             @%+++++#@    @@@     @*+++%    
		      %%######@######%%%#####%%@@@@@@%#**%@ %#**#**#%****##%##*******##           @%%%%#######@ @@@           @#*+++*#*+++++++*%@#+++#     
		     @%#############%****#%***************@ @%#******@**********%#*#%#@          @#%++####%####@@#+**@@          @#++++++++++++++*++%      
		    @%#########@###%#************#%%%%#***%@@%###*****#%************#@          %##++++*%######% %++++++*%@     @*+++%##*++++++++++#       
		   @#%##########%##%#************%%%%#*****@%#####*****#*#%#*****#%%@          ##%+++++########% @*+++++++++*@  #+++#@@@#++++++#*+%+%      
		  @#%############%%##********#*%%*******#*##%##%####**%*+++*****#*****#@@    @%###++++#######%##@@*++++++++++++****#*+*+++++*++*@@#+#@     
		 @%#%#############@##***##%%%*%*#****%%%#%##%%#%+#%%#%++##++++++*#******#@  @%%##*+++#######%###% %+++++++++++###%%%%*++*%%%%##+++###@     
		 @##%###########@*%##**#**%=#@******%%%%*#*%#%%*+#+++%+++++**%***###****@      @@+++++####%######@@*++++++++#*++*%%%%*+++%%%%#++*%%%@      
		 @%##%########@%%#*****%+#%+#%%**********%%%*#++%*+++%*++++++#++# @@@@@         @++++++*#++%######@%#**+++++#*++++*#++++++#%*+++#%%@       
		  @###@####%%%%%@#*****%+*%%%%%**********#@#*##*++++*#*+++++%*+*@               @++++++++++%#######@     @@#*#++++++**++++++++++#@@@@@@@@  
		   @%##%%%#%%%%@*******#*##%%%*************#%%**##*#+++*%#*#*+*%                @*+++++++++%########@       %*%++++++*++++++++++++++++++*% 
		     @@@******#*********#@%##***********%%*#%****##+++++++****%*@                @+++++++++%########%@    @*++#%++++++++++++++++++#++++%@  
		     @%*******##*****#%*****************#@#*******%******###%****@              @#%*++++++###########@    @#+*% @*++++++++++++++++#*#@     
		     %#%%%%**%#********###%%%#####%%%%#***%******#%****#%##******@             @####%*++++%#########%##%@   @#+*%*+++++++++++++++++%       
		    @#%%%%#**%**#@%#***%#############*****##****#%      @%###****#@            ########%#**#########%#######+*%#%%+++++++++++++++++#@      
		    @**#%#***%*@%%%#***%#############***%%#%***#@         @%#####%@            @%######%@  @#######%#%#######%%%#+++++++++++++++++++%      
		    @#*******%**@%@#***%#########%%##**#%%%#@*#@            @@@               %%########%    %#####@@@%**#%%@@%@%#++++++++++++++++++#      
		    @%##*****%#**#%***#%%%%%%%@@  @##****#*#@                                %##*#+%%%@@     @######%        @@@*+++++++++++++++++++%      
		     @#######%%#******@#%#%#+%     @##****#*#                                                @######@          @#++++++++++++++++++#@      
		       @#@#%%#@@%#####  @@@@        @@%%*@#@                                                 @+#%+%%+%          @#*++******########%@      
		                @@@@                                                                          @  @@             @***@@@        @@**#%@     
		                                                                                                                @##@               @@      
		                                                                                                                                           
		logo
		
		        echo "Usage: ./pokemon_analysis.sh <file.name> [options]"
		        echo "Options:"
		        echo "  -h, --help              Display this help message"
		        echo "  -i, --info              Display the highest adjusted and raw usage" 
		        echo "  -s, --sort <method>     Sort the data by the specific column." 
		        echo "    name                  Sort by Pokemon Name" 
		        echo "    usage                 Sort by Adjusted Usage" 
		        echo "    raw                   Sort by Raw Usage" 
		        echo "    type1                 Sort by Type 1" 
		        echo "    type2                 Sort by Type 2" 
		        echo "    hp                    Sort by HP" 
		        echo "    atk                   Sort by Attack" 
		        echo "    def                   Sort by Defense" 
		        echo "    spatk                 Sort by Special Attack" 
		        echo "    spdef                 Sort by Special Defense" 
		        echo "    speed                 Sort by Speed" 
		        echo "  -g, --grep <name>       Search for a specific pokemon sorted by usage" 
		        echo "  -f, --filter <type>     Filter by type of pokemon sorted by type" 
		}


6. Untuk main, saya menggunakan switch case untuk user dalam mengakses fitur. Untuk mengakses fiturnya, input diambil dari argumen-argumen dari user. Kami juga memanggil fungsi error1 untuk error handling pada argumen pertama (file)

        error1 "$@"
        
        option="$2"
        case "$option" in 
        	--info|-i)
        	info "$@"
        	;;
        	--sort|-s)
        	sorting "$@"
        	;;
        	--filter|-f)
        	filter "$@"
        	;;
        	--help|-h)
        	help "$@"
        	;;
        	--grep|-g)
        	greping "$@"
        	;;
        	*)
        	error
        	;;
        esac
