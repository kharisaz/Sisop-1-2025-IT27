#!/bin/bash

PLAYER_DB="./data/player.csv"

echo "Enter your email:"
read email

echo "Enter password:"
read -s password

hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,$hashed_password$" "$PLAYER_DB"; then
    echo "Login successful!"
    exit 0
else
    echo "Invalid email or password."
    exit 1
fi
