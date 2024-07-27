#! /bin/bash

source ../../utilities_functions.sh

clear

cleanup_mate_files

PS3="Please select an option: "

options=("Create Table" "List Tables" "Drop Table" "insert into Table" "Select From Table" "Delete From Table" "Update Table" "Return To MainMenu")

select opt in "${options[@]}"
do
    case $opt in
        "Create Table")
            source ../../createtable.sh
            PS3="Please select an option: "
            ;;
        "List Tables")
            source ../../listtables.sh
            ;;
        "Drop Table")
            source ../../droptable.sh
            ;;
        "insert into Table")
            source ../../insertintotable.sh
            PS3="Please select an option: "
            ;;
        "Select From Table")
            source ../../selectfromtable.sh
            PS3="Please select an option: "
            ;;
        "Delete From Table")
            source ../../deletefromtable.sh
            PS3="Please select an option: "
            ;;
        "Update Table")
            echo "update"
            ;;
        "Return To MainMenu")
            cd ..
            clear
            print_mainmenu
            break
            ;;
        *)
            echo "Invalid option $REPLY"
            ;;
    esac
done
