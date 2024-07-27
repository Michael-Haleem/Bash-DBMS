#! /bin/bash

source ../utilities_functions.sh

clear

while true 
do
    echo -n "Enter the Database name or press 0 then press Enter to return to previous menu: "

    read dbname
    
    if [ "$dbname" -eq 0 ];then
        clear
        print_mainmenu
        break
    fi

    if validate_name "$dbname"; then

        if ! [ -d "$dbname"  ]; then
            mkdir "$dbname"
            clear
            echo "$dbname database created successfully"
            echo
            print_mainmenu
            break
        else
            echo "The name is already taken"
        fi
        
    fi
done