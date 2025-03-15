#!/bin/bash

# Soal 1a: Menghitung jumlah buku yang dibaca oleh Chris Hemsworth
chris_books=$(awk -F, '$2 == "Chris Hemsworth" {count++} END {print count+0}' reading_data.csv)
echo "Chris Hemsworth membaca $chris_books buku."

# Soal 1b: Menghitung rata-rata durasi membaca dengan Tablet
avg_duration=$(awk -F, '$8 == "Tablet" && $6 > 0 {sum+=$6; count++} END {if (count > 0) print sum/count; else print 0}' reading_data.csv)
echo "Rata-rata durasi membaca dengan Tablet adalah $avg_duration menit."

# Soal 1c: Mencari pembaca dengan rating tertinggi (hanya rating 0-5)
highest_rating=$(awk -F, 'NR > 1 && $7 >= 0 && $7 <= 5 {if ($7+0 > max+0) {max=$7; name=$2; title=$3}} END {print name, "-", title, "-", max+0}' reading_data.csv)
if [ -z "$highest_rating" ]; then
    highest_rating="Tidak ada data"
fi
echo "Pembaca dengan rating tertinggi: $highest_rating"

# Soal 1d: Mencari genre paling populer di Asia setelah 2023
popular_genre=$(awk -F, '$9 == "Asia" && $5 > "2023-12-31" {count[$4]++} END {for (genre in count) print genre, count[genre]}' reading_data.csv | sort -k2 -nr | head -n1)

if [ -z "$popular_genre" ]; then
    echo "Genre paling populer di Asia setelah 2023 adalah Tidak ada data"
else
    genre_name=$(echo "$popular_genre" | awk '{print $1}')
    genre_count=$(echo "$popular_genre" | awk '{print $2}')
    echo "Genre paling populer di Asia setelah 2023 adalah $genre_name dengan $genre_count buku."
fi
