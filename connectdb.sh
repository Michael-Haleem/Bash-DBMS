#! /bin/bash

source ../utilities_functions.sh

clear

while true
do
    echo -n "Enter Database name you want to connect to or enter 0 and press enter to return the main menu: "

    read dbname

    if [ -d "$dbname" ]; then
        cd "$dbname"
        clear
        echo -e "\nYou are now connected to $dbname\n"
        source ../../tablemainmenu.sh
        break
    elif [ "$dbname" = "0" ]; then
        clear
        print_mainmenu
        break
    else
        echo -e "\n$dbname db was not found\n"
    fi
done