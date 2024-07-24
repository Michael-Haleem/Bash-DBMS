#! /bin/bash

clear

echo -e "Current dbs:\n"

ls -F | grep / | sed 's./..g'

echo -en "\nPress any key to return to main menu"

read -n 1

clear

source ../utilities_functions.sh

print_mainmenu