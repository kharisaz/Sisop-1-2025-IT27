===================[Kelompok IT27]======================

Khumaidi Kharis Az-zacky     - 5027241049

Mohamad Arkan Zahir Asyafiq  - 5027241120

Abiyyu Raihan Putra Wikanto  - 5027241042

============[Laporan Resmi Penjelasan Soal]=============

#soal_1
Script Bash ini memproses data dari file CSV dan menampilkan informasi terkait dengan pembacaan buku oleh berbagai individu. Fitur-fitur dalam script ini meliputi perhitungan jumlah buku yang dibaca, rata-rata durasi membaca dengan perangkat tertentu, pencarian pembaca dengan rating tertinggi, dan pencarian genre buku paling populer di Asia setelah tahun 2023.

-- awk -F, '$2 == "Chris Hemsworth" {count++} END {print count+0}' reading_data.csv:
Memeriksa kolom kedua untuk menemukan nama "Chris Hemsworth".
Menghitung jumlah baris yang sesuai, yang menunjukkan jumlah buku yang dibaca oleh Chris Hemsworth.
Menampilkan hasil berupa jumlah buku yang dibaca.

-- awk -F, '$8 == "Tablet" && $6 > 0 {sum+=$6; count++} END {if (count > 0) print sum/count; else print 0}' reading_data.csv:
Memeriksa kolom kedelapan untuk menemukan perangkat "Tablet".
Menjumlahkan durasi membaca dari kolom keenam yang lebih besar dari 0.
Menghitung rata-rata durasi membaca dengan membagi total durasi dengan jumlah pembaca yang menggunakan tablet.
Menampilkan hasil berupa rata-rata durasi membaca dengan tablet.

--awk -F, 'NR > 1 && $7 >= 0 && $7 <= 5 {if ($7+0 > max+0) {max=$7; name=$2; title=$3}} END {print name, "-", title, "-", max+0}' reading_data.csv:
Memeriksa kolom ketujuh untuk rating antara 0 hingga 5.
Menyimpan rating tertinggi dan menampilkan nama pembaca, judul buku, dan rating tertinggi.
Jika tidak ada data yang cocok, menampilkan "Tidak ada data".

--awk -F, '$9 == "Asia" && $5 > "2023-12-31" {count[$4]++} END {for (genre in count) print genre, count[genre]}' reading_data.csv:
Memeriksa kolom kesembilan untuk menemukan lokasi "Asia" dan kolom kelima untuk tanggal setelah 2023.
Menghitung frekuensi genre buku berdasarkan kolom keempat, dan menampilkan genre yang paling populer.
Jika tidak ada data yang sesuai, menampilkan "Tidak ada data".

#soal_3
Script Bash ini menampilkan berbagai fitur interaktif. Fitur-fitur berupa tampilan word of affirmation (untuk Speak to Me), progress bar (On the Run), jam real-time (Time), efek matrix dengan simbol mata uang (Money), dan Penunjuk proses (Brain Damage).

-- Speak to Me
Menampilkan word of affirmation yang diperbarui setiap detik dengan menggunakan API dari affirmations.dev.

-- On the Run
Menampilkan progress bar dengan interval acak.

-- Time
Menampilkan jam real-time yang diperbarui setiap detik, menunjukkan tanggal, jam, menit, dan detik.

-- Money
Efek matrix dengan simbol mata uang yang jatuh secara acak di terminal, menyerupai efek dari cmatrix.

-- Brain Damage
Menampilkan daftar 10 proses dengan konsumsi memori tertinggi dalam sistem, diperbarui setiap detik seperti task manager.

#soal_4

Script Bash ini menampilkan fitur-fitur berupa:

1.fungsi info, menampilkan informasi terkait pokemon dengan usage dan raw tertinggi

2.fungsi sorting, mensorting berdasarkan nama, raw, usage, hp, atk, def, spatk, spdef, dan speed. disini saya menggunakan switch case dalam programnya

3.fungsi grep, untuk mencari nama pokemon berdasarkan input.

4.fungsi filter, untuk memfilter pokemon apa saja yang sesuai dengan pencarian berdasarkan type 1 dan type 2

5.fungi error, patokan dipanggil ketika tidak sesuai dengan format

6.fungsi help, digunakan untuk mengakses semua fitur-fitur yang tersedia

7.main disini saya mengguanakn switch case sebagai awalan sebelum memprogram fitur
