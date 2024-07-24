#! /bin/bash

source ../utilities_functions.sh

clear

while true
do
    echo -n "Enter Database name to drop or enter 0 and press enter to return the main menu: "

    read dbname

    if [ -d "$dbname" ]; then
        rm -rf "$dbname"
        clear
        echo -e "\n$dbname was dropped successfully\n"
        print_mainmenu
        break
    elif [ "$dbname" = "0" ]; then
        clear
        print_mainmenu
        break
    else
        echo -e "\n$dbname db was not found\n"
    fi
done