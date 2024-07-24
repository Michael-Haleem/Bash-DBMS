#! /bin/bash

source ../../utilities_functions.sh

clear

cleanup_mate_files

PS3="Please select an option: "

options=("Create Table" "List Tables" "Drop Table" "insert into Table" "Select Table" "Select From Table" "Delete From Table" "Return To MainMenu")

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
            echo "Drop Table"
            ;;
        "insert into Table")
            echo "insert into Table"
            ;;
        "Select Table")
            echo "Select Table"
            ;;
        "Select From Table")
            echo "Select From Table"
            ;;
        "Delete From Table")
            echo "Delete From Table"
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
