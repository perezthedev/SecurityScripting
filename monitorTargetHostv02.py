import os
import sys
import time

if len(sys.argv) < 2:
    print("Usage: python script.py <target_host>")
    sys.exit(1)

target_host = sys.argv[1]
ping_interval = 5

while True:
    response = os.system(f"ping -c 1 {target_host}")
    if response == 0:
        print(f"{target_host} is reachable")
    else:
        print(f"{target_host} is unreachable")
    time.sleep(ping_interval)
