#!/bin/bash

PLAYER_DB="./data/player.csv"

validate_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

validate_password() {
    if [[ ${#1} -ge 8 && "$1" =~ [A-Z] && "$1" =~ [a-z] && "$1" =~ [0-9] ]]; then
        return 0
    else
        return 1
    fi
}

echo "Enter your email:"
read email

if ! validate_email "$email"; then
    echo "Invalid email format."
    exit 1
fi

if grep -q "^$email," "$PLAYER_DB"; then
    echo "Email already registered."
    exit 1
fi

echo "Enter your username:"
read username

echo "Enter password:"
read -s password

if ! validate_password "$password"; then
    echo "Password does not meet requirements. It must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, and one number."
    exit 1
fi

hashed_password=$(echo -n "$password" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_password" >> "$PLAYER_DB"

echo "Registration successful!"
