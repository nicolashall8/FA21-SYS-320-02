# Use the Get-WMI cmdlet
# Get-WmiObject -Class Win32_service | select Name, PathName, ProcessId
# Get-WmiObject -list | where { $_.Name -ilike "Win32_[n-o]*" } | Sort-Object
# Get-WmiObject -Class Win32_Account | Get-Member

#Task: Grab the network adapter information using the WMI class.
# Get the IP address, default gateway, and the DNS servers.
# BONUS: Get the DHCP server.

Get-WmiObject -Class Win32_networkadapterconfiguration | select IPAddress, DefaultIPGateway, DNSServerSearchOrder, DHCPServer