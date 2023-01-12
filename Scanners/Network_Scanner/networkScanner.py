# color coded network scanner
# checks if a range of ip addresses are online or not
import socket
import threading
import concurrent.futures
import colorama
from colorama import Fore
colorama.init()

start_ip = input("Enter the start IP address to scan: ")
end_ip = input("Enter the end IP address to scan: ")

start_ip_parts = start_ip.split(".")
end_ip_parts = end_ip.split(".")

print_lock = threading.Lock()

def ping(ip):
    try:
        socket.inet_aton(ip)
        with print_lock:
            print(Fore.BLUE + f"[{ip}]" + Fore.GREEN + " is online.")
    except socket.error:
        with print_lock:
            print(Fore.BLUE + f"[{ip}]" + Fore.RED + " is offline.")

with concurrent.futures.ThreadPoolExecutor() as executor:
    for i in range(int(start_ip_parts[3]), int(end_ip_parts[3])+1):
        ip = start_ip_parts[0]+"."+start_ip_parts[1]+"."+start_ip_parts[2]+"."+str(i)
        executor.submit(ping, ip)
