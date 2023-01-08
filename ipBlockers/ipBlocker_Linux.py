############################################
# What/Purpose: Python script that blocks desired ip
#               addresses using 'os' and 'iptables' utilities
#
# -A INPUT : adds a rule to INPUT chain (rules for incoming traffic)
# -s       : specifices source IP address
# -j DROP  : drop the specified IP address
#
# run as root or with superuser privileges
# for MacOS you can install iptables via HomeBrew or use built-in pfctl utility
# references: man iptables
#             https://phoenixnap.com/kb/iptables-tutorial-linux-firewall
#             https://www.geeksforgeeks.org/iptables-command-in-linux-with-examples/
############################################

import os

ip_address = "xxx.xxx.xxx.xxx"  # IP address you want to block

# run the command to block the IP address
os.system("iptables -A INPUT -s {} -j DROP".format(ip_address))

# save the iptables rules to config file so the IP address remains blocked after a restart
os.system("iptables-save > /etc/iptables/rules.v4")
