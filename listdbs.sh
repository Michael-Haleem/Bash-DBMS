#! /bin/bash

source ../utilities_functions.sh

clear

echo -e "Current dbs:\n"

ls -F | grep / | sed 's./..g'

echo -en "\nPress any key to return to main menu"

read -rn 1

clear

print_mainmenu