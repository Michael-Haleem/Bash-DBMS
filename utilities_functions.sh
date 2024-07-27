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
    echo -e "1) Create Table\n2) List Tables\n3) Drop Table\n4) insert into Table\n5) Select From Table\n6) Delete From Table\n7) Update Table\n8) Return To MainMenu"
}

cleanup_mate_files() {
    for meta_file in *.meta; do

        base_file="${meta_file%.meta}"

        if [[ ! -e "$base_file" ]]; then
            rm "$meta_file" 2>/dev/null
        fi
    done
}

check_type() {
    local type="$1"
    local value="$2"

    case "$type" in
        "String")
            if [[ "$value" =~ ^[a-zA-Z]+$ ]] && [[ "$value" != "true" && "$value" != "false" ]]; then
                return 0  
            else
                return 1  
            fi
            ;;
        "Integer")
            if [[ "$value" =~ ^-?[0-9]+$ ]]; then
                return 0  
            else
                return 1  
            fi
            ;;
        "Boolean")
            if [[ "$value" == "true" || "$value" == "false" ]]; then
                return 0  
            else
                return 1
            fi
            ;;
    esac
}

print_numbered_files() {
  local files=("${@}")
  local i=1
  
  for file in "${files[@]}"; do
    echo "$i) $file"
    ((i++))
  done
}

get_full_table(){
    local table_name=$1
    awk -F':' 'NR > 1 {if (NR == 2) header=$1; else header=header"::"$1} END {print header}' "$table_name.meta"; cat $table_name
}

get_col_index(){
    local table_name=$1
    local col_name=$2
    get_full_table "$table_name" | awk -F: -v col_name="$col_name" '
    NR == 1 {
        for (i = 1; i <= NF; i++) {
            if($i == col_name){
                print i
                exit
            }
        }
    }
  '
}

get_col_name(){
    local table_name=$1
    local col_index=$2

    awk -F: -v col_index="$(($col_index + 1))" 'NR == col_index {print $1}' "$table_name.meta"
}

get_col_type(){
    local table_name=$1
    local col_index=$2
    awk -F: -v col_index="$col_index" '
    NR > 1 {
        if(NR == col_index + 1){
            print $2
            exit
        }
    }
  ' "$table_name.meta"
}

get_table_col() {
  local table_name=$1
  local cols_indices=$2
  
  local awk_script='BEGIN { OFS="::" } { print '
  local index
  local indices=($cols_indices) 
  local loop_index=1

  for index in "${indices[@]}"; do
    if [ $loop_index -ne "1" ]; then
        awk_script+="OFS "
    fi
    awk_script+='$'$index" "
    ((loop_index++)) 
  done

  awk_script+='}'

  get_full_table $table_name | awk -F:: "$awk_script"
}

get_operations(){
    local type=$1

    if [ "$1" = "Integer" ];then
        echo "== != < > <= =>"
    elif [ "$1" = "String" ] || [ "$1" = "Boolean" ];then
        echo "== !="
    fi
}
  
filter_table_rows() {
    # local table_name=$1
    local table=$1
    local col_index=$2
    local operation=$3
    local col_value=$4

    # local col_index=$(get_col_index "$table_name" "$col_name")

    # get_full_table $table_name | awk -F:: -v col_index="$col_index" -v col_value="$col_value" -v operation="$operation" '
    echo "$table" | awk -F:: -v col_index="$col_index" -v col_value="$col_value" -v operation="$operation" '
    NR == 1 {
        print $0
    }
    NR > 1 { 
        if (operation == "1" && $col_index == col_value) {
            print $0
        } else if (operation == "2" && $col_index != col_value) {
            print $0
        } else if (operation == "3" && $col_index < col_value) {
            print $0
        } else if (operation == "4" && $col_index > col_value) {
            print $0
        } else if (operation == "5" && $col_index <= col_value) {
            print $0
        } else if (operation == "6" && $col_index >= col_value) {
            print $0
        }
    }
    '
}

get_table_header(){
    local table_name=$1
    awk -F':' 'NR > 1 {if (NR == 2) header=$1; else header=header" "$1} END {print header}' "$table_name.meta"
}

create_select_menu(){
    local list_values=($1)
    local prompt=$PS3

    PS3="Please select an option: "
    select opt in "${list_values[@]}"
    do
        if [[ -n "$opt" ]]; then
            return "$REPLY"
            break
        elif [ "$REPLY" == "0" ]; then
            return "0"
            break
        else

            echo "Invalid selection. Please try again."
        fi
    done 
    PS3=$prompt
}


check_value_exists() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: check_value_exists <filename> <column_index> <value>"
        return 1
    fi

    local filename="$1"
    local col_index="$2"
    local value="$3"

    awk -F "::" -v col="$col_index" -v val="$value" '
        {
            if ($col == val) {
                found = 1
                exit
            }
        }
        END {
            exit found ? 0 : 1
        }
    ' "$filename"
}

