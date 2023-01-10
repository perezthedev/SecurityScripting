#!/bin/sh

# removed some redundant code
# instead of having separate variables for date_format and time_format, use a single format
# also combined all the user inputs in one single command

echo "Select a date variation:"
echo "1. DD-MM-YYYY"
echo "2. MM-DD-YY"
echo "3. MM/DD/YYYY"
echo "4. YYYY-MM-DD"
read -p "Enter your choice: " date_choice

date_formats=("%d-%m-%Y" "%m-%d-%y" "%x" "%F")
if [ "$date_choice" -lt 1 ] || [ "$date_choice" -gt ${#date_formats[@]} ]; then
  echo "Invalid date choice" && exit 1
fi

echo "Select a time variation:"
echo "1. HH:MM:SS"
echo "2. HH:MM:SS A/P M"
echo "3. epoch time"
read -p "Enter your choice: " time_choice

time_formats=("%T" "%r" "%s")
if [ "$time_choice" -lt 1 ] || [ "$time_choice" -gt ${#time_formats[@]} ]; then
  echo "Invalid time choice" && exit 1
fi

format="${date_formats[$date_choice-1]} ${time_formats[$time_choice-1]}"
date "+$format"
