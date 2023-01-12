# network & port scanner that uses nmap utility and has ip address hardcoded
import nmap

nm = nmap.PortScanner()

network = "192.168.1."

for i in range(1, 255):
    host = network + str(i)
    nm.scan(host, '1-65000')
    for host in nm.all_hosts():
        for port in nm[host].all_tcp():
            if nm[host]['tcp'][port]['state'] == 'open':
                print(host + ":" + str(port) + " is open.")
            else:
                print(host + ":" + str(port) + " is closed.")
