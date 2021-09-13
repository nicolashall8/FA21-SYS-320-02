#!/bin/bash

# Storyline: Script to create a wireguard server


# Create a private key
priv="$(wg genkey)"

# Create a public key
pub="$(echo ${priv} | wg pubkey)"

# Set the addresses
address="10.254.132.0/24,172.16.28.0/24"

# Set Server IP addresses
ServerAddress="10.254.132.1/24,172.16.28.1/24"

# Set the listening port
lport="4282"

# Create the format for client configuration options
peerInfo="# ${address} 198.199.97.163:4282 ${pub} 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0"

: '
'

echo "${peerInfo}
[Interface]
Address = ${ServerAddress}
# PostUp = /etc/wireguard/wg-up.bash
# PostDown = /etc/wireguard/wg-down.bash
ListenPort = ${lport}
PrivateKey = ${priv}
" > wg0.conf
