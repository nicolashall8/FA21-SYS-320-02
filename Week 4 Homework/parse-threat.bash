#!/bin/bash

# Storyline: Extract IPs from emergingthreats.net and create a firewall ruleset

# Create a Firewall Ruleset
while getopts 'icwmu' OPTION ; do

        case "$OPTION" in

                i) ip_tables=$OPTION
                ;;
                c) cisco=$OPTION
                ;;
                w) windows_firewall=$OPTION
                ;;
                m) macosx=$OPTION
                ;;
                u) urls=$OPTION
                ;;
                *)
                        echo "Invalid value."
                        exit 1
                ;;
        esac
done

# Emerging Threats File
pFile="/tmp/emerging-drop.suricata.rules"

# Targeted Threats File
p2File="/tmp/targetedthreats.csv"

# Function: Checks if Emerging Threats file exists and downloads if it doesn't, also formats IP addresses
function emerging_threats(){
	if [[ -f "${pFile}" ]]
	then
		# Prompts to overwrite if neeeded
		echo " The file ${pFile} exists."
		echo -n "Would you like to download it? [y|N]"
		read to_overwrite

		if [[ "${to_overwrite}" == "N" || "${to_overwrite}" == "n" || "${to_overwrite}" == "" ]]
        	then

                	echo "Keeping emerging threats file..."

        	elif [[ "${to_overwrite}" == "y" ]]
        	then

                	echo "Downloading the file..."
			wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules

        	# If the user doesn't specify a y or N then error.
        	else

                	echo "Invalid value"
                	exit 1

        	fi

	fi

# Downloads emerging threats file if it doesn't exist
if [[ ! -f "${pFile}" ]]
then
    echo "Downloading..."
    wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules
fi

# Regex extracting IP addresses
egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.suricata.rules | sort -u > badIPs.txt
}

#Function: Checks if Targeted Threats file exists and if not it downloads it, also pulls domains out of targeted threats file 
function targeted_threats(){
        if [[ -f "${p2File}" ]]
        then
                echo " The file ${p2File} exists."
                echo -n "Would you like to download it? [y|N]"
                read to_overwrite

                if [[ "${to_overwrite}" == "N" || "${to_overwrite}" == "" || "${to_overwrite}" == "" ]]
                then

                        echo "Keeping targeted threats file..."

                elif [[ "${to_overwrite}" == "y" ]]
                then

                        echo "Downloading the file..."
                        wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -O /tmp/targetedthreats.csv

        	# If the user doesn't specify a y or N then error.
                else

                        echo "Invalid value"
                        exit 1

                fi

        fi

# Downloads the targeted threats file if it doesn't exist
if [[ ! -f "${tFile}" ]]
then
    echo "Downloading..."
    wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -O /tmp/targetedthreats.csv

fi

# Pulls domains out of targeted threats file and puts results into badURLs file
cat ${p2File} | grep '"domain"' | cut -d "," -f 2 | tr -d '""' >> badURLs.txt
}


# When -i is chosen
if [[ ${ip_tables} ]]
then

	emerging_threats
	for eachIP in $(cat badIPs.txt)
	do
		echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a  badIPs.iptables
	done
fi

# When -c is chosen
if [[ ${cisco} ]]
then
	emerging_threats
	for eachIP in $(cat badIPs.txt)
	do
        	echo "access-list deny ip any host ${eachIP}" | tee -a badIPs.cisco
	done
fi

# When -w is chosen
if [[ ${windows_firewall} ]]
then
	emerging_threats
        for eachIP in $(cat badIPs.txt)
        do
                echo "netsh advfirewall add rule name=BLOCK IP ADDRESS-${eachIP} dir=in action=block ${eachIP}" | tee -a badIPs.windows
	done
fi

# When -m is chosen
if [[ ${macosx} ]]
then

	emerging_threats
        for eachIP in $(cat badIPs.txt)
        do
                echo "block in from ${eachIP} to any" | tee -a pf.conf
	done
fi

# When -u is chosen
if [[ ${urls} ]]
then
	targeted_threats
	echo "class-map match-any BAD_URLS"
        for eachURL in $(cat badURLs.txt)
        do
                echo "match protocol http host ${eachURL}" | tee -a badurls.urls
	done
fi
