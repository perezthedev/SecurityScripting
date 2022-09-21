#! /bin/bash

# collect memory
# requires osxpem.zip be inside the tools directory
# requires rekall be inside the tools directory

# scenario 1 -> full memory acquisition
# scenario 2 -> collect memory strings and live memory commands
# scenario 3 -> collect only live memory commands

#scenario 1 set by default
scenario=1
memArtifacts=memory.aff4

# if going with the live memory scenario, set Rekall commands here
function runRekallCommands {
    tools/rekall/rekal -f /dev/pmem arp --output rekal_arp.txt
    tools/rekall/rekal -f /dev/pmem lsmod --output rekal_lsmod.txt
    tools/rekall/rekal -f /dev/pmem check_syscalls --output rekal_check_syscalls.txt
    tools/rekall/rekal -f /dev/pmem psxview --output rekal_psxview.txt
    tools/rekall/rekal -f /dev/pmem pstree --output rekal_pstree.txt
    tools/rekall/rekal -f /dev/pmem dead_procs --output rekal_dead_procs.txt
    tools/rekall/rekal -f /dev/pmem psaux --output rekal_psaux.txt
    tools/rekall/rekal -f /dev/pmem route --output rekal_route.txt
    tools/rekall/rekal -f /dev/pmem sessions --output rekal_sessions.txt
    tools/rekall/rekal -f /dev/pmem netstat --output rekal_netstat.txt
    # add any additional Rekall commands you want to run here
}

function collectSwap {
    # Check if swap files are encrypted and collect if they're not
    if sysctl vm.swapusage | grep -q encrypted; then
        echo "Collecting swap memory..."
        osxpmem.app/osxpmem -i /private/var/vm/sleepimage -o $memArtifcats
        osxpmem.app/osxpmem -i /private/var/vm/swapfile* -o $memArtifacts
    else
        echo "Swapfiles encrypted. Skipping..."
    fi
}

echo "Starting memory collection..."

# unzip osxpmem app to current directory
unzip tools/psxpmem.zip > /dev/null

# modify permissions on kext file so we can load it
chown -R root:wheel osxpmem.app/MacPmem.kext

# try to load next
if kextload osxpmem.app/MacPmem; then
    echo "MacPmem Kext loaded"
else
    echo "ERROR: MacPmem Kext failed to load. Can not collect memory."
fi

case $scenario in
    1)
        # scenario 1 -> full memory acquisition
        osxpmem.app/osxpmem -o $memArtifacts > /dev/null
        collectSwap
        ;;
    2)
        # scenario 2 -> collect memory strings and live memory commands
        osxpmem.app/osxpmem -o $memArtifacts > /dev/null
        osxpmem.app/osxpmem --export /dev/pmem --output memory.dmp $memArtifcats
        echo "Running strings on memory dump..."
        strings memory.dmp > memory.strings
        osxpmem.app/osxpmem -i memory.strings -o $memArtifcats

        # run Recall commands
        runRekallCommands
        ;;
    3)
        # scenario 3 -> collect only live memory commands
        runRekallCommands
        ;;
    4)
        echo "scenario 4"
        collectSwap
        ;;
esac

echo "Unloading MacPmem.kext"
kextunload osxpmem.app/MacPmem.kext