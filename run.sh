#! /bin/bash

clear

if ! [ -d "dbs" ]; then
    mkdir dbs
fi

cd dbs

PS3="Please select an option: "

options=("Create DB" "List DBs" "Drop DB" "Connect DB" "Exist")

select opt in "${options[@]}"
do
    case $opt in
        "Create DB")
            source ../createdb.sh
            ;;
        "List DBs")
            source ../listdbs.sh
            ;;
        "Drop DB")
            echo "Drop DB"
            ;;
        "Connect DB")
            echo "Connect DB"
            ;;
        "Exist")
            break
            ;;
        *)
            echo "Invalid option $REPLY"
            ;;
    esac
done
