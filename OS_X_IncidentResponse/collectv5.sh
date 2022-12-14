#! /bin/bash

#GOAL: unveil any type of persistence the attacker might have left behind on the system.

echo "Collecting system ASEPS"
# the $IRFolder variable was assigned in our original script
ASEPS=$IRFolder/aseps
mkdir $ASEPS

ditto /System/Library/LaunchDaemons $ASEPS/systemLaunchDaemons
ditto /System/Library/LaunchAgents $ASEPS/systemLaunchAgents
ditto /Library/LaunchDaemons $ASEPS/launchDaemons
ditto /Library/LaunchAgents $ASEPS/launchAgents
#ditto <user entry>

# collect crontabs and set permissions so that the analyst can read the results
ditto /usr/lib/cron/tabs/ $ASEPS/crontabs;

# collect at tasks
ditto /private/var/at/jobs $ASEPS/atTasks

# collect plist overrides
ditto /var/db/launchd.db $ASEPS/overrides;

# collect StartupItems
ditto /etc/rc* $ASEPS/
ditto /Library/StartupItems/ $ASEPS/
ditto /System/Library/StartupItems/ $ASEPS/systemStartupItems

# collect Login/Logout Hooks
ditto /private/var/root/Library/Preferences/com.apple.loginwindow.plist
$ASEPS/loginLogouthooks

# collect launchd configs
# file may or may not exist
ditto /etc/launchd.comf $ASEPS/launchdConfs/

# copy user specific data for each user
dscl . -ls /Users | egrep -V ^_ | while read user
do
    ditto /Users/$user/Library/LaunchAgents $ASEPS/$user-launchAgents
    ditto /Users/$user/Library/Preferences/com.apple.loginitems.plist $ASEPS/$user-com.apple.loginitems.plist;
    ditto /Users/$user/.launchd.conf $ASEPS/launchdConfs/$user-launchd.conf
done

# copy kext files in the extension directories
ditto /System/Library/Extensions $ASEPS/systemExtensions
ditto /Library/Extensions $ASEPS/extensions

# create a function that will scan all files in a directory using codesign
codesignDirScan(){
    for filename in $1/*; do
        codesign -vv -d $filename &>tmp.txt;
        if grep -q "not signed" tmp.txt; then
            cat tmp.txt >> $ASEPS/unsignedKexts.txt
        fi
    done
    rm tmp.txt
}

# run a codesign scan on all kext files
# shouldn't apply to Yosemite and later as unsigned KEXTS are not supported as aseps
codesignDirScan /System/Library/Extensions
codesignDirScan /Library/Extensions
