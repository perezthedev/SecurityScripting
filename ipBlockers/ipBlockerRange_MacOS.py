import os

# Parse the IP address range
# Replace xxx.xxx.xxx.xxx and yyy.yyy.yyy.yyy with the start and end IP addresses
start, end = "xxx.xxx.xxx.xxx", "yyy.yyy.yyy.yyy"
start_octets = start.split(".")
end_octets = end.split(".")

# Iterate over the IP addresses in the range
for i in range(int(start_octets[3]), int(end_octets[3]) + 1):
    ip_address = "{}.{}.{}.{}".format(start_octets[0], start_octets[1], start_octets[2], i)
    # Block the IP address using the pfctl utility
    os.system("echo 'block in quick from {}' | sudo pfctl -ef -".format(ip_address))

# Save the firewall rules so that the IP addresses remain blocked after a restart
os.system("sudo pfctl -f /etc/pf.conf")

