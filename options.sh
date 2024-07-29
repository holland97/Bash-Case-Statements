#!/usr/bin/env bash

echo "What would you like to do?"

echo "1) Perform system upgrade"
echo "2) Install tree and htop"
echo "3) Install 1Password application"
echo "4) Copy logs from /var/log to another directory"
echo "5) Create test user w/ passwd and assign said user to appropriate group"
echo "6) Something else"

read usrinput

case $usrinput in
    1) echo "Please wait while system upgrades packages..."
    brew update >> ~/update.logs
    brew upgrade 1> ~/upgrade.logs 2> ~/error.logs
    echo "Everything is complete, check update.logs & upgrade.logs for more info";;

    2) echo "Checking To See If Packages Are Installed..."
    package_check () {
    if [ -f "/opt/homebrew/bin/tree" ] && [ -f "/opt/homebrew/bin/htop" ]
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
        echo "Try which tree or which htop to see the commands in action"
    fi;;

   ## 3) echo "Checking To See 1Password is installed..."
    #1Password_check () {
     #   if [ -d "/Applications/1Password.app" ]
      #  then
       #     echo "1Password is installed..."
        #    return 0
        #else
        #    echo "1Password is not installed..."
         #   echo "-------------------------------"
         #   return 1
        #fi
    ##}

      # 4)

      5) echo "Creating Group Tester and User test_dummy..."
        sudo dscl . -create /Groups/Testers
        sudo dscl . -create /Groups/Testers PrimaryGroupID "9999"
        sudo dscl . -create /Users/test_dummy
        sudo dscl . -create /Users/test_dummy UserShell /bin/bash
        sudo dscl . -create /Users/test_dummy RealName "Test Dummy"
        sudo dscl . -create /Users/test_dummy UniqueID "9090"
        sudo dscl . -create /Users/test_dummy PrimaryGroupID "9990"
        sudo dscl . -create /Users/test_dummy NFSHomeDirectory /Users/test_dummy
        echo "Completed...Display user info with dscl . -read /Users/username";;
esac