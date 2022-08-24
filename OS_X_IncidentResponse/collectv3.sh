#! /bin/bash

# set up variables
IRfolder=collection
systemCommands=$IRfolder/bashCalls

# create output directory card
mkdir $IRfolder
mkdir $systemCommands

# will start tracing tcp connections in the background using dtrace
#---

# collect volatile bash data
echo "Running system commands..."

# collect bash history
history > $systemCommands/history.txt

# basic system info
systemInfo=$systemCommands/sysInfo.txt
touch $systemInfo

#echo ---command name to be used---; use command; append a blank line
echo ---date--- >> $systemInfo; date >> $systemInfo; echo >> $systemInfo
echo ---hostname--- >> $systemInfo; hostname >> $systemInfo; echo >> $systemInfo
echo ---uname--- -a--- >> $systemInfo; uname -a >> $systemInfo; echo >> $systemInfo
echo ---sw_vers--- >> $systemInfo; sw_vers >> $systemInfo; echo >> $systemInfo
echo ---nvram--- >> $systemInfo; nvram >> $systemInfo; echo >> $systemInfo
echo ---uptime--- >> $systemInfo; uptime >> $systemInfo; echo >> $systemInfo
echo ---spctl --status--- >> $systemInfo; spctl --status >> $systemInfo; echo >> $systemInfo
echo ---bash --version--- >> $systemInfo; bash --version >> $systemInfo; echo >> $systemInfo

# collect who-based data
ls -la /Users > $systemCommands/ls_la_users.txt
whoami > $systemCommands/whoami.txt
who > $systemCommands/who.txt
w > $systemCommands/w.txt
last > $systemCommands/last.txt

# collect user info
userInfo=$systemCommands/userInfo.txt
echo ---Users on this system--- >> $userInfo; dscl . -ls /Users >> $userInfo; echo >> $userInfo

# for each user
# -e: look for given regex pattern
# -v: those NOT matching given patterns
# ???
dscl . -ls /Users | egrep -v ^_ | while read user
do
    echo *****%user***** >> $userInfo
    echo ---id \($user\)--- >> $userInfo; id $user >> $userInfo; echo >> $userInfo
echo ---groups \($user\)--- >> $userInfo; groups $user >> $userInfo; echo >> $userInfo
    echo ---finger \($user\) --- >> $userInfo; finger -m $user >> $userInfo; echo >> $userInfo
    echo >> $userInfo
    echo >> $userInfo
done

# Collect network-based info
netstat > $systemCommands/netstat.txt # show network status
netstat -ru > $systemCommands/netstat.txt # include routing tables & route usable???
networksetup -listallhardwareports > $systemCommands/networksetup_listallhardwarereports.txt # configuration tool for network settings in System Preferences
lsof -i > $systemCommands/lsof_i.txt # list open files
arp -a > $systemCommands/arp_a.txt # displays or deletes all of the current ARP entries
smbutil statshares -a > $systemCommands/smbutil_statshares.txt # prints the attributes of all mounted shares
security dump-trust-settings > $systemCommands/security_dump_trust_settings.txt # Display contents of trust settings
ifconfig > $systemCommands/ifconfig.txt

# collect process-based info
ps aux > $systemCommands/ps_aux.txt # displays ALL users processes
ps axo user,pid,ppid,start,command > $systemCommands/ps_axo.txt
lsof > $systemCommands/kextstat.txt

# collect driver-based info
kextstat > $systemCommands/kextstat.txt

# collect hard drive info
hardDriveInfo=$systemCommands/hardDriveInfo.txt
touch $hardDriveInfo
echo ---diskutil list--- >> $hardDriveInfo; diskutil list >> $hardDriveInfo; echo >> $hardDriveInfo
echo ---df -h--- >> $hardDriveInfo; df -h >> $hardDriveInfo; echo >> $hardDriveInfo
echo ---du -h--- >> $hardDriveInfo; du -h >> $hardDriveInfo; echo >> $hardDriveInfo

# stop tracing outgoing TCP data
#kill -9 $dtracePid

# create a .zip file of all the data in the current directory
echo "Archiving Data"
cname=`scutil --get ComputerName | tr ' ' '_' | tr -d \'`
now=`date +"_%Y-%m-%d"`
ditto -k --zlibCompressionLevel 5 -c . $cname$now.zip
