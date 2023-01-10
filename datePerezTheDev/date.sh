#!/bin/sh

# script that outputs current date variations and time variations

###################
# Date Variations #
###################

# Prints: DD-MM-YYYY
date +"%v"

# Prints: MM-DD-YY
date +"%m-%d-%y"

# Prints: MM/DD/YYYY
date +"%x"

# Prints: YYYY-MM-DD
date +"%F"

###################
# Time Variations #
###################

# Prints: HH:MM:SS
date +"%T"

# Prints: HH:MM:SS A/P M
date +"%r"

# Prints: epoch time
date +%s
