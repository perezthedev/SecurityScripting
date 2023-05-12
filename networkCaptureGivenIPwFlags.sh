#!/bin/bash

# networkCaptureGivenIPv02.sh - networkCaptureGivenIPwFlags.sh

####################################################################
# DESCRIPTION: a bash script that captures network packets 
#              for a specified IP address on a specified 
#              network interface and saves the packets to a file
#              using the -i (interface) and -t (target IP)
####################################################################

####################################################################
# The getopts command takes two main arguments: 
# the option string and the name of a variable to store the currently parsed option
#
#  option string: contains all the valid options that the script accepts
#                 Each option is represented by a single character, 
#                 optionally followed by a colon (:) to indicate that 
#                 the option requires an argument. 
#
#                 For example, "t:i:" represents two options: 
#                             -t (target IP) and -i (interface)
####################################################################

# Default settings
target_ip="10.0.0.1"
interface="en0"
filename="packet_capture.pcap"

# Process command-line flags
while getopts ":t:i:" opt; do
  case $opt in
    t)
      target_ip=$OPTARG
      ;;
    i)
      interface=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Start the packet capture and filter for the target IP
sudo tcpdump -i $interface -n host $target_ip -w $filename

# Output the location of the captured packets
echo "Packet capture saved at $filename"
