#! /bin/bash

clear

while true 
do
    echo -n "Enter the Database name: "

    read dbname

    source ../utilities_functions.sh

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