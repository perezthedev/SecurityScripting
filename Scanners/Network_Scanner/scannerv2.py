# Goal: network scanner that displays hard coded address
#      ip address is alive/not alive
#
# Description: uses ping3 utility
#              using ping3 prevents needing to spawn a new process every time to execute the ping command
#              for less pings, the os utility works fine too
# Further: could be used to save to a new file and then be used with grep from another file that enters the "alive" addresses from the stored file
import ping3

for i in range(1,255):
    host = "192.168.0." + str(i)
    response_time = ping3.ping(host)
    if response_time:
        print(host + " is alive")
    else:
        print(host + " is not alive")
        
print("SCAN COMPLETE")

