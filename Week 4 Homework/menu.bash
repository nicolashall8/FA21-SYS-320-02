#!/bin/bash

# Storyline: Menu for admin, VPN, and Security functions

function invalid_opt() {

	echo ""
        echo "Invalid option"
        echo ""
        sleep 2

}

function menu() {

	# clears the screen
	clear

	echo "[1] Admin Menu"
	echo "[2] Security Menu"
	echo "[3] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		1) admin_menu
		;;

		2) security_menu
		;;
		3) exit 0
		;;
		*)

			invalid_opt
			# Call the main menu
			menu
		;;
	esac


}

function admin_menu() {

	clear
	echo "[L]ist Running Processes"
        echo "[N]etwork Sockets"
        echo "[V]PN Menu"
	echo "[4] Exit"
        read -p "Please enter a choice above: " choice

	case "$choice" in

		L|l) ps -ef | less
		;;
		N|n) netstat -an --inet | less
		;;
		V|v) vpn_menu
		;;
		4) exit 0
		;;

		*)
			invalid_opt

		;;

	esac

admin_menu
}

function security_menu() {

	clear
        echo "[O]pen Network Sockets"
        echo "[C]heck if user besides root has UID of 0"
        echo "[L]ast 10 logged in users"
        echo "[S]ee currently logged in users"
	echo "[B]lock list menu"
	echo "[A]dmin menu"
        echo "[M]ain menu"
        echo "[E]xit"
        read -p "Please select an option: " choice

        case "$choice" in

		O|o) ss -l | less
		;;
		C|c) awk -F: '($3 == 0) {printf "%s:%s\n",$1,$3}' /etc/passwd | less
		;;
		L|l) lastlog | tail -10 | less
		;;
		S|s) w | less
		;;
		A|a) admin_menu
		;;
		B|b) block_list_menu
		;;
		M|m) menu
		;;
		E|e) exit 0
		;;
		*)
			invalid_opt
		;;
	esac

security_menu
}

function vpn_menu() {

	clear
	echo "[A]dd a peer"
	echo "[D]elete a peer"
	echo "[B]ack to admin menu"
	echo "[M]ain menu"
	echo "[E]xit"
	read -p "Please select an option: " choice

	case "$choice" in

		A|a)
			bash peer.bash
			tail -6 wg0.conf | less


		;;
		D|d) # Create a prompt for the user
			echo "What is the name of the user that you want to delete? "

			read deleteuser
	    	     # Call the manage-user.bash and pass the proper switches and argument
	             # to delete the user.
			bash manage-users.bash -d -u $deleteuser 
			less wg0.conf
		;;
		B|b) admin_menu
		;;
		M|m) menu
		;;
		E|e) exit 0
		;;
		*)
			invalid_opt
		;;

	esac

vpn_menu
}

function block_list_menu() {

    clear

    #Block list menu options
    echo "[I]Ptables"
    echo "[C]isco blocklist generator"
    echo "[D]omain URL blocklist enerator"
    echo "[W]indows blocklist generator"
    echo "[E]xit"
    read -p "Plesae enter a choice above: " choice

    case "$choice" in
        I|i) bash parse-threat.bash -i && sleep 2
        ;;
        C|c) bash parse-threat.bash -c && sleep 2
        ;;
        D|d) bash parse-threat.bash -u && sleep 2
        ;;
        W|w) bash parse-threat.bash -w && sleep 2
        ;;
        E|e) exit 0
        ;;
        *)
            invalid_opt
            # Goes back to Block List Menu
            block_list_menu
        ;;
    esac
block_list_menu
}

# Call the main menu function
menu
