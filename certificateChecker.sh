#!/bin/bash
# DESCRIPTION: a bash script that searches through a packet capture file for SSL/TLS handshakes 
#              and checks the validity of the certificates used in those handshakes

# Set the input file name
filename="<packet_capture>.pcap"

# Search the packet capture for SSL/TLS handshakes
ssl_handshakes=$(tshark -r $filename -Y "ssl.handshake.type == 1" -T fields -e ssl.handshake.certificate)
# ################################ FLAGS ##################################
# -r option specifies the input file to use
# -Y option specifies a filter expression that searches for SSL/TLS handshakes with a type of 1 (indicating a client hello)
# -T fields option specifies that the output should be formatted as fields
# -e ssl.handshake.certificate option specifies that the output should include the certificate used in each handshake
################################################################################################

# Loop through the SSL/TLS handshakes and check the validity of the certificate
for handshake in $ssl_handshakes; do
  echo "Checking certificate: $handshake"
  openssl x509 -noout -text -in <(echo "$handshake" | openssl base64 -d) | grep "Not After"
done
################################################################################################
# use a for loop to loop through each SSL/TLS handshake found in the input file.
# For each handshake, print a message indicating it is checking the certificate, 
# and then use the openssl command to check the validity of the certificate. 
# use the -noout option to suppress normal output
# -text option to display the certificate details in human-readable form
# -in option to specify the certificate to check
# The certificate is passed to openssl by first decoding it from base64 using the openssl 
# base64 -d command, and then using process substitution (<(command)) to pass the decoded 
# certificate as input to openssl.
# The output of the openssl command is piped to the grep command to search for the "Not After" field, 
# which indicates the expiration date of the certificate.
################################################################################################