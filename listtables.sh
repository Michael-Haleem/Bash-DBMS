#! /bin/bash

source ../../utilities_functions.sh

clear

echo -e "Current Tables:\n"

ls -F | grep -v '\.meta$'

echo -en "\nPress any key to return to main menu"

read -rn 1

clear

print_tablemainmenu