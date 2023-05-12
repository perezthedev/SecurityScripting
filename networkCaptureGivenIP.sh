#!/bin/bash
# DESCRIPTION: a bash script that captures network packets 
#              for a specified IP address on a specified 
#              network interface and saves the packets to a file

# Set the target IP
target_ip="10.0.0.1"

# Set the interface to listen on
interface="en0"

# Set the output file name
filename="packet_capture.pcap"

# Start the packet capture and filter for the target IP
sudo tcpdump -i $interface -n host $target_ip -w $filename

# Output the location of the captured packets
echo "Packet capture saved at $filename"