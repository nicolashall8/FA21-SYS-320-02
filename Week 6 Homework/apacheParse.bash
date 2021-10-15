#!/bin/bash

# Read in file
read -p "Please enter an apache log file: " tFile

# Check if file exists
if [[ ! -f ${tFile} ]]
then
	echo "File doesn't exist."
	exit 1
fi

# Looking for web scanners.
sed -e "s/\[//g" -e "s/\"//g" ${tFile} | \
egrep -i "test|shell|echo|passwd|select|phpmyadmin|setup|admin|w00t" | \
awk ' BEGIN { format = "%-15s %-20s %-6s %-6s %-5s %s\n"
		printf format, "IP", "Date", "Method", "Status", "Size", "URI"
		printf format, "--", "----", "------", "------", "----", "---"}


{ printf format, $1, $4, $6, $9, $10, $7 }'

# Take the IPs from the log file, sort them, and put them into a separate file
awk ' { print $1 } ' ${tFile} | sort -u | tee -a apachelogIPs.txt

# Puts the bad IPs into a separate bad IP table file
for badIPs in $(cat apachelogIPs.txt)
do
	echo "iptables -A INPUT -s ${badIPs} -j DROP" | tee -a badIPSIPTables.txt
done

# Puts the bad IPs into a separate bad IP table file for windows 
for badIPs in $(cat apachelogIPs.txt)
do
	echo "netsh advfirewall firewall add rule name="BLOCK IP ADDRESS - ${badIPs}" dir=in action=block remoteip=${badIPs}" | tee -a badIPSWindows.txt
done
