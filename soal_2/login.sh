#!/bin/bash

# Path to the player database
PLAYER_DB="./data/player.csv"

# Input email
echo "Enter your email:"
read email

# Input password
echo "Enter password:"
read -s password

# Hash the password with sha256sum
hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}')

# Check if email and password match
if grep -q "^$email,.*,$hashed_password$" "$PLAYER_DB"; then
    echo "Login successful!"
    exit 0
else
    echo "Invalid email or password."
    exit 1
fi
