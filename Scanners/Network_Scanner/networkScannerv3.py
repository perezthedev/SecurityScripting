import ping3
import concurrent.futures

# network scanner that checks IP addresses

ip = input("Enter the IP range to scan (e.g. 192.168.1.1-192.168.1.255): ")
start_ip, end_ip = ip.split('-')
start_ip = int(start_ip.split('.')[-1])
end_ip = int(end_ip.split('.')[-1])

def scan(host):
    response_time = ping3.ping(host)
    if response_time:
        print(host + " is alive")
    else:
        print(host + " is not alive")

# Threads
with concurrent.futures.ThreadPoolExecutor() as executor:
    for i in range(start_ip, end_ip+1):
        host = f"192.168.1.{i}"
        executor.submit(scan, host)

