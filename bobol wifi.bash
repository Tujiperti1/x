#!/bin/bash


############################################################################
#   CREDITS BEGIN   ########################################################
############################################################################


# WiFi Hacker v2.0
# esc0rtd3w 2019

# https://github.com/esc0rtd3w/wifi-hacker/

# Uses parts of the aircrack-ng suite, reaver, wifite, and many other tools


############################################################################
#   CREDITS END   ##########################################################
############################################################################





############################################################################
#   VERSION HISTORY BEGIN   ################################################
############################################################################

# v2.0
# - Added support for new Gnome terminal options. Tested in Kali 2018.4

# v1.9
# - Added support for Wash. Currently used for dumping scan info out to text.
# - Added "Bruteforce Hidden SSID Options" To Extras Menu and updated bruteforceHiddenSSID() Function.
# - Updated Menu Navigation to restrict from entering Extras Menu until after a wireless adapter has been selected.
# - Configured updates with new coloring, and now will only update if remote version is higher than local version.
# - Cleaned up code for doSleepMessage() Function. Now takes 3 arguments, "message", "time", and "color".
# - Updated Extras Menu. Added wpa_supplicant enable and disable options. Updated wpa_cli options.
# - Updated Reaver save session to only save a backup if current session file exists.
# - Fixed and updated Reaver output post screen that was broken in the last release version.

# v1.8
# - Cleaned up scripting and moved all global hotkey triggers to a loadMenuHotkeys Function.
# - Added a bruteforceHiddenSSID() Function to handle hidden SSID name reveals.
# - Added logging to XML file from airodump-ng when scanning Access Points for all encryption types.
# - Added automatic 10 second timeout for Update Menu to continue to main menu for attacking.
# - Fixed Update Menu. "Check For Update" and "Apply New Update" are now functional.
# - Update Menu now loads automatically after accepting license agreement.
# - Added support for parsing network adapter names for displaying when selecting adapter to use.
# - Added a check for PixieWPS attacks. If failed, will now default to normal Reaver attack.

# v1.7
# - Currently supports up to 10 wifi adapters.
# - Changed hotkey for "Manual Adapter Entry" from "M" to "C", because of conflicting with main menu hotkey
# - Added adapter check after disclaimer is agreed, so the main menu will show the correct number of adapters.
# - Updated "killCounterMax" to use "interfacesFound" value for "stopMonitorMode()" function
# - Added "checkMultipleAdapters" Function
# - Added number of interfaces displayed on stats banner.
# - Fixed "Interface Name" on stats banner.
# - Updated airodump-ng scripting for several functions.
# - Fixed PixieDust toggles. They were reversed, disable turned on and vice/versa.
# - Updated airodump-ng windows to only scan for the encryption type that is currently being targeted.

# v1.6
# - Added a "forceDisconnectWiFi" function to help fix active internet connection issues.
# - Changed the handling of "WiFi Force Disconnect". Now, after accepting the agreement, the main menu will only load if the connection status is "0". If the status is "1", meaning the WiFi is connected to an access point, the "forceDisconnectWiFi" and "checkNetworkStatus" functions are called until the connection is released. This allows for better control of correcting errors resulting in having an active network connection.
# - Added "ifconfig" and "iwconfig" output to Extras Interface Menu
# - Merged "checkForEmptyBSSID", "checkForEmptyESSID", and "checkForEmptyChannel" into "checkForEmptyCredentials" function.
# - Removed "arAttackDeAuthOnRetry" function. This was a duplicate and now uses "arAttackDeAuth" function instead.
# - Cleaned up "stopMonitorMode" function.
# - Added support for bully, used for WPS attacks.
# - Fixed issue with active network connection not force disconnecting before attacks begin.
# - Updated text for several menus.
# - Fixed (mostly) the issue with backup ZIP files overwriting old backups.

# v1.5
# - Updated code to handle new cleaning invoked backup options for "backupSessionFiles" function.
# - Added progress text for "cleanCaptureFiles", "cleanSessionFiles", and backupSessionFiles" functions.
# - Fixed "Clean Session Files" and Clean Capture Files" options from Extras Menu.
# - Now saving session files after Wifite Auto Attacks to prevent the .cap, .xor, etc files from being deleted.
# - Updated minimal number of IVs to 5000 before cracking for Wifite WEP Auto Attacks.
# - Fixed Wifite auto arguments for all encryption types.
# - Updated Misc Menu Text
# - Added "aireplay-ng" and "packetforge-ng" to dependency check.
# - Added terminal background colors and updated foreground text color selection.
# - Added a "more" option that can be typed under WEP Attack Menu. This menu has "TCP Dump", "Generate ARP Packet", "Forge ARP Request", and "Replay ARP Request" options.

# v1.4
# - Updated WPS attack to use PixieDust as a default option after 10 second timeout if no selection is made.
# - Added a manual interface name override option to "getWirelessInterfaces" function. Set manually to wlan0, wlan1, wlan2, etc. This will automatically display during normal execution and you may ignore it for defaults.
# - Added a "refresh" flag that is set to hide override text on subsequent calls to "getWirelessInterfaces" function.
# - Added "bannerSlim" function to use a "Title Only" banner for disclaimer and unreleased menus.
# - Updated text for gathering target info on all the different encryption types.
# - Updated sleep messages for WPS attacks.
# - Fixed PixieDust option not setting correctly if nothing is selected at menu choice.
# - Updated text for all banners. Changed the main title text and domain name.
# - Fixed all the killProcess functions to now kill the process until it no longer shows up under process list.
# - Added a force exit for aircrack-ng before cracking attempt. This attempts to fix the corrupt errors when scanning IVS and CAP files.
# - Fixed previous Airodump and Aireplay windows not closing when launching a new dump session for WEP Attack Menu.
# - Added "findCaptureFiles" function to list all available cap, ivs, csv, netxml files for cracking.
# - Added terminal colors to a "setTerminalColors" function.
# - Added "checkUpdate" and "getUpdate" functions to grab the newest shell script directly.
# - Updated text on stats banner. Changed "Interface Name: " to "Interface: " to allow for longer ESSID names without flooding to the next line.

# v1.3
# - Added support for AirCrack Suite v1.2+ using the new wlanXmon format instead of monX.
# - Fixed "wlanXmon" error in Kali Linux 2.x caused by new AirCrack Suite 1.2+. See "fixKaliTwoMonError" function for more info.
# - Added a function to check the Linux version running.
# - Removed Honeypot Mode from the banners. It has been relocated to the Advanced Menu.
# - Added "$interfaceName" and "$interfaceMode" variables.
# - Added interfaceName to the stats banner. This will display the current interface name (wlan0, mon0, wlan0mon, etc).
# - Added interfaceMode to the main banner. Valid Interface Modes are 0=Managed / 1=Monitor Standard / 2=Monitor New / 3=Monitor Other / 4=Unknown
# - Added "Open Interface Options" item to Extras Menu.
# - Added "Interface Up", "Interface Down", "Interface Managed", and "Interface Monitor" to Extras Menu. The Up and Down functions affect the interface ONLY for monitor mode (mon0, mon1, wlan0mon, wlan1mon, etc) currently. Please use Enable/Disable Channel Hopping to bring up/down a managed interface (i.e. wlan0, wlan1, etc).
# - Added support for all new Reaver arguments and options for Kali 2.x build.
# - Added airodump-ng WPS scanning options to now show WPS connections without using wifite to show them.
# - Removed the wifite window from being launched with standard WPS attack. Replaced by --wps flag in airodump-ng.
# - Added "fixAirmonCompat" function to send the command to kill any processes that may interfere.
# - Removed the "initAirmon" function that was inactive.
# - Added the airmon-ng conflicting process fix to Extras Menu.
# - Added "wlanXmon" interfaces for monitor mode termination. A better way of doing this will be done soon!
# - Fixed not returning to Extras Menu from "Open Interfaces Menu".
# - Added "isDebugMode" variable to show/hide certain areas that may need additional testing output. Disabled by default.
# - Fixed default WEP dump scanning channel hopping during attack.

# v1.2
# - Fixed the top text of disclaimer banner from being cut off.

# v1.1
# - Now globally enforcing disconnection from any active network upon agreement of disclaimer to resolve "Channel Hopping" issues. This must be done for all attacks to work properly.
# - Added "HoneyPot Mode" to main toolbar. The hotkey is "Z" to launch from anywhere in script. There is currently support for airbase-ng and wifi-honey.
# - Fixed "Negative One Channel Error" occuring in airodump-ng on Kali Linux 1.0.6 and higher. This is fixed globally and should work on all platforms.
# - Added "Start NetworkManager", "Stop NetworkManager", "Stop wpa_supplicant", "Stop wpa_cli", "Enable Channel Hopping", and "Disable Channel Hopping" to Extras menu.
# - Enabled the Advanced Menu. Also enabled the hotkey "A" to launch it. Future releases will contain highly configurable settings for supported apps and modules.
# - Added support for nmap and netcat, for use during post exploitation.
# - Fixed some $bssid and $essid variable errors in WEP attacks. 
# - Fixed airodump window not closing if using load session hotkey during victim info, and then returning to the post monitor mode menu.
# - Fixed a bug where the post monitor mode screen would still load if no encryption type was selected. If the encryption type is empty, it will now return to the main menu.
# - Updated on-screen instructions for using the airdump windows and other terminal windows that are opened during target/victim setup.
# - Fixed network connection not refreshing the correct status when returning to the main menu if the network status has changed while still on the menu.
# - Added a second check to verify that no active network connection is present before launching an attack.
# - Moved autoMode text towards the top of the post monitor mode initiation screen to be more easily visible to the user.
# - Added support for post-exploitation attacks after a target has been compromised.
# - Added support for "wifite". This is used for some of the newer automated attack modes as well as an alternate option to aircrack-suite if desired.
# - Added Auto Attack Mode to the main menu. This option uses wifite to scan and attack any vulnerable network.
# - Changed some text around on some items to be more clear and understandable.
# - Added Auto modes for each attack type when selected. Once an encryption type is selected, you can type "autowep, autowps, autowpa, and autowpa2 respectively to automate the attack.
# - Fixed a few $lastMenuID variables not properly set for menu navigation.
# - Added a wifite window alongside the aircrack window when selecting WPS attacks, to help decipher which targets support WPS more easily.

# v1.0
# - Activated the disclaimer when launching the script to make sure everyone knows the rules ;)
# - Added "checkRootStatus" to verify elevated privileges before launching main menu.
# - Fixed a few typos throughout the script.
# - Added Connection display to main menu. A status of "0" is disconnected and "1" is connected.
# - Added connection status check before allowing an attack mode to be selected. This prevents trying to start an attack and being locked into a channel and other abnormalities.
# - Added text display variables for connection status. They can be displayed as "None" or "Wifi", depending on if connection status is 0 or 1.

# v0.9
# - Removed the writeDCrackPy() function. This was used to write the Python script dcrack.py out to a file.

# v0.8
# - Added support for besside-ng. Used for cracking WPA/WPA2 passwords,and upload to cloud cracking,
# - Fixed the aircrack window from closing after running dictionary attack.
# - Added checkDependencies() function to check for all required files before loading main menu.
# - Fixed the Navigation Bar from not showing up on the Help menu.
# - Fixed the aircrack window from not closing when restarting WPA/WPA2 attacks.
# - Fixed Help and Advanced menus not returning to the last page when trying to go back.

# v0.7
# - Fixed WEP aircrack errors with ESSID names that have spaces in them.
# - Fixed Terminal Options not returning to previous menu properly.
# - Cleaned up some old code that is no longer being used or referenced.
# - Fixed reaver WPC files not getting copied correctly.
# - Now copies all WPC files during reaver startup, and overwrites current WPC file after reaver session ends.

# v0.6
# - Added time and date stamp to all $encryptionType.sessions log files.
# - The "Clean Capture Files" option now only removes files in the init directory, not sessions directory.
# - Fixed bug not returning back to Extras menu after selected task has been completed.
# - All created files will now be saved to the "/sessions/$encryptionType" directory by default.
# - Added getCurrentDate() and getCurrentTime() functions to use with sessions and backups.
# - Added Backup options to Extras menu. This creates a zip file with all saved sessions and capture files.
# - Added "*.kismit.csv" and "*.kismit.netxml" files to "Cleanup Capture Files" menu under Extras.
# - Changed all references from $currentTask to $lastMenuID because of menu navigation issues.
# - Added a new variable called $lastMenuID for (hopefully) proper navigation between menus.
# - Moved code for checking MAC Spoof Status into a checkSpoofStatus() function. Can now be used globally.
# - Fixed a typo in Load Session function.
# - Updated sessions save folder and organized by encryption type.
# - Added saving reaver session WPC files to default sessions folder.

# v0.5
# - Fixed WEP attack. It wasn't being properly redirected after the last v0.4 update.
# - All attack modes re-tested and seem to be working fine.
# - Added a check for empty encryption type to prevent doing certain tasks if no type has yet been selected.
# - Updated Save and Load session menu. It does not work properly from some menus. Still in testing.

# v0.4
# - Moved all initialization functions and variables to initMain(). This is only for "code cleanliness".
# - Updated aircrack and airodump redirection based on the encryption type of the attack.
# - Added "Clean Session Files" to Extras menu. Be careful with this and be sure to keep backups.
# - Fixed not being able to return to attacks menu from Save and Load session for WEP attacks.
# - Added a $currentTask variable to change dynamically depending on what function is being executed.
# - Moved aircrack windows for WPA and WPA2 attacks to external terminal windows.
# - Fixed not being able to leave aircrack window while running WPA and WPA2 attacks.

# v0.3
# - Updated WPA and WPA2 attack modes. Both are fully working and can load custom wordlists.
# - Added the ability to change terminals under Extras menu. Supports Gnome, Konsole, Xterm, and Custom.
# - Fixed blank session files being written when no encryption type has yet been selected.
# - Added a disclaimer that must be accepted before launching main menu (currently disabled).
# - Fixed both WPA and WPA2 from not writing proper values to "$capturePath/$encryptionType/$encryptionType.sessions" log file.
# - Fixed a bug in WPA/WPA2 that prevented returning to main menu or exiting from wordlist page.
# - Updated some on-screen text when deauth station is running for WEP, WPA, and WPA2.
# - Removed Auto mode from top banner, its now defaulted after choosing encryption type.

# v0.2
# - Fixed WEP and WPS (reaver) attacks. Both are fully working now!
# - Each attack type writes to its own log file now ("$capturePath/$encryptionType/$encryptionType.sessions").
# - Cleaned up some old migrated code from previous scripts.

# v0.1
# - Initial version. Combined other current wifi scripts into one.


############################################################################
#   VERSION HISTORY END   ##################################################
############################################################################





############################################################################
#   TO DO LIST BEGIN   #####################################################
############################################################################


# Extend the width of the airodump windows when opening externally
# Add change options on-the-fly for WPS and other attack modes
# Add cowpatty support for WPA/WPA2 attacks
# Set an "ok so far" temp variable to see if all dependencies are available
# Set default $serverWPA veriable to some value other than blank
# Add sniffing/wireshark support
# Add support for airbase-ng
# Create separate handshake file with an appropriate filename
# Add "create wordlist" for phone numbers and possibly others. Add option for local
# Add checks and copy files created by besside to appropriate directories
# Add convert to .hccap support for ocl-hashcat and other compatible software
# Get advanced mode working
# Get help menu working


# Post-Exploitation Attacks To Add (Probably Scrap 20160514)

# driftnet
# nmap
# wifi-honey


############################################################################
#   TO DO LIST END   #######################################################
############################################################################





############################################################################
#   INITIALIZATION OPTIONS BEGIN   #########################################
############################################################################


initMain(){

	#checkArgs

	checkLinuxVersion

	killAll
	#startNetworkManager

	getCurrentDate
	getCurrentTime
	getCurrentDateAndTime

	setDependencies
	checkDependencies

	resizeWindow

	setVariablesRequired
	setVariablesOptional
	setVariablesAdvanced

	setDefaults
	setDefaultsWEP
	setDefaultsWPA
	setDefaultsWPA2
	setDefaultsWPS

	setDefaultSession

	setTerminalColors

	# Optionally show dependencies before launch
	#showDependencies

	# Optionally Show Disclaimer Before Launch
	showDisclaimer

	# Optionally Show Unreleased Text Before Launch
	#isUnreleased

	# Load Main Menu
	menuMain

}

checkArgs(){

	case "$#" in
	
	"1")
	if [ -e $1 ];
		then
			echo "File $1 Exists"
		else
			echo "File $1 Does Not Exist"
	fi
	;;
	
	esac
}

checkLinuxVersion(){

	# Set both default Kali values to ON and if blank, Kali is not present
	isKali=1
	isKaliTwo=1

	# Get Linux Build Info
	linuxVersion=$(lsb_release -a | grep Description | cut -f2 -d":")

	# Check against the Linux Version for the presence of Kali
	kali=$(echo "$linuxVersion" | grep Kali)

	# Check against the Linux Version for the presence of Kali 2.x
	kaliTwo=$(echo "$linuxVersion" | grep Kali | grep 2.)

	# Check For Kali Linux
	case "$kali" in

		"")
		isKali=0
		;;
	esac

	# Check For Kali Linux 2.x
	# Uses Aircrack-ng v1.2 RC2+ (Monitor Mode Is Different)
	case "$kaliTwo" in

		"")
		isKaliTwo=0
		;;
	esac

	#echo "Linux Version: $linuxVersion"
	#echo ""
	#echo "Is Kali?: $isKali"
	#echo ""
	#echo "Is Kali 2.x?: $isKaliTwo"
	#read pause
}


############################################################################
#   INITIALIZATION OPTIONS END   ###########################################
############################################################################





############################################################################
#   DEPENDENCY OPTIONS BEGIN   #############################################
############################################################################


setDependencies(){

	pathAircrack="/usr/bin/aircrack-ng"
	pathAireplay="/usr/sbin/aireplay-ng"
	pathAirodump="/usr/sbin/airodump-ng"
	pathBesside="/usr/sbin/besside-ng"
	pathCut="/usr/bin/cut"
	pathDate="/bin/date"
	pathGrep="/bin/grep"
	pathHead="/usr/bin/head"
	pathLink="/usr/bin/link"
	pathMacchanger="/usr/bin/macchanger"
	pathMkdir="/bin/mkdir"
	pathPacketforge="/usr/sbin/packetforge-ng"
	pathReaver="/usr/bin/reaver"
	pathRmdir="/bin/rmdir"
	pathSed="/bin/sed"
	pathSleep="/bin/sleep"
	pathTail="/usr/bin/tail"
	pathWash="/usr/bin/wash"
	pathWget="/usr/bin/wget"

}


checkDependencies(){

	#tempCounter=0
	#numberOfDependencies=0
	
	#tempPath=""
	#tempStatus=""

	# If counter is less than max dependencies, then build statuses
	#if [ $tempCounter -lt $numberOfDependencies ];
	#	then
	#		# Set Path Name
	#		if [ -f $tempPath ];
	#			then
	#				# Set Status As Available
	#				$tempStatus="OK"
	#			else
	#				# Set Status As Unavailable
	#				$tempStatus="NA"
	#		fi
	#	else
	#		#echo "Done With Dependencies"
	#		#read pause
	#fi
	
	if [ -f $pathAircrack ];
		then
		   statusPathAircrack="OK"
		else
		   statusPathAircrack="NA"
	fi

	if [ -f $pathAirodump ];
		then
		   statusPathAirodump="OK"
		else
		   statusPathAirodump="NA"
	fi

	if [ -f $pathAireplay ];
		then
		   statusPathAireplay="OK"
		else
		   statusPathAireplay="NA"
	fi

	if [ -f $pathBesside ];
		then
		   statusPathBesside="OK"
		else
		   statusPathBesside="NA"
	fi

	if [ -f $pathCut ];
		then
		   statusPathCut="OK"
		else
		   statusPathCut="NA"
	fi

	if [ -f $pathDate ];
		then
		   statusPathDate="OK"
		else
		   statusPathDate="NA"
	fi

	if [ -f $pathGrep ];
		then
		   statusPathGrep="OK"
		else
		   statusPathGrep="NA"
	fi

	if [ -f $pathHead ];
		then
		   statusPathHead="OK"
		else
		   statusPathHead="NA"
	fi

	if [ -f $pathLink ];
		then
		   statusPathLink="OK"
		else
		   statusPathLink="NA"
	fi

	if [ -f $pathMacchanger ];
		then
		   statusPathMacchanger="OK"
		else
		   statusPathMacchanger="NA"
	fi

	if [ -f $pathMkdir ];
		then
		   statusPathMkdir="OK"
		else
		   statusPathMkdir="NA"
	fi

	if [ -f $pathPacketforge ];
		then
		   statusPathPacketforge="OK"
		else
		   statusPathPacketforge="NA"
	fi

	if [ -f $pathReaver ];
		then
		   statusPathReaver="OK"
		else
		   statusPathReaver="NA"
	fi

	if [ -f $pathRmdir ];
		then
		   statusPathRmdir="OK"
		else
		   statusPathRmdir="NA"
	fi

	if [ -f $pathSed ];
		then
		   statusPathSed="OK"
		else
		   statusPathSed="NA"
	fi

	if [ -f $pathSleep ];
		then
		   statusPathSleep="OK"
		else
		   statusPathSleep="NA"
	fi

	if [ -f $pathTail ];
		then
		   statusPathTail="OK"
		else
		   statusPathTail="NA"
	fi

	if [ -f $pathWash ];
		then
		   statusPathWash="OK"
		else
		   statusPathWash="NA"
	fi

	if [ -f $pathWget ];
		then
		   statusPathWget="OK"
		else
		   statusPathWget="NA"
	fi

}


downloadDependencies(){

	blank=""

}


showDependencies(){

	banner
	bannerStats

	echo ""
	echo "List of File Dependencies Needed"
	echo ""
	echo "$pathAircrack - Status: $statusPathAircrack"
	echo "$pathAireplay - Status: $statusPathAireplay"
	echo "$pathAirodump - Status: $statusPathAirodump"
	echo "$pathBesside - Status: $statusPathBesside"
	echo "$pathCut - Status: $statusPathCut"
	echo "$pathDate - Status: $statusPathDate"
	echo "$pathGrep - Status: $statusPathGrep"
	echo "$pathHead - Status: $statusPathHead"
	echo "$pathLink - Status: $statusPathLink"
	echo "$pathMacchanger - Status: $statusPathMacchanger"
	echo "$pathMkdir - Status: $statusPathMkdir"
	echo "$pathPacketforge - Status: $statusPathPacketforge"
	echo "$pathReaver - Status: $statusPathReaver"
	echo "$pathRmdir - Status: $statusPathRmdir"
	echo "$pathSed - Status: $statusPathSed"
	echo "$pathSleep - Status: $statusPathSleep"
	echo "$pathTail - Status: $statusPathTail"
	echo "$pathWash - Status: $statusPathWash"
	echo "$pathWget - Status: $statusPathWget"
	echo ""
	echo ""

	echo "Press ENTER to continue...."

	read pause

}


############################################################################
#   DEPENDENCY OPTIONS END   ###############################################
############################################################################





############################################################################
#   TERMINAL OPTIONS BEGIN   ###############################################
############################################################################


setWindowTitle(){

	currentTask="setWindowTitle"

	title='echo -ne "\033]0;WiFi Hacker v2.0\007"'

	$title

}


resizeWindow(){

	currentTask="resizeWindow"

	printf '\033[8;32;115t'

}


setTerminalColors(){

	currentTask="setTerminalColors"

	# Foreground Colors
	defaultFG=$(echo 'printf' '\033[39m')
	
	black=$(echo 'printf' '\033[30m')
	blue=$(echo 'printf' '\033[34m')
	cyan=$(echo 'printf' '\033[36m')
	darkGrey=$(echo 'printf' '\033[90m')
	green=$(echo 'printf' '\033[32m')
	lightBlue=$(echo 'printf' '\033[94m')
	lightCyan=$(echo 'printf' '\033[96m')
	lightGreen=$(echo 'printf' '\033[92m')
	lightGrey=$(echo 'printf' '\033[37m')
	lightMagenta=$(echo 'printf' '\033[95m')
	lightRed=$(echo 'printf' '\033[91m')
	lightYellow=$(echo 'printf' '\033[93m')
	magenta=$(echo 'printf' '\033[35m')
	red=$(echo 'printf' '\033[31m')
	white=$(echo 'printf' '\033[0m')
	whiteAlt=$(echo 'printf' '\033[97m')
	yellow=$(echo 'printf' '\033[33m')
	
	# Background Colors
	defaultBG=$(echo 'printf' '\033[49m')
	
	blackBG=$(echo 'printf' '\033[40m')
	blueBG=$(echo 'printf' '\033[44m')
	cyanBG=$(echo 'printf' '\033[46m')
	darkGreyBG=$(echo 'printf' '\033[100m')
	greenBG=$(echo 'printf' '\033[42m')
	lightBlueBG=$(echo 'printf' '\033[104m')
	lightCyanBG=$(echo 'printf' '\033[106m')
	lightGreenBG=$(echo 'printf' '\033[102m')
	lightGreyBG=$(echo 'printf' '\033[47m')
	lightMagentaBG=$(echo 'printf' '\033[105m')
	lightRedBG=$(echo 'printf' '\033[101m')
	lightYellowBG=$(echo 'printf' '\033[103m')
	magentaBG=$(echo 'printf' '\033[45m')
	redBG=$(echo 'printf' '\033[41m')
	whiteBG=$(echo 'printf' '\033[107m')
	yellowBG=$(echo 'printf' '\033[43m')

}


setTerminalTextEffects(){

	currentTask="setTerminalTextEffects"

	textBlink=$(echo -e "\e[5m")
	textBold=$(echo -e "\e[1m")
	textDim=$(echo -e "\e[2m")
	textHidden=$(echo -e "\e[8m")
	textInverted=$(echo -e "\e[7m")
	textUnderline=$(echo -e "\e[4m")

}


############################################################################
#   TERMINAL OPTIONS END   #################################################
############################################################################





############################################################################
#   DEFAULT VARIABLES BEGIN   ##############################################
############################################################################


setVariablesRequired(){

	currentTask="setVariablesRequired"

	versionBase="2.0"
	versionBaseClean="00"

	initPath="$PWD"

	isDebugMode="0"
	isDevBuild="0"

	# Update Stuff
	versionRemote="0.0"
	versionRemoteClean="00"
	versionRemoteTemp="0.0"
	newUpdateAvailable="0"
	updateMaster=https://raw.githubusercontent.com/esc0rtd3w/wifi-hacker/master/wifi-hacker.sh
	updateTemp="/tmp/update-check.tmp"
	updateChecked="0"
	skipUpdate="0"
	returnToUpdatePage="0"

	# Setting default update downloaded script value
	newVersionScript="0.0"
	
	# Check Gnome version for terminal options (added 20190205)
	gnomeVer=$(gnome-terminal --version | grep "3.")

	case "$gnomeVer" in
	
		# Kali 2018.4 GNOME Terminal 3.30.0 using VTE 0.54.1 +GNUTLS
		"")
		gnomeOptions="legacy"
		terminal="gnome-terminal -x"
		terminalGnome="gnome-terminal -x"
		terminalGnomeLegacy="gnome-terminal -x"
		;;

		*)
		gnomeOptions="new"
		terminal="gnome-terminal --window --geometry=132x24 --"
		terminalGnome="gnome-terminal --window --geometry=132x24 --"
		terminalGnomeLegacy="gnome-terminal -x"
		;;

	esac

	#echo "gnomeOptions: $gnomeOptions"
	#read pause

	terminalKonsole="konsole -e"
	terminalXterm="xterm -e"

	bin=""
	
}


setVariablesOptional(){

	currentTask="setVariablesOptional"

	blank=""

}


setVariablesAdvanced(){

	currentTask="setVariablesAdvanced"

	blank=""

}


setDefaults(){

	currentTask="setDefaults"
	startMonitorMode="airmon-ng start"
	stopMonitorMode="airmon-ng stop"

	getRandomMacAddress=""
	spoofStatus="0"
	resetSpoofStatus="0"

	encryptionType="empty"
	encryptionTypeText="Empty"

	ipStatus="0"

	interface="wlan0"
	#interfaceMonitor="mon0"
	interfaceMonitor="wlan0mon"
	interfaceName="wlan0"
	interfaceMode="0"
	interfaceNumber="0"
	interfaceNumberMax="99"
	interfacesFound="0"
	bssid=""
	essid=""
	channel=""

	noChannel="0"

	# This is used to return from backupCaptureFiles if invoked from backupCaptureFiles
	backupFromCaptureErase="0"

	# This is used to return from backupSessionFiles if invoked from backupSessionFiles
	backupFromSessionErase="0"

	
	# Default Attack Methods
	attackMethodWEP=""
	attackMethodWPS="reaver"
	attackMethodWPA=""
	attackMethodWPA2=""


	#Find Network Adapter Commands
	showAdapterPciAll=$(lspci | egrep -i 'network|ethernet')
	showAdapterUsbAll=$(lsusb | egrep -i '')
	showAdapterUsbAtheros=$(lsusb | egrep -i 'atheros|0cf3')

	# Atheros WiFi Adapters
	showAdapterUsbAtherosAR9271=$(lsusb | egrep -i 'AR9271' | cut -d ":" -f3)

	# Intel WiFi Adapters
	showAdapterUsbIntel6205=$(lspci | egrep -i 'Intel Corporation Centrino Advanced-N 6205' | cut -d ":" -f3)

	# Support For 10 Adapter Names
	adapterNameDefault="No Adapter Name Available"
	showAdapterOneName="$adapterNameDefault"
	showAdapterTwoName="$adapterNameDefault"
	showAdapterThreeName="$adapterNameDefault"
	showAdapterFourName="$adapterNameDefault"
	showAdapterFiveName="$adapterNameDefault"
	showAdapterSixName="$adapterNameDefault"
	showAdapterSevenName="$adapterNameDefault"
	showAdapterEightName="$adapterNameDefault"
	showAdapterNineName="$adapterNameDefault"
	showAdapterTenName="$adapterNameDefault"
	
	# Default Capture Lists Values
	listCap=0
	listIvs=0
	listXor=0
	listCsv=0
	listNetXml=0

	hotkeyInput=""

	apListType=""

	# Default Session Values
	sessionID="0"

	capturePath=$(echo "$PWD/sessions")
	capturePathWEP=$(echo "$PWD/sessions/wep")
	capturePathWPS=$(echo "$PWD/sessions/wps")
	capturePathWPA=$(echo "$PWD/sessions/wpa")
	capturePathWPA2=$(echo "$PWD/sessions/wpa2")

	# Default Current Directory Temp Path
	whTemp=$(echo "$PWD/temp")

	defaultScanOutputIVS="$initPath/apScan-01.ivs"
	defaultScanOutputXML="$initPath/apScan-01.kismet.netxml"
	defaultScanOutputTXT="$initPath/apScan-01.txt"

}


setDefaultsWEP(){

	currentTask="setDefaultsWEP"

	# aircrack-ng cracking mode WEP
	acMode="1"

	# aircrack-ng cracking mode WEP (WPA-PSK)
	#acMode="2"

	washFile="$whTemp/wash.txt"
	washChannel="1"

}


setDefaultsWPA(){

	currentTask="setDefaultsWPA"

	wordlist="/usr/share/wordlists/metasploit/password.lst"

	retryDeauth="0"

	serverWPA=""

}


setDefaultsWPA2(){

	currentTask="setDefaultsWPA2"

}


setDefaultsWPS(){

	currentTask="setDefaultsWPS"

	reaver="reaver"

	reaverSessionPath="etc/reaver"
	bssidCharOnly=""

	reaverInterfaceInput=""
	reaverBSSIDInput=""

	reaverChannelInput=""
	reaverESSIDInput=""
	reaverExecInput=""
	reaverMACInput=""
	reaverOutfileInput=""
	reaverSessionInput=""

	reaverDelayInput=""
	reaverFailWaitInput=""
	reaverM57TimeoutInput=""
	reaverMaxAttemptsInput=""
	reaverPinInput=""
	reaverTimeoutInput=""

	reaverDelay="--delay="
	reaverDHSmall="--dh-small"
	reaverEAPTerminate="--eap-terminate"
	reaverFailWait="--fail-wait="
	reaverIgnoreLocks="--ignore-locks"
	reaverM57Timeout="--m57-timeout="
	reaverMaxAttempts="--max-attempts="
	reaverNack="--nack"
	reaverNoAssociate="--no-associate"
	reaverNoNacks="--no-nacks"
	reaverPin="--pin="
	reaverRecurringDelay="--recurring-delay"
	reaverTimeout="--timeout="
	reaverWin7False="--win7"

	reaver5ghz="--5ghz"
	reaverAuto="--auto"
	reaverChannel="--channel="
	reaverDaemonize="--daemonize"
	reaverESSID="--essid="
	reaverExec="--exec="
	reaverFixed="--fixed"
	reaverHelp="--help"
	reaverMAC="--mac="
	reaverOutfile="--out-file="
	reaverQuiet="--quiet"
	reaverSession="--session="
	reaverVerbose="-v"
	reaverVerboseMore="-vv"

	# Updated Options
	reaverDaemonize="-D"
	reaverExhaustive="-X"
	reaverNoAutoPass="-Z"
	reaverP1Index="-1"
	reaverP2Index="-2"
	reaverPixie="-K"
	reaverPixieLoop="-P"
	reaverGeneratePin="-W"

	reaverCurrentSessionFile=""

	# -K Argument Number (Default 1)
	pixieNumber="1"

	# Check to see if Pixie Attack Failed
	pixieFailed="0"


	wifite="wifite"
	wifiteAttackAll="wifite --all"
	wifiteAttackWEP="wifite --all --wep"
	wifiteAttackWPA="wifite --all --wpa"
	wifiteAttackWPA2="wifite --all --wpa"
	wifiteAttackWPS="wifite --all --wps"

	# Bully Options
	#bully <options> interface
	
}


############################################################################
#   DEFAULT VARIABLES END   ################################################
############################################################################





############################################################################
#   DISCLAIMER BEGIN   #####################################################
############################################################################


showDisclaimer(){

	currentTask="showDisclaimer"
	lastMenuID="showDisclaimer"

	sessionCreatePaths
	sessionRemoveEmpty

	bannerSlim

	$cyan
	echo ""
	echo "****************************************************************************************************"
	echo "THIS WILL TERMINATE ANY ACTIVE INTERNET CONNECTION! IF YOU HAVE ISSUES CONNECTING TO THE INTERNET"
	echo "AFTER AN ATTACK HAS BEEN PERFORMED, USE THE EXTRAS OPTION IN TOOLBAR TO START AND STOP SERVICES."
	echo "IF THIS DOES NOT WORK, THEN YOU CAN RESTART THIS SCRIPT, OR REBOOT THE MACHINE AND RETURN TO NORMAL."
	echo "****************************************************************************************************"
	echo ""
	$green
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	$white
	echo ""
	echo "By using this script, you are agreeing to the following terms:"
	echo ""
	echo "1) Not to be used for attacking access points that you do not have permission to test"
	echo ""
	echo "2) Stay within legal limits of transmission power, depending on your country laws"
	echo ""
	echo "3) Stay within legal limits of channel usage, depending on your country laws"
	echo ""
	$green
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	$white
	echo ""
	echo ""
	echo ""
	echo "PLEASE PRESS "\""Y"\"" AND ENTER TO ACCEPT AND CONTINUE"
	echo ""

	read agreeToDisclaimer

	case "$agreeToDisclaimer" in

		"")
		bannerExit
		;;

		"Y" | "y")
		checkForUpdates
		fixNegativeOneChannelError
		#initAirmon
		fixAirmonCompat
		#startNetworkManager
		#killNetworkManager
		#wpaSupplicantKill
		#initMonitorMode
		#stopMonitorMode
		#checkMultipleAdapters
		menuMain
		;;

		*)
		bannerExit
		;;

	esac

}


isUnreleased(){

	currentTask="isUnreleased"
	lastMenuID="isUnreleased"

	sessionCreatePaths
	sessionRemoveEmpty

	bannerSlim

	$cyan
	echo ""
	echo "****************************************************************************************************"
	echo "THIS WILL TERMINATE ANY ACTIVE INTERNET CONNECTION! IF YOU HAVE ISSUES CONNECTING TO THE INTERNET"
	echo "AFTER AN ATTACK HAS BEEN PERFORMED, USE THE EXTRAS OPTION IN TOOLBAR TO START AND STOP SERVICES."
	echo "IF THIS DOES NOT WORK, THEN YOU CAN RESTART THIS SCRIPT, OR REBOOT THE MACHINE AND RETURN TO NORMAL."
	echo "****************************************************************************************************"
	echo ""
	$green
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	echo ""
	$yellow
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo "***THIS IS UNRELEASED AND SHOULD BE CONSIDERED A TEST VERSION***"
	echo ""
	$green
	echo "**********************************************************"
	echo "YOU MUST AGREE TO THESE TERMS BEFORE USING THIS SOFTWARE!"
	echo "**********************************************************"
	echo ""
	echo ""
	echo ""
	$white
	echo "PLEASE PRESS "\""Y"\"" AND ENTER TO ACCEPT AND CONTINUE"
	echo ""

	read agreeToDisclaimer

	case "$agreeToDisclaimer" in

		"")
		bannerExit
		;;

		"Y" | "y")
		checkForUpdates
		fixNegativeOneChannelError
		#initAirmon
		fixAirmonCompat
		#startNetworkManager
		#killNetworkManager
		#wpaSupplicantKill
		#initMonitorMode
		#stopMonitorMode
		#checkMultipleAdapters
		menuMain
		;;

		*)
		bannerExit
		;;

	esac

}


############################################################################
#   DISCLAIMER END   #######################################################
############################################################################





############################################################################
#   BANNERS BEGIN   ########################################################
############################################################################


banner(){

	setWindowTitle

	currentTask="banner"

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [M] Main Menu    |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2019  /  github.com/esc0rtd3w *    | [X] Exit           |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Interfaces: $interfacesFound  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}


bannerNoMenu(){

	currentTask="bannerNoMenu"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ CTRL+C ] Main  |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2019  /  github.com/esc0rtd3w *    | [CTRL+C x2 ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Interfaces: $interfacesFound  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}


bannerMain(){

	currentTask="bannerMain"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2019  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	echo "-------------------------------------------------------------------------------------------------------------------"
	$yellow
	echo "| Interfaces: $interfacesFound  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}

bannerMenu(){

	currentTask="bannerMenu"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2019  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$yellow
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "| Interfaces: $interfacesFound  |  Interface Mode: $interfaceMode  |  [A] Advanced  |  Sessions: [S] Save  [L] Load  |  [E] Extras  [H] Help  |"
	echo "-------------------------------------------------------------------------------------------------------------------"
	#echo ""
	$white

}

bannerSlim(){

	currentTask="bannerSlim"

	setWindowTitle

	clear
	$blue
	echo "---------------------    ****************************************************************    ----------------------"
	echo "|  [ ]              |    * WiFi Hacker v$versionBase  /  esc0rtd3w 2019  /  github.com/esc0rtd3w *    | [CTRL+C    ] Exit  |"
	echo "---------------------    ****************************************************************    ----------------------"
	$white

}


bannerStats(){

	currentTask="bannerStats"

	$cyan
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo "Interface: $interfaceName / MAC: $macAddressMonitor / ESSID: $essid / BSSID: $bssid / Channel: $channel"
	echo "-------------------------------------------------------------------------------------------------------------------"
	echo ""
	$white

}

bannerExit(){

	currentTask="bannerExit"

	sessionWriteEndCurrent

	sessionRemoveEmpty

	forceDisconnectWifi

	clear
	$blue
	echo "Thank You For Playing Fair ;)"
	echo ""
	echo "esc0rtd3w 2019"
	echo ""
	echo ""
	$cyan
	echo "View My Other Projects On GitHub:"
	echo ""
	echo "https://github.com/esc0rtd3w"
	echo ""
	echo ""

	exit

}

bannerExitUpdate(){

	currentTask="bannerExitUpdate"

	clear
	$green
	echo "The WiFi Hacker Script Has Been Updated To Version $versionRemote"
	echo ""
	echo "The New Script Is Located At $initPath/$newVersionScript"
	echo ""
	echo ""
	echo ""
	echo "To launch the new script type the following two lines into this terminal WITHOUT QUOTES"
	echo ""
	echo "\"chmod a+x $newVersionScript\""
	echo ""
	echo "\"./$newVersionScript\""
	echo ""
	echo ""
	echo ""
	$blue
	echo "Thank You For Playing Fair ;)"
	echo ""
	echo "esc0rtd3w 2019"
	echo ""
	echo ""
	$cyan
	echo "View My Other Projects On GitHub:"
	echo ""
	echo "https://github.com/esc0rtd3w"
	echo ""
	echo ""

	exit

}


############################################################################
#   BANNERS END   ##########################################################
############################################################################





############################################################################
#   GLOBAL TEXT BEGIN   ####################################################
############################################################################


# Usage: doSleepMessage "message" "time" "color"
# Usage Example: doSleepMessage "Please Wait...." "5" "$red"
doSleepMessage(){

	message="$1"
	time="$2"
	color="$3"

	currentTask="doSleepMessage"

	banner
	bannerStats
	$color
	echo "$message"
	sleep $time

}


############################################################################
#   GLOBAL TEXT END   ######################################################
############################################################################





############################################################################
#   UPDATE STUFF BEGIN   ###################################################
############################################################################


checkForUpdates(){

	currentTask="checkForUpdates"

	checkConnectionStatus

	# If a blank entry was made to skip update then this value should be 1
	case "$skipUpdate" in

		"0")
		# If connection can connect to internet, check for update
		case "$ipStatus" in

			"1")
			menuUpdate
			;;

		esac

		;;

	esac

}


menuUpdate(){

	currentTask="menuUpdate"

	# Check remote server for update version
	case "$updateChecked" in

		"0")

		# Make sure there is an active internet connection
		case "$ipStatus" in

			"1")
			checkUpdate
			;;

		esac

		;;

	esac

	# Set default choice
	updateChoice=""
	
	bannerSlim

	echo ""
	#echo "Update Menu"
	#echo ""
	#echo ""
	#echo ""

	# If remote version is not newer, then local version should be green
	case "$newUpdateAvailable" in

		"0")
		$green
		;;

		"1")
		$yellow
		;;

		"2")
		$magenta
		;;

	esac

	echo "Local Version: v$versionBase"
	echo ""

	# If remote version is newer, then local version should not be green
	case "$newUpdateAvailable" in

		"0")
		$yellow
		;;

		"1")
		$green
		;;

		"2")
		$magenta
		;;

	esac

	echo "Remote Version: v$versionRemote"
	$white
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Choose an option and press ENTER:"
	echo ""
	echo ""
	echo "1) Check For New Update"
	echo ""
	echo "2) Apply New Update"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""
	$cyan
	echo "AUTOMATICALLY CONTINUING IN 10 SECONDS...."
	$white
	echo ""

	#read updateChoice
	read -t 10 updateChoice

	case "$updateChoice" in

		"")
		skipUpdate="1"
		returnToUpdatePage="0"
		#read pause
		;;

		"1")
		# Reset updateChecked Flag
		updateChecked="0"

		returnToUpdatePage="1"
		checkUpdate
		;;

		"2")

		case "$newUpdateAvailable" in

			# No Update Available / Remote Version Matches Local
			"0")
			returnToUpdatePage="0"
			
			banner
			$red
			echo ""
			echo "No Updates Are Available!"
			echo ""
			echo ""
			echo ""
			echo ""
			echo ""
			echo ""
			$cyan
			echo "Continuing To Main Menu In 5 Seconds...."
			echo ""
			echo ""

			read -t 5 noUpdateAvailable
			;;

			# Update Is Available / Remote Version Is Higher Than Local
			"1")
			returnToUpdatePage="0"
			getUpdate
			;;

			# Dev Build / Remote Version Is Lower Than Local
			"2")
			returnToUpdatePage="0"

			banner
			$magenta
			echo ""
			echo "You Have An Unreleased Developer Version"
			echo ""
			echo ""
			echo ""
			$green
			echo ""
			echo "* TO FORCE UPDATE FROM REMOTE VERSION PRESS \"F\" AND ENTER *"
			echo ""
			echo ""
			echo ""
			echo ""
			$cyan
			echo "Continuing To Main Menu In 10 Seconds...."
			echo ""
			echo ""

			read -t 10 noUpdateAvailable

			# Check for Forced Update Flag
			case "$noUpdateAvailable" in

				"F" | "f")
				returnToUpdatePage="0"
				getUpdate
				;;

			esac
			;;

		esac
		;;

		"x" | "X")
		bannerExit
		;;

	esac

}


checkUpdate(){

	currentTask="checkUpdate"
	
	wget -O "$updateTemp" $updateMaster

	versionRemoteTemp=$(cat $updateTemp | grep versionBase= | cut -d "\"" -f2 | head -c 3)

	versionRemote="$versionRemoteTemp"

	case "$isDebugMode" in
		"1")
		echo "versionRemote: $versionRemote"
		read pause
		;;
	esac

	cleanVersionNumbers
	compareUpdateVersions

	#echo "newUpdateAvailable: $newUpdateAvailable"
	#read pause

	rm $updateTemp

	updateChecked="1"

	case "$returnToUpdatePage" in

		"1")
		menuUpdate
		;;
	
	esac

}


getUpdate(){

	currentTask="getUpdate"
	
	# Get Base Script Name
	#newVersionScript=$(printf '%s\n' "${0##*/}")
	newVersionScript=$(basename -- "$0")
	
	# Download New Script
	wget -O "$initPath/$newVersionScript.tmp" $updateMaster

	#read pause

	# Make Backup of Original Script
	cp "$initPath/$newVersionScript" "$initPath/$newVersionScript.BACKUP"

	# Remove Old Script
	rm -f "$initPath/$newVersionScript"

	# Copy New Script
	cp "$initPath/$newVersionScript.tmp" "$initPath/$newVersionScript"

	# Remove Temp Script
	rm -f "$initPath/$newVersionScript.tmp"

	#read pause

	bannerExitUpdate

}


cleanVersionNumbers(){

	currentTask="cleanUpdateVersion"

	versionBaseClean=$(echo $versionBase | sed -e 's/\.//')

	versionRemoteClean=$(echo $versionRemote | sed -e 's/\.//')

	#echo "Local Version: $versionBaseClean"
	#echo "Remote Version: $versionRemoteClean"
	#read pause

}


compareUpdateVersions(){

	# Compare Local and Remote Versions (0 = Not Greater / 1 = Greater) (Not working?? 20170102)
	#versionCompare=$(echo "$versionBaseClean <= $versionRemoteClean" | awk '{print ($versionBaseClean <= $versionRemoteClean)}')

	if [ $versionRemoteClean -lt $versionBaseClean ]; then
		
		newUpdateAvailable="2"
		isDevBuild="1"
	
	fi
	
	if [ $versionRemoteClean -gt $versionBaseClean ]; then

		newUpdateAvailable="1"
		isDevBuild="0"
	
	fi

	if [ $versionRemoteClean -eq $versionBaseClean ]; then
		
		newUpdateAvailable="0"
		isDevBuild="0"
	
	fi

}


############################################################################
#   UPDATE STUFF END   #####################################################
############################################################################





############################################################################
#   OTHER MISC STUFF BEGIN   ###############################################
############################################################################


checkRootStatus(){

	userPriv="none"

	isRoot=$(whoami | grep root)

	case "$isRoot" in

		"root")
		userPriv="root"

	esac

	if [ "$userPriv" != "root" ]; then
		noRootAccess
	fi

}



noRootAccess(){

	banner
	bannerStats

	$red
	echo "Yikes! No Root Access!"
	$white
	echo ""
	echo ""
	echo "I Currently Have Nothing Scripted To Handle This :("
	echo ""
	echo "Please login as a root user and try again!"
	echo ""
	echo ""
	echo "Press ENTER to exit this script...."
	echo ""
	echo ""

	read pause


	bannerExit

}


checkConnectionStatus(){

	ipStatus="0"
	ipStatusText="None"

	ipStatusTemp=$(ping -c 1 google.com | grep "1 received")

	ipStatus=$(echo "$ipStatusTemp" | cut -c1)


	case "$ipStatus" in

		"1")
		ipStatus="1"
		ipStatusText="Wifi"
		;;

	esac

	case "$ipStatusText" in

		"None")
		ipStatus="0"
		;;

	esac

	#echo "$ipStatusText"

	#read pause

}


fixAirmonCompat(){

	#$terminal airmon-ng check kill&
	airmon-ng check kill&
	#airmon-ng check kill&

}


checkWifiandDisplayMessage(){

	case "$ipStatusText" in

		"Wifi")
		banner
		echo ""
		echo "YOU MUST DISCONNECT FROM WIFI BEFORE CONTINUING!!!!"
		echo ""
		echo ""
		echo "PRESS ENTER TO RETURN TO MAIN MENU...."
		echo ""
		echo ""

		read pause

		menuMain
		;;

	esac

}


# Tries fixing issues with connection staying persistant to WiFi
forceDisconnectWifi() {

	#stopMonitorMode
	#killNetworkManager
	NetworkManager
	#disableChannelHopping
	enableChannelHopping

}


############################################################################
#   OTHER MISC STUFF END   #################################################
############################################################################





############################################################################
#   MENUS: MAIN BEGIN   ####################################################
############################################################################


loadMenuHotkeys(){

case "$hotkeyInput" in

	"M" | "m")

	# Check for resetSpoofStatus Flag
	case "$resetSpoofStatus" in

		"1")
		spoofStatus="0"
		;;

	esac

	killAll
	stopMonitorMode
	menuMain
	;;

	"A" | "a")
	menuAdvanced
	;;

	"S" | "s")
	checkForEmptyEncryptionType

	case "$bssid" in

		"")
		menuMain
		;;

	esac

	if [ "$bssid" != "" ]; then
		menuSessionSave
	fi
	;;

	"L" | "l")
	checkForEmptyEncryptionType
	menuSessionLoad
	;;

	"H" | "h")
	menuHelp
	;;

	"E" | "e")

	case "$lastMenuID" in

		"menuMain")
		menuMain
		;;

		*)
		menuExtras
		;;

	esac
	
	;;

	"X" | "x")
	killAll
	stopMonitorMode
	bannerExit
	;;

esac

}


menuMain(){

	currentTask="menuMain"
	lastMenuID="menuMain"

	# Create temp folder to use for text dumps, etc
	mkdir $whTemp

	checkRootStatus
	sessionCreatePaths
	sessionRemoveEmpty

	checkMultipleAdapters
	checkInterfaceMode

	checkConnectionStatus

	case "$ipStatus" in

		"1")
		banner
		echo ""
		echo "Loading Menu...."	
		echo ""
		echo ""

		forceDisconnectWifi
		checkConnectionStatus

		sleep 3

		menuMain
		;;

		"0")
		banner
		echo ""
		#echo "Welcome to the WiFi Hacker script!"
		echo "Compatible with all WEP/WPA/WPA2/WPS protected WiFi routers."
		echo ""
		$red
		echo "**********************************************************************"
		echo "YOU MUST DISCONNECT FROM ANY WIRELESS CONNECTIONS BEFORE CONTINUING!!!"
		echo "**********************************************************************"
		echo ""

		case "$ipStatus" in
			"0")
			$green
			;;

			"1")
			$red
			;;
		esac
		echo "You are currently connected to: $ipStatusText"
		$white
		echo ""
		echo ""
		#$cyan
		echo "0) Auto Mode    (Uses WiFite In Full Automatic Mode. Applies To All Encryption Types)"
		#$white
		echo ""
		echo "1) WEP Mode     (Menu Options Can Be Selected To Easily Circumvent Any WEP Connection)"
		echo ""
		echo "2) WPS Mode     (Pin Vulnerability Attack. May Also Have WPA, WPA2, or WEP Displayed)"
		echo ""
		echo "3) WPA Mode     (Capture 4-way Handshake, Dictionary Attack, Bruteforce, Custom Wordlist, and More)"
		echo ""
		echo "4) WPA2 Mode    (Identical To WPA Attacks, Except Target Encryption Type)"
		echo ""
		echo ""
		echo ""
		echo "Select a mode from above and press Enter:"
		echo ""

		read getMode

		hotkeyInput="$getMode"	

		loadMenuHotkeys "$hotkeyInput"

		case "$getMode" in

			"")
			menuMain
			;;

			"0")
			checkConnectionStatus
			checkWifiandDisplayMessage
			menuAttacksAllWifiteAuto
			menuMain
			;;

			"1")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWEP
			encryptionType="wep"
			encryptionTypeText="WEP"
			checkSpoofStatus
			menuAuto
			;;

			"2")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPS
			encryptionType="wps"
			encryptionTypeText="WPS"
			checkSpoofStatus
			menuAuto
			;;

			"3")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPA
			encryptionType="wpa"
			encryptionTypeText="WPA"
			checkSpoofStatus
			menuAuto
			;;

			"4")
			checkConnectionStatus
			checkWifiandDisplayMessage
			mkdir $capturePathWPA2
			encryptionType="wpa2"
			encryptionTypeText="WPA2"
			checkSpoofStatus
			menuAuto
			;;

			*)
			menuMain
			;;

		esac
		;;

	esac

	#menuMain
}


menuAuto(){

	currentTask="menuAuto"
	lastMenuID="menuAuto"

	case "$encryptionTypeText" in

		"Empty")
		menuMain
		;;

	esac

	#sessionCopyNewCaptureFiles
	sessionRemoveEmpty

	cleanTempScanResultsFile "all"

	checkInterfaceMode

	banner
	bannerStats
	
	$green
	echo ""
	echo "You are ready to begin the $encryptionTypeText attack!"
	echo ""
	$white

	case "$encryptionTypeText" in

		"WEP")
		echo "To perform a fully automated attack, type AUTOWEP end press ENTER"
		;;

		"WPS")
		echo "To perform a fully automated attack, type AUTOWPS end press ENTER"
		;;

		"WPA")
		echo "To perform a fully automated attack, type AUTOWPA end press ENTER"
		;;

		"WPA2")
		echo "To perform a fully automated attack, type AUTOWPA2 end press ENTER"
		;;

	esac

	echo ""
	echo "YOU MAY NOW OPTIONALLY PRESS THE \"W\" KEY ON KEYBOARD TO YOUR SPOOF MAC ADDRESS"
	echo ""
	echo ""
	echo ""
	echo "The next step will run an airodump-ng session in a new window."
	echo ""
	echo "Once you enter all required info, the new window will be closed"
	echo ""
	echo ""
	echo ""
	echo "Press ENTER to clear the current session and select a target...."
	echo ""
	echo "YOU MAY ALSO PRESS THE \"P\" KEY ON KEYBOARD TO LOAD PREVIOUS SESSION"
	echo ""

	read readyForAirodumpScan

	hotkeyInput="$readyForAirodumpScan"

	loadMenuHotkeys "$hotkeyInput"	

	case "$readyForAirodumpScan" in

		"")
		killAll
		checkForEmptyEncryptionType

		# Run wash if WPS
		case "$encryptionTypeText" in

			"WPS")
			#$terminal wash -i $interfaceMonitor -o "$washFile" -C
			;;

		esac

		autoModeNoPreviousSession
		;;

		"P" | "p")
		checkForEmptyEncryptionType

		checkForEmptyCredentials "bssid"
		checkForEmptyCredentials "essid"
		checkForEmptyCredentials "channel"

		autoModeUsePreviousSession
		;;

		"W" | "w")
		#returnTo="menuAuto"
		spoofMacAddress
		menuAuto
		;;

		"autowep" | "AUTOWEP" | "AutoWEP" | "AutoWep" | "autoWEP" | "autoWep")
		menuAttacksWEPWifiteAuto
		;;

		"autowps" | "AUTOWPS" | "AutoWPS" | "AutoWps" | "autoWPS" | "autoWps")
		menuAttacksWPSWifiteAuto
		;;

		"autowpa" | "AUTOWPA" | "AutoWPA" | "AutoWpa" | "autoWPA" | "autoWpa")
		menuAttacksWPAWifiteAuto
		;;

		"autowpa2" | "AUTOWPA2" | "AutoWPA2" | "AutoWpa2" | "autoWPA2" | "autoWpa2")
		menuAttacksWPA2WifiteAuto
		;;

		*)
		menuAuto
		;;

	esac

	#restartProcesses

	menuMain

}


menuAdvanced(){

	currentTask="menuAdvanced"
	#lastMenuID="menuAdvanced"

	interface="None"

	banner
	bannerStats

	echo ""
	echo "SORRY I GOT LAZY AND NEVER CODED THIS MENU"
	echo "WILL BE AVAILABLE SOOOOOOOOOON!"
	echo ""
	echo ""
	echo "Advanced Menu"
	echo ""
	echo ""
	echo "1) Monitor Mode Options"
	echo ""
	echo "2) Honeypot Mode and Attacks"
	echo ""
	echo ""
	echo ""
	echo ""
	$green
	echo "** TO RETURN TO PREVIOUS PAGE JUST PRESS ENTER **"
	$white
	echo ""
	echo ""
	echo ""
	echo ""
	echo "Select an option and press ENTER:"
	echo ""
	echo ""

	read getAdvancedOptionMain

	hotkeyInput="$getAdvancedOptionMain"

	loadMenuHotkeys "$hotkeyInput"

	case "$getAdvancedOptionMain" in

		"")
		$currentTask
		#menuMain
		#menuAdvanced
		;;

		*)
		$currentTask
		#menuMain
		#menuAdvanced
		;;

	esac

	#restartProcesses

	$currentTask

}


menuExtras(){

	#currentTask="menuExtras"
	#lastMenuID="menuExtras"

	banner
	bannerStats

	echo "1) Backup All Sessions and Capture Files (Full Backup of all saved files to ZIP file)"
	echo "2) Clean Capture Files (Removes all saved .cap, .xor, .ivs, .csv, and .netxml files)"
	echo "3) Clean Session Files (Removes all saved WEP, WPS, WPA, WPA2 *.sessions files)"
	echo ""
	echo "4) Change Active Terminal (Switch between Gnome, Konsole, X-Term, and User Selected)"
	echo ""
	echo "5) Start NetworkManager          6)  Stop NetworkManager"
	echo "7) Enable wpa_supplicant         8)  Disable wpa_supplicant"
	echo "9) Start wpa_cli                 10) Stop wpa_cli"
	echo ""
	echo "11) Open Interface Options Menu"
	echo ""
	echo "12) Hidden SSID Options"
	echo ""
	echo "R) Return To Previous Menu"
	echo ""
	echo ""
	echo "Select an option from above and press ENTER:"
	echo ""

	read getExtras

	hotkeyInput="$getExtras"

	loadMenuHotkeys "$hotkeyInput"

	case "$getExtras" in

		"")
		menuExtras
		;;

		"1")
		backupSessionFiles
		;;

		"2")
		cleanCaptureFiles
		;;

		"3")
		cleanSessionFiles
		;;

		"4")
		menuChangeTerminal
		;;

		"5")
		startNetworkManager
		;;

		"6")
		killNetworkManager
		;;

		"7")
		wpaSupplicantEnable
		;;

		"8")
		wpaSupplicantDisable
		;;

		"9")
		wpa_cli start
		;;

		"10")
		wpa_cli terminate
		;;

		"11")
		menuExtrasInterface
		;;

		"12")
		banner
		bannerStats

		echo "1) Bruteforce Hidden SSID"
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		echo ""
		$cyan
		echo "* Just Press ENTER To Return To Previous Menu *"
		echo ""
		echo ""
		$white
		echo "Select an option from above and press ENTER:"
		echo ""

		read ssidHiddenOption

		case "$ssidHiddenOption" in

			"1")
			bruteForceHiddenSSID
			;;

		esac
		;;

		"r" | "R")
		$lastMenuID
		;;

		*)
		menuExtras
		;;

	esac

	menuExtras

}

menuExtrasInterface(){

	currentTask="menuExtrasInterface"
	#lastMenuID="menuExtrasInterface"

	banner
	bannerStats

	echo ""

	echo "1) Enable Channel Hopping: $interface"
	echo "2) Disable Channel Hopping: $interface"
	echo ""
	echo "3) Bring Up Interface: $interfaceMonitor"
	echo "4) Bring Down Interface: $interfaceMonitor"
	echo ""
	echo "5) Switch Interface To Managed"
	echo "6) Switch Interface To Monitor"
	echo ""
	echo "7) Fix Airmon Conflicting Processes"
	echo ""
	echo "8) Get \"ifconfig\" Output"
	echo "9) Get \"iwconfig\" Output"
	echo ""
	echo "R) Return To Previous Menu"
	echo ""
	echo ""
	echo "Select an option from above and press ENTER:"
	echo ""
	#echo ""

	read getExtrasInterface

	hotkeyInput="$getExtrasInterface"

	loadMenuHotkeys "$hotkeyInput"

	case "$getExtrasInterface" in

		"")
		menuInterface
		;;

		"1")
		enableChannelHopping
		;;

		"2")
		disableChannelHopping
		;;

		"3")
		interfaceUp
		;;

		"4")
		interfaceDown
		;;

		"5")
		interfaceManaged
		;;

		"6")
		interfaceMonitor
		;;

		"7")
		fixAirmonCompat
		;;

		"8")
		showIfConfig=$(ifconfig)
		banner
		bannerStats
		echo ""
		echo "$showIfConfig"
		echo ""
		echo ""	
		echo ""	
		echo "Press ENTER to continue..."	
		echo ""	
		echo ""	
		read pause
		;;

		"9")
		showIwConfig=$(iwconfig)
		banner
		bannerStats
		echo ""
		echo "$showIwConfig"
		echo ""
		echo ""	
		echo ""	
		echo "Press ENTER to continue..."	
		echo ""	
		echo ""	
		read pause
		;;

		"r" | "R")
		#$lastMenuID
		menuExtras
		;;

		*)
		menuExtrasInterface
		;;

	esac

	menuExtrasInterface

}


menuHelp(){

	currentTask="menuHelp"
	#lastMenuID="menuHelp"

	banner
	bannerStats

	echo ""
	echo "*******************************************"
	echo "CURENTLY NOT WORKING!!!"
	echo ""
	echo "PRESS ENTER TO RETURN TO PREVIOUS MENU!"
	echo "*******************************************"
	echo ""
	echo ""
	echo ""
	echo "Welcome to the Help Section!"
	echo ""
	echo ""
	echo ""
	echo "CURRENTLY NOT AVAILABLE!"
	echo ""
	echo ""
	echo ""
	echo ""
	echo ""

	read getHelp

	hotkeyInput="$getHelp"

	loadMenuHotkeys "$hotkeyInput"

	case "$getHelp" in

		"")
		$lastMenuID
		#menuMain
		#menuHelp
		;;

		*)
		$lastMenuID
		#menuMain
		#menuHelp
		;;

	esac

	$lastMenuID

}


menuChangeTerminal(){

	currentTask="menuChangeTerminal"
	#lastMenuID="menuChangeTerminal"

	banner


	echo ""
	echo "Select a new terminal to use"
	echo ""
	echo ""
	echo "Current Terminal: $terminal"
	echo ""
	echo ""
	echo "1a) Gnome Legacy: $terminalGnomeLegacy"
	echo ""
	echo "1b) Gnome: $terminalGnome"
	echo ""
	echo "2) Konsole: $terminalKonsole"
	echo ""
	echo "3) X-Term: $terminalXterm"
	echo ""
	echo "4) Custom (User Selected)"
	echo ""
	echo "5) Return To Previous Menu"
	echo ""
	echo ""

	read getTerminalType

	hotkeyInput="$getTerminalType"

	loadMenuHotkeys "$hotkeyInput"

	case "$getTerminalType" in

		"")
		menuChangeTerminal
		;;

		"1a")
		terminal="$terminalGnomeLegacy"
		terminalText="GnomeLegacy"
		;;

		"1b")
		terminal="$terminalGnome"
		terminalText="Gnome"
		;;

		"2")
		terminal="$terminalKonsole"
		terminalText="Konsole"
		;;

		"3")
		terminal="$terminalXterm"
		terminalText="Xterm"
		;;

		"4")
		banner
		echo ""
		echo "Input a terminal string with arguments and press ENTER:"
		echo ""
		echo ""
		echo "Example: $terminalGnome"
		echo ""
		echo ""

		read newTerminal

		case "$newTerminal" in

			*)
			terminal="$newTerminal"
			terminalText="Custom"
			;;

		esac

		;;

		"5")
		menuExtras
		;;

		*)
		menuChangeTerminal
		;;

	esac

	menuMain

}


menuHoneyPotMode(){

	currentTask="menuHoneyPotMode"

	initMonitorMode

	banner
	bannerStats

	echo ""
	echo "I Am HoneyPot Mode"
	echo ""
	echo "I Am Also Broken :("
	echo ""
	echo ""
	echo ""
	echo "1) Use Airbase-ng"
	echo ""
	echo "2) Use Wifi-Honey"
	echo ""
	echo "3) Use a Custom Binary"
	echo ""
	echo ""
	echo ""
	echo "Select an option and press ENTER:"
	echo ""
	echo ""

	read getHoneyPotOptionMain

	hotkeyInput="$getHoneyPotOptionMain"

	loadMenuHotkeys "$hotkeyInput"

	case "$getHoneyPotOptionMain" in

		"")
		menuHoneyPotMode
		#$lastMenuID
		#menuMain
		#menuAdvanced
		;;

		"1")
		getBSSID
		$terminal airbase-ng -a $bssid -i $interfaceMonitor -h $macAddressMonitor -v &
		;;

		"2")
		getESSID
		getChannel
		$terminal wifi-honey $essid $channel $interfaceMonitor &
		;;

		"3")
		echo "Custom Binary"
		read pause
		menuHoneyPotMode
		;;

		*)
		menuHoneyPotMode
		#$lastMenuID
		#menuMain
		#menuAdvanced
		;;

	esac

	#restartProcesses

	menuHoneyPotMode
	#$lastMenuID

}


selectFromApList(){
	
	# Get AP Credential Type From 1st Argument
	apListType="$1"

	currentTask="selectFromApList"

	echo "Dumping Found AP Targets From airodump-ng Window...."
	echo ""
	echo ""

	case "$apListType" in

		"essid")
		sleep 15
		cat "$defaultScanOutputXML" | grep "<essid cloaked="
		;;

		"bssid")
		sleep 15
		cat "$defaultScanOutputXML" | grep "<BSSID>"
		;;

		"channel")
		sleep 15
		cat "$defaultScanOutputXML" | grep "<channel>"
		;;

	esac

	echo ""
	echo ""
	$yellow
	echo "Select $apListType from found AP targets above and copy to clipboard (CTRL+SHIFT+C)"
	echo ""
	echo ""
	$white
	echo "You may