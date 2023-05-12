import os
import time

target_host = "example.com"
ping_interval = 5

while True:
    response = os.system(f"ping -c 1 {target_host}")
    if response == 0:
        print(f"{target_host} is reachable")
    else:
        print(f"{target_host} is unreachable")
    time.sleep(ping_interval)
