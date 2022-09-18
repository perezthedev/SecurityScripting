#! /bin/bash

# GOAL: setup an Ubuntu server with ssh enabled, curl, java,
#       MetaSploit, OSQuery, and ElasticSearch

# check for updates

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt -y autoremove

# install services (SSH, java, cURL)

# cURL
sudo apt -y install curl
sudo apt-get -y update

# java
sudo apt-get -y install default-jre
java --version

# SSH
sudo systemctl status ssh
sudo ufw allow ssh

sudo apt-get update
sudo apt-get upgrade

# setup OSQuery
export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $OSQUERY_KEY
sudo add-apt-repository -y 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
sudo apt-get -y update
sudo apt-get -y install osquery

# setup MetaSploit
# references:
# https://www.offensive-security.com/metasploit-unleashed/using-databases/
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod 755 msfinstall
sudo ./msfinstall
sudo apt-get -y update

# if error: Warning apt-key deprectaed
# sudo mv /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/

# run & initialize initial database setup
# ??? msfdb init

# setup ElasicSearch v8.4.1
# Resource: https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html

# shasum: Compares the SHA of the downloaded .tar.gz archive and the published checksum,
# which should output elasticsearch-{version}-linux-x86_64.tar.gz: OK.

# elasticsearch-8.4.1 this directory is known as $ES_HOME.
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.1-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.1-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-8.4.1-linux-x86_64.tar.gz.sha512
tar -xzf elasticsearch-8.4.1-linux-x86_64.tar.gz
cd elasticsearch-8.4.1/
