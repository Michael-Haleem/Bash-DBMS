#! /bin/bash

validate_name(){

    if [[ "$1" =~ ^[0-9] || ! "$1" =~ ^[a-zA-Z0-9]+$ || "$1" =~ \  ]]; then
        echo "Invalid name: Must be alphanumeric and cannot start with a number or have spaces."
        return 1
    else
        return 0
    fi
}

print_mainmenu(){
    echo -e "1) Create DB\n2) List DBs\n3) Drop DB\n4) Connect DB\n5) Exist"
}