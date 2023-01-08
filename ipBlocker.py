############################################
# run as root or with superuser privileges
# -A INPUT : adds a rule to INPUT chain (rules for incoming traffic)
# -s       : specifices source IP address
# -j DROP  : drop the specified IP address
############################################

import os

ip_address = "xxx.xxx.xxx.xxx"  # IP address you want to block

# run the command to block the IP address
os.system("iptables -A INPUT -s {} -j DROP".format(ip_address))

# save the iptables rules to config file so the IP address remains blocked after a restart
os.system("iptables-save > /etc/iptables/rules.v4")
