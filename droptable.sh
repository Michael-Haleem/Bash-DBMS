#! /bin/bash

source ../../utilities_functions.sh

clear

while true
do
    echo -n "Enter Table name to drop or enter 0 and press enter to return the table main menu: "

    read -r tablename

    if [ -e "$tablename" ]; then
        rm "$tablename"
        rm "$tablename.meta"
        clear
        echo -e "\n$tablename was dropped successfully\n"
        print_tablemainmenu
        break
    elif [ "$tablename" =  "0" ]; then
        clear
        print_tablemainmenu
        break
    else
        echo -e "\n$tablename table was not found\n"
    fi
done
