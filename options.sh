#!/usr/bin/env bash

finished=0

while [ $finished -ne 1 ]
do
    echo "What would you like to do?"

    echo "1) Perform system upgrade"
    echo "2) Install tree and htop"
    echo "3) Install Chrome desktop application"
    echo "4) Copy logs from /var/log to another directory"
    echo "5) Create test user w/ passwd and assign said user to appropriate group"
    echo "6) Exit the script"

        read usrinput

        case $usrinput in
        1) echo "Please wait while system upgrades packages..."
        brew update 1> ~/update.logs
        brew upgrade 1> ~/upgrade.logs 2> ~/error.logs
        echo "Everything is complete, check update.logs & upgrade.logs for more info";;

        2) echo "Checking To See If Packages Are Installed..."
        package_check () {
        if [ -x "/opt/homebrew/bin/tree" ] && [ -x "/opt/homebrew/bin/htop" ]
        then
            echo "Packages are installed..."
            return 0
        else
            echo "Packages are not installed..."
            echo "-------------------------------"
            return 1
        fi
        }

        install () {
            brew install tree 1>> package.install.logs 2>> package.error.logs
            brew install htop 1>> package.install.logs 2>> package.error.logs
        }
    
        if ! package_check
        then
            echo "Installing tree and htop..."
            install
            echo "Installation complete..."
            echo "Try out the commands to see them in action"
        fi;;

        3) echo "Checking To See if Chrome is installed..."
            chrome_check () {
            if [ -d "/Applications/Google Chrome.app" ]
            then
                echo "Chrome is installed..."
                return 0
            else
                echo "Chrome is not installed..."
                echo "-------------------------------"
                return 1
            fi
            }

            chrome_install () {
                echo "Downloading Chrome..."
                curl -sL -o /tmp/chrome.dmg "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"

                echo "Mounting Chrome DMG File..."
                hdiutil attach /tmp/chrome.dmg -nobrowse -quiet

                echo "Copying Chrome to /Applications..."
                cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications/

                echo "Unmounting Chrome DMG File..."
                hdiutil detach "/Volumes/Google Chrome" -quiet

                echo "Installtion complete..."
            }

            if ! chrome_check
            then 
                chrome_install
            fi;;

        4) echo "Copying log files"
            mkdir -p ~/Logs
            cp -r /var/log/*.log ~/Logs
            echo "Copying complete. Copied files can be found at ~/Logs/";;

        5) echo "Creating Group Tester and User test_dummy..."
            sudo dscl . -create /Groups/Testers
            sudo dscl . -create /Groups/Testers PrimaryGroupID "9999"
            sudo dscl . -create /Users/test_dummy
            sudo dscl . -create /Users/test_dummy UserShell /bin/bash
            sudo dscl . -create /Users/test_dummy RealName "Test Dummy"
            sudo dscl . -create /Users/test_dummy UniqueID "9090"
            sudo dscl . -create /Users/test_dummy PrimaryGroupID "9999"
            sudo dscl . -create /Users/test_dummy NFSHomeDirectory /Users/test_dummy
            echo "Completed...Display user info with dscl . -read /Users/username";;

        6) finished=1;;
      
        *) echo "You didn't select an appropriate option"  
    esac
done