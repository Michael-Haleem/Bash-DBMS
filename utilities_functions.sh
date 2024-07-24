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

print_tablemainmenu(){
    echo -e "1) Create Table\n2) List Tables\n3) Drop Table\n4) insert into Table\n5) Select Table\n6) Select From Table\n7) Delete From Table\n8) Return To MainMenu"
}

cleanup_mate_files() {
    for meta_file in *.meta; do

        base_file="${meta_file%.meta}"

        if [[ ! -e "$base_file" ]]; then
            rm "$meta_file" 2>/dev/null
        fi
    done
}

