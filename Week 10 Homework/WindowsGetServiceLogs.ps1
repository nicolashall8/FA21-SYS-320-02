# Storyline: Write a program that lists all registered services (where stopped or running)

# Provide a prompt that allows the user to select if they want to view all services, running or stopped services
# Check that the user-specified only 'all', 'stopped', or 'running' as a value. 
# Send the user back to the prompt if they entered an invalid value. Otherwise, print the results.
# Provide an option to 'quit' the program.

function get_services() {
    
    cls
    
    $user_choice = read-host -Prompt "What type of services do you want to view? Choices: all, running, or stopped. If you want to quit the program press 'q'"

    if ($user_choice -match 'all') {
        
        cls

        # Shows all services
        Get-WmiObject win32_service | select Name, DisplayName, State | Sort State, Name | Sort State, Name | Out-Host

        sleep 2

        read-host -Prompt "Press Enter when you are done"

        # Call function to return to main menu screen   
        get_services

    }

    if ($user_choice -match 'running') {
        
        cls

        # Shows only the running services
        Get-WmiObject win32_service -Filter "State = 'Running'" | select Name, DisplayName, State | Sort State, Name | Out-Host

        sleep 2

        read-host -Prompt "Press Enter when you are done"

        # Call function to return to main menu screen
        get_services

    }

    if ($user_choice -match 'stopped') {
        
        cls

        # Shows only the stopped services
        Get-WmiObject win32_service -Filter "State = 'Stopped'" | select Name, DisplayName, State | Sort State, Name | Out-Host

        sleep 2

        read-host -Prompt "Press Enter when you are done"

        # Call function to return to main menu screen
        get_services

    }

    if ($user_choice -match "^[qQ]$") {
        
        cls

        Write-Host "Quitting the program..."

        # Exits out of the program
        break

    }

    else {
        
        cls

        Write-Host "Invalid value. Going back to the main menu...."
        sleep 2

        # Call function to return to main menu screen
        get_services
    }

}

# Calling the main function to start the program
get_services