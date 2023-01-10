#!/bin/sh

# added validity check for both formats at the end

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
  *) echo "Invalid date choice" && exit 1;;
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
  *) echo "Invalid time choice" && exit 1;;
esac

# Check if both choices are valid before executing the final command
if [ -n "$date_format" ] && [ -n "$time_format" ]; then
  date "+$date_format $time_format"
else
  echo "Both date and time choices must be valid" && exit 1
fi

