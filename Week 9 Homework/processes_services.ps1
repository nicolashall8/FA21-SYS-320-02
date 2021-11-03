# Storyline: Export list of running processes and running services into two separate files

Get-Process | Select-Object ProcessName | Export-Csv -Path "C:\users\champuser\Desktop\myProcesses.csv" -NoTypeInformation

Get-Service | Select-Object ServiceName | Export-Csv -Path "C:\users\champuser\Desktop\myServices.csv" -NoTypeInformation