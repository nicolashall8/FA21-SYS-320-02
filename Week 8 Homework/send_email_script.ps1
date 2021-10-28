# Storyline: Send an email.

# Variable can have an underscore or any alphanumeric value.
# $ signifies creation of a variable


# Body of the email
$msg = "Hello there."

# Write-host prints msg variable to the screen
write-host -BackgroundColor Red -ForegroundColor white $msg

# Email From Address
$email = "nicolas.hall@mymail.champlain.edu"

# To address
$toEmail = "deployer@csi-web"

# Sending the email
Send-MailMessage -From $email -To $toEmail -Subject "A Greeting" -Body $msg -SmtpServer 192.168.6.71