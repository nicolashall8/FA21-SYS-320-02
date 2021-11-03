# Storyline: Starts and stops Windows Calculator using only the powershell script and process name

$question = Read-Host -Prompt 'Do you want to open Windows Calculator? yes or no'

if ($question -eq 'yes') {
    Start-Process win32calc.exe
    $stopcalc = Read-Host -Prompt 'The calculator has started. If you want to close it, type stop'
    if ($stopcalc = 'stop') {
    Stop-Process -Name win32calc
    }
    }