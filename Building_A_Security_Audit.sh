#!/bin/sh

# --json -  -  -   -> Set output mode to 'json'
# --header -  -  - -> Toggle column headers true/false
# --list -  -  -   -> Set output mode to 'list'
# $ -  -  -  -  -  -> means variable will be input for command line
# var=$(osqueryi --json_pretty --header=FALSE --list '')
# echo $var  -  -  -> prints single line output
# echo "${var}"-> prints multiline output (includes whitespaces)

# DOCS:
# anyUpdatesAvailable pList query -> https://github.com/osquery/osquery/issues/3666

compName=$(osqueryi 'SELECT computer_name FROM system_info;')
echo "${compName}"
sysSerial=$(osqueryi 'SELECT hardware_serial FROM system_info')
echo "${sysSerial}"
sysModel=$(osqueryi 'SELECT hardware_model FROM system_info')
echo "${sysModel}"
macAddress=$(osqueryi 'SELECT mac AS MAC_address FROM interface_details')
echo "${macAddress}"
listOfUsers=$(osqueryi 'SELECT DISTINCT user AS Users FROM logged_in_users')
echo "${listOfUsers}"
usersUUID=$(osqueryi 'SELECT uuid AS UUID FROM users')
echo "${usersUUID}"
#lastLogin=$(osqueryi --json --header=FALSE --list 'SELECT * FROM last')
#echo "${lastLogin}"
#lastLogout=$(osqueryi --json --header=FALSE --list 'SELECT * FROM last')
#echo "${lastLogout}"
sipStatus=$(osqueryi 'SELECT enabled AS SIP_Status FROM sip_config WHERE config_flag="sip"')
echo "${sipStatus}"
anyUpdatesAvailable=$(osqueryi 'SELECT * FROM plist WHERE path = "/Library/Preferences/com.apple.commerce.plist" and key = "AutoUpdate"')
echo "${anyUpdatesAvailable}"
uptimeDays=$(osqueryi 'SELECT days FROM uptime')
echo "${uptimeDays}"
uptimeHours=$(osqueryi 'SELECT hours FROM uptime')
echo "${uptimeHours}"
uptimeMinutes=$(osqueryi 'SELECT minutes FROM uptime')
echo "${uptimeMinutes}"
uptimeSeconds=$(osqueryi 'SELECT seconds FROM uptime')
echo "${uptimeSeconds}"
#uptimeTotalInSeconds=$(osqueryi --json --header=FALSE --list 'SELECT total_seconds FROM uptime')
#echo "${uptimeTotalInSeconds}"
xprotectID=$(osqueryi 'SELECT name AS XProtected_Entries FROM xprotect_entries')
echo "${xprotectID}"
firewallStatus=$(osqueryi 'SELECT global_state AS Firewall_Status FROM alf')
echo "${firewallStatus}"
gateKeeper=$(osqueryi 'SELECT assessments_enabled AS Gatekeeper_Status FROM gatekeeper')
echo "${gateKeeper}"
diskEncryption=$(osqueryi 'SELECT name, encrypted FROM disk_encryption')
echo "${diskEncryption}"
usbDevices=$(osqueryi 'SELECT model AS USB_Model FROM usb_devices')
echo "${usbDevices}"
