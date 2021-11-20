# Storyline: Incident Response Toolkit - An interactive menu that does a variety of tasks

function folderCheck() {
    # Checking if the path and folder already exists

    $folder = 'C:\Users\champuser\Documents\Incident_Response_Toolkit_Data'

    if (Test-Path -Path $folder) {
        "Checking... This folder exists. Proceeding..."

    } else {
        # If the path and folder are invalid/don't exist, then creates folder

        "The path and/or folder doesn't exist"

        "Creating a folder called Incident_Response_Toolkit_Data in the Documents directory"

        New-Item -Path "C:\Users\champuser\Documents\Incident_Response_Toolkit_Data" -ItemType Directory
       
    }
}

function ensureFolder() {
     
     # Asks for user input regarding a folder path
     $global:folderPath = Read-Host -Prompt "Specify a folder path that you want to save the data from this program to: "

     # If folder is fine then program proceeds
     if (Test-Path -Path $global:folderPath) {
         "Checking... This folder exists. Proceeding..."

     # Creates the folder if needed
     } else {
         "Checking... The folder or path doesn't exist. Proceeding to create the necessary folder..."

         New-Item -Path $global:folderPath -ItemType Directory
     
     }
}

ensureFolder

function menu() {

    sleep 2

    # Menu options
    Write-Host "~ Main Menu ~ "
    Write-Host "1. List running processes and the path for each process"
    Write-Host "2. List all registered services and the path of the executable controlling the service"
    Write-Host "3. List all the TCP network sockets"
    Write-Host "4. List all the user account information"
    Write-Host "5. List all the NetworkAdapterConfiguration information"
    Write-Host "6. List execution policies"
    Write-Host "7. List hotfixes"
    Write-Host "8. List the Windows Event Logs"
    Write-Host "9. List all installed services"
    Write-Host "10. Create csv file that contains checksums of all files"
    Write-Host "11. Create .zip file of the main data folder and create checksum of the .zip file"
    Write-Host "12. Type 'q' to quit the program."
     # Ask for user input to decide menu choice
    $UserChoice = Read-Host "Choose an Option from the Menu: "

    # Menu Option #1
    if ($UserChoice -match '1'){

         Write-Host "Listing running processes and the path for each process..."
         
         $runningProcess = Get-Process | select Name, Path

         $runningProcess | Out-Host
         
         # Ask if user wants to save results to csv file         
         $choice1 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N "
          
           if ($choice1 -match "^[yY]$") {

                   # Save the results to a csv file.
                   Write-Host "Saving contents to your desired location..."
                   sleep 1
                   $runningProcess | Export-Csv -Path $readDir\processes.csv
                   Write-Host "Data has been saved in the file."
    
    }         else {
                  menu
                    }
   }
      # Menu Option #2
      if ($UserChoice -match '2') {
          Write-Host "Listing all registered services and their paths."
          
          $services = Get-WmiObject win32_service | select Name, PathName

          $services | Out-Host
          

          $choice2 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice2 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 1
                   $services | Export-Csv -Path $global:folderPath\services.csv
                   Write-Host "Data has been saved in the file."
           

}               else {
                     menu
                    }

  }
       # Menu Option 3
       if ($UserChoice -match '3') {

           Write-Host "Listing all TCP network sockets..."
           
           $tcpSockets = Get-NetTCPConnection

           $tcpSockets | Out-Host
           

           $choice3 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice3 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving contents to the Incident Response Toolkit folder on your desktop..."
                   sleep 1
                   $tcpSockets | Export-Csv -Path $global:folderPath\tcpsockets.csv
                   Write-Host "Data has been saved in the file."
           
           }       else {
                        menu
                       }
       
        }

        # Menu Option 4
        if ($UserChoice -match '4') {

           Write-Host "Listing all user account information..."
          
           $userInfo = Get-LocalUser

           $userInfo | Out-Host
          

           $choice4 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice4 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit in the Documents directory..."
                   sleep 1
                   $userInfo | Export-Csv -Path $global:folderPath\userinfo.csv
                   Write-Host "Data has been saved in the file."
           
           }        else {
                         menu
                         }
      
}

         # Menu Option 5
         if ($UserChoice -match '5') {

           Write-Host "Listing all network adapter information..."
           
           $netAdapter = Get-NetAdapter -Name *

           $netAdapter | Out-Host
           

           $choice5 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice5 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit folder in the Documents directory..."
                   sleep 1
                   $netAdapter | Export-Csv -Path $global:folderPath\netadapterinfo.csv
                   Write-Host "Data has been saved in the file."
                   
           
           }       else {
                        menu
                        }
   
        }

        # Menu Option 6
        if ($UserChoice -match '6') {
           Write-Host "Listing execution policies..."
        
           $executionPolicy = Get-ExecutionPolicy -List

           $executionPolicy | Out-Host
         

           $choice6 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice6 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit folder in the Documents directory..."
                   sleep 1
                   $executionPolicy | Export-Csv -Path $global:folderPath\executionPolicies.csv
                   Write-Host "Data has been saved in the file."
                
           
           }     else {
                    menu
                      }
        }

        # Menu Option 7
        if ($UserChoice -match '7') {

           Write-Host "Listing hotfixes for the computer..."
          
           $getHotfix = Get-Hotfix

           $getHotfix | Out-Host
          

           $choice7 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice7 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit folder in the Documents directory..."
                   sleep 1
                   $getHotfix | Export-Csv -Path $global:folderPath\hotfixes.csv
                   Write-Host "Data has been saved in the file."
                 
           
           }     else {
                     menu
                     }
      
        }

        # Menu Option 8
        if ($UserChoice -match '8') {

           Write-Host "Listing the Windows Event Logs..."
         
           $eventLog = Get-EventLog -LogName System -Newest 10

           $eventLog | Out-Host

           $choice8 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice8 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit folder in the Documents directory..."
                   sleep 1
                   $eventLog | Export-Csv -Path $global:folderPath\eventlogz.csv
                   Write-Host "Data has been saved in the file."
                  
           
           }       else {
                        menu
                        }
        }

        # Menu Option 9
        if ($UserChoice -match '9') {
           Write-Host "Listing all installed services..."
          
           $services2 = Get-WmiObject win32_service | select Name

           $services2 | Out-Host
           

           $choice9 = Read-Host -Prompt "Would you like to save the results to a .csv file? Y or N"

           if ($choice9 -match "^[yY]$") {
                   # Save the results to a csv file.
                   Write-Host "Saving results to the Incident Response Toolkit folder in the Documents directory..."
                   sleep 1
                   $services2 | Export-Csv -Path $global:folderPath\all_services.csv
                   Write-Host "Data has been saved in the file."
                  
       
           }       else {
                        menu
                        }
        
        # Menu Option 10
        if ($UserChoice -match '10') {

            $choice10 = Read-Host -Prompt "Do you want to save the checksums to a new file?"

            if ($choice10 -match "^[yY]$") {
                    # Creates checksums for each folder
                    Write-Host "Generating checksums..."

                    sleep 1

                    # Creates the checksum
                    $checkSums = Get-FileHash -Algorithm MD5 -Path (Get-ChildItem $global:folderPath\*.*)

                    # Saves/Exports to folder and file
                    $checkSums | Export-Csv -Path $global:folderPath\checksums.csv

                    Write-Host "Checksums file created"
            
            }    else {
                    menu
                    }
        }
            
     
        }

        # Menu Option 11
        if ($UserChoice -match '11') {
            
            $choice11 = Read-Host -Prompt "Would you want to create a .zip file of the folder containing the data and look for the checksum of the .zip file?"

            if ($choice11 -match "^[yY]$") {

                    $zipLocation = Read-Host -Prompt "Where would you like to save the .zip file?"

                    Write-Host "Creating the .zip file using Incident_Response_Toolkit_Data folder..."
                    
                    # Creates the zip file
                    Compress-Archive -Path $global:folderPath -DestinationPath $zipLocation\IncidentResponseToolkitData2

                    Write-Host ".Zip file created. Looking for checksum..."
                    
                    $checkSum = Read-Host -Prompt "What directory would you like the checksum file saved to?"

                    # Saves the checksum 
                    $zipCheck = Get-FileHash -path $zipLocation\IncidentResponseToolkitData2.zip
                    $zipCheck | Export-Csv -Path $checkSum\IncidentResponseZipChecksum.csv

                    Write-Host "The .zip file and checksum has been created."
            
            }       else {
                        menu
                        }

        }

        # Menu Option QUIT
        if ($UserChoice -match 'q') {
            # Quit the program
            break
            }
}
menu