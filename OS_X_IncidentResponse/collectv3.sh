#! /bin/bash

# creating a folder where all collected data will go

IRfolder=collection

# check script is being executed by root (EUID == 0)
if [[ $EUID -ne 0 ]]; then
	echo "Incident Response Script needs to be executed as root!"
	exit 1
fi

# reset root user cached credentials
sudo -k

# store which user executed analysis script
originalUser=`sh -c 'echo $SUDO_USER'`
echo "Collecting data as root escalated from the $originalUser account"

cat << EOF
------------------------------------------------------------------------
COLLECTING CRITICAL SYSTEM DATA. PLEASE DO NOT TURN OFF YOUR SYSTEM...
------------------------------------------------------------------------
EOF

echo "Start time-> `date`"

# will start tracing connections with dtrace below

# will collect memory below this line

# will collect volatile data using shell below

# Create a pf rule to block all network access except for access to file server over SSH
quarentineRule=/etc/activeIr.conf
echo "Writing quarentine rule to $quarentineRule"
serverIP=192.168.1.111 # ip address of server you want to stay in contact with this system
cat > $quarentineRule << EOF
block in all
block out all
pass in proto tcp from $serverIP to any port 22
pass in proto tcp from $serverIP to any port 80
pass in proto tcp from $serverIP to any port 443
EOF

#load the pfconfig rule and inform the user there is no internet access
pfctl -f $quarentineRule 2>/dev/null
pfctl -e 2>/dev/null
if [ $? -eq 0 ]; then
	echo "Quarantine Enabled. Internet access unavailable."
fi

# will collect a file listing

# will collect file artifacts

# will collect system startup artifacts and ASEPS

# will collect web browser artifcats

# create a .zip file of all the data in the current directory
# Should ALWAYS be last thing we do. Do not add code below this line.

echo "Archiving Data"
cname=`scutil --get ComputerName | tr ' ' '_' | tr -d \'`
now=`date +"_%Y-%m-%d"`
ditto -k --zlibCompressionLevel 5 -c $IRfolder $cname$now.zip


ditto: Cannot get the real path for source 'collection'
