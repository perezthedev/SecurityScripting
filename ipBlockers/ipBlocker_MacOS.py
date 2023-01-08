#    echo command: generates a command that blocks incoming traffic from the specified IP address
# the -ef - flags:  tell pfctl to load the firewall rules from standard input and to enable the firewall
#         -f flag: specifies the file to load the rules from
#
#      references: man pfctl

import os

ip_address = "xxx.xxx.xxx.xxx"  # IP address you want to block

# Block the IP address using the pfctl utility
os.system("echo 'block in quick from {}' | sudo pfctl -ef -".format(ip_address))

# Save the firewall rules so that the IP address remains blocked after a restart
os.system("sudo pfctl -f /etc/pf.conf")

