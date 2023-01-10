#!/bin/bash

# added regular expressions for error checking

# Prompt user for date format choice
while true; do
    echo "Select a date variation:"
    echo "1. DD-MM-YYYY"
    echo "2. MM-DD-YY"
    echo "3. MM/DD/YYYY"
    echo "4. YYYY-MM-DD"
    read -p "Enter your choice: " date_choice

    date_formats=("%d-%m-%Y" "%m-%d-%y" "%x" "%F")

    # Check if choice is a valid number
    if ! [[ "$date_choice" =~ ^[1-4]$ ]]; then
        echo "Invalid choice, please enter a number between 1 and 4"
    # Check if choice is within range of valid options
    elif [ "$date_choice" -lt 1 ] || [ "$date_choice" -gt ${#date_formats[@]} ]; then
        echo "Invalid choice, please enter a number between 1 and 4"
    else
        date_format="${date_formats[$date_choice-1]}"
        break
    fi
done

# Prompt user for time format choice
while true; do
    echo "Select a time variation:"
    echo "1. HH:MM:SS"
    echo "2. HH:MM:SS A/P M"
    echo "3. epoch time"
    read -p "Enter your choice: " time_choice

    time_formats=("%T" "%r" "%s")

    # Check if choice is a valid number
    if ! [[ "$time_choice" =~ ^[1-3]$ ]]; then
        echo "Invalid choice, please enter a number between 1 and 3"
    # Check if choice is within range of valid options
    elif [ "$time_choice" -lt 1 ] || [ "$time_choice" -gt ${#time_formats[@]} ]; then
        echo "Invalid choice, please enter a number

