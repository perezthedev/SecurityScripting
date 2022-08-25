#!/bin/bash

# --json -  -  -   -> Set output mode to 'json'
# --header -  -  - -> Toggle column headers true/false
# --list -  -  -   -> Set output mode to 'list'
# $ -  -  -  -  -  -> means variable will be input for command line
# var=$(osqueryi --json_pretty --header=FALSE --list '')
# echo $var  -  -  -> prints single line output
# echo "${var}"-> prints multiline output (includes whitespaces)

# DOCS:
# anyUpdatesAvailable pList query -> https://github.com/osquery/osquery/issues/3666

# run endpoint security audit with a large query in osquery, condensing info
# System Info: ComputerName, Serial Number, Model, MAC Address
# User Info: List of Users, Users UUID, Last Login, Last Logout
# Security Info: SIP Status, Updates Available, Uptime, Xprotect Identifier, Firewall Status, GateKeeper, Disk Encryption, USB Devices


compName=$(osqueryi 'SELECT DISTINCT computer_name, hardware_serial, hardware_model, mac FROM system_info, interface_details;')
echo "${compName}"

listOfUsers=$(osqueryi 'SELECT DISTINCT user AS Users, uuid FROM logged_in_users, users')
echo "${listOfUsers}"

#lastLogin=$(osqueryi --json --header=FALSE --list 'SELECT * FROM last')
#echo "${lastLogin}"
#lastLogout=$(osqueryi --json --header=FALSE --list 'SELECT * FROM last')
#echo "${lastLogout}"

sipStatus=$(osqueryi --json --header=false --list 'SELECT enabled AS SIP_Status FROM sip_config WHERE config_flag="sip"')
firewallStatus=$(osqueryi --header=false --list 'SELECT global_state AS Firewall_Status FROM alf')
gateKeeper=$(osqueryi --header=false --list 'SELECT assessments_enabled AS Gatekeeper_Status FROM gatekeeper')
diskEncryption=$(fdesetup status)

# make System Integrity Protection status more human readable
if [ "${sipStatus}" == 1 ]
then
    sipStatus="Enabled "
else
    sipStatus="Disabled"
fi

if [ "${firewallStatus}" == 1 ]
then
    firewallStatus="Enabled "
else
    firewallStatus="Disabled"
fi

if [ "${gateKeeper}" == 1 ]
then
    gateKeeper="Enabled "
else
    gateKeeper="Disabled"
fi

diskEncryption=$(fdesetup status)

echo "+------------+-----------------+-------------------+----------------------+"
echo "| SIP_Status | Firewall_Status | Gatekeeper_Status | Encryption_Status    |"
echo "+------------+-----------------+-------------------+----------------------+"
echo "| ${sipStatus}   | ${firewallStatus}        | ${gateKeeper}          | ${diskEncryption}"
echo "+------------+-----------------+-------------------+----------------------+"

anyUpdatesAvailable=$(osqueryi 'SELECT * FROM plist WHERE path = "/Library/Preferences/com.apple.commerce.plist" and key = "AutoUpdate"')
echo "${anyUpdatesAvailable}"
uptimeTotal=$(osqueryi 'SELECT days, hours, minutes, seconds FROM uptime')
echo "${uptimeTotal}"
#uptimeTotalInSeconds=$(osqueryi --json --header=FALSE --list 'SELECT total_seconds FROM uptime')
#echo "${uptimeTotalInSeconds}"
xprotectID=$(osqueryi 'SELECT name AS XProtected_Entries FROM xprotect_entries')
echo "${xprotectID}"

usbDevices=$(osqueryi 'SELECT model AS USB_Model FROM usb_devices')
echo "${usbDevices}"
