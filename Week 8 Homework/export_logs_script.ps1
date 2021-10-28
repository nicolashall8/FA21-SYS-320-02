# Storyline: Review the Security Event Log

# Directory to save files:
$myDir = "C:\Users\champuser\Documents"

# List all the available Windows Event Logs
Get-EventLog -list

# Create a prompt to allow user to select the Log to view
# Read-host takes input from the user
$readLog = Read-host -Prompt "Please select a log to review from the list above."

# Create a prompt to specify what keyword in the log to search for
$messageLog = Read-host -Prompt "Please write a keyword to search for in the logs."

# Print the results for the log
Get-EventLog -LogName $readLog -Newest 40 | where {$_.Message -ilike "*$messageLog*" } | export-csv -NoTypeInformation `
-Path "$myDir\securityLogs.csv"