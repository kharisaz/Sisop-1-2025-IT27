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

#soal_3

1. Soal 3 meminta untuk membuat program bash yang dapat melakukan beberapa fitur interaktif dengan menulis ./dsotm.sh --play="NAMATRACK" lalu menggantikan NAMATRACK dengan salah satu track yaitu Speak to Me, On the Run, Time, Money, Brain Damage.
   
2. Yang pertama dilakukan adalah membuat file dsotm.sh

        nano dsotm.sh

3. Untuk membuat fungsi Speak to Me diperlukan fungsi yang mengutip kutipan afirmasi menggunakan API berkala-kala

        speak_to_me() {
            while true; do
                affirmation=$(curl -s https://www.affirmations.dev/ | jq -r '.affirmation')
                printf "\e[1;32m%s\e[0m\n" "$affirmation"  
                sleep 1
            done
        }

Ketika fungsi tersebut dipanggil, fungsi akan mengambil kutipan afirmasi dari https://www.affirmations.dev/ menggunakan curl lalu mengekstrak data json menggunakan jq. \e[1;32m digunakan untuk menghasilkan teks warna hijau dan sleep 1 agar loop dilakukan setiap detik.

4. Untuk fungsi On the Run yaitu membuat animasi progress bar/loading bar dengan Waktu yang beracak.

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

5. Fungsi selanjutnya, Time digunakan untuk menampilkan Waktu dan tanggal saat ini.

        time_display() {
            while true; do
                clear
                date +"📅 %Y-%m-%d ⏰ %H:%M:%S"
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
                echo -e "\e[1;31m=== TASK MANAGER ===\e[0m"
                ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 10  # 10 proses konsumsi memori tertinggi
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
                head -n1 "$1" && tail -n +2 "$1" | awk 'BEGIN {FS=","; OFS=","} {sub(/%/, "", $2); print $0}' | sort -t, -nr -k2 | awk 'BEGIN {FS=","; OFS=","} {$2 = $2 "%"; >
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
			echo "  -h, --help		Display this help message"
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
