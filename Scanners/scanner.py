import socket
import threading
import concurrent.futures
import colorama
from colorama import Fore
colorama.init()

# port scanner that checks ports 1 to 65535, works with hostnames AND IP addresses (IPv4)

ip = input("Enter the IP to scan: ")
print_lock = threading.Lock() # lock, provides exclusive access

# initialize a socket instance that uses ipv4 (AF_INET) & TCP (SOCK_STREAM)
def scan(ip, port):
    # socket: software object that acts as an end point establishing
    # a bidirectional network communication link between a server-side 
    # and a client-side program
    scanner = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    scanner.settimeout(3) # wait one second on closed port, then check next port

    try:
        scanner.connect((ip, port)) # function that takes a tuple
        scanner.close()
        with print_lock:
            print(Fore.BLUE + f"[{port}]" + Fore.GREEN + " Opened") # add text color
    except:
        pass # does not connect, so OK

# Threads
with concurrent.futures.ThreadPoolExecutor() as executor:
        for port in range(65536):
            executor.submit(scan, ip, port + 1) # port 0 does not exist
