#!/bin/sh

# added a selection utility for both date and time variations
#
# also includes error checking for 'choice' variable

echo "Select a date variation:"
echo "1. DD-MM-YYYY"
echo "2. MM-DD-YY"
echo "3. MM/DD/YYYY"
echo "4. YYYY-MM-DD"
read -p "Enter your choice: " date_choice

case $date_choice in
  1) date_format="%d-%m-%Y" ;;
  2) date_format="%m-%d-%y" ;;
  3) date_format="%x" ;;
  4) date_format="%F" ;;
  *) echo "Invalid choice" && exit 1;;
esac

echo "Select a time variation:"
echo "1. HH:MM:SS"
echo "2. HH:MM:SS A/P M"
echo "3. epoch time"
read -p "Enter your choice: " time_choice

case $time_choice in
  1) time_format="%T" ;;
  2) time_format="%r" ;;
  3) time_format="%s" ;;
  *) echo "Invalid choice" && exit 1;;
esac

date "+$date_format $time_format"

