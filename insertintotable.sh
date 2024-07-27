#!/bin/bash

source ../../utilities_functions.sh

clear

files=(`ls | grep -v '\.meta$'`)

if [ ${#files[@]} -eq 0 ]; then
  echo -e "This database doesn't have tables to insert into\n"
  print_tablemainmenu
  continue
fi

PS3="Select a Table to insert into or press 0 then press Enter to return to table main menu:"
select file in "${files[@]}"; do
  if [[ -n "$file" ]]; then
    clear
    ispk=0
    row=""
    for line in $(cat "$file.meta" | tail -n +2)
    do
        colname=$(echo "$line" | cut -d':' -f1)
        coltype=$(echo "$line" | cut -d':' -f2)

        while true
        do
            read -p "Enter the value for column $colname of type $coltype or type exit then enter to return to previous menu: " value

            val_lower=$(echo "$value" | tr '[:upper:]' '[:lower:]')

            if [ "$val_lower" = "exit" ]; then
            clear
            break 2
            fi
            if check_type $coltype $value ;then

                awk -F: -v value="$value" '$1 == value {found=1; exit} END {if (found) exit 1; else exit 0}' "$file"
                exit_status=$?
                
                if  [ $ispk -eq 0 ] && [ $exit_status -eq 0 ]; then
                    ispk=1
                    row+="$value"
                    break
                elif [ $ispk -eq 1 ];then
                    row+="::$value"
                    break
                else
                    echo "primary key cannot be duplicate; this value already exist"
                fi
            else
                echo "The value entered doesn't match the column datatype"
            fi
        done
    done
    if [ "$val_lower" != "exit" ]; then
      clear
      echo -e "row:\n$row\ninserted successfully\n"
      echo "$row" >> "$file"
    fi
  elif [ $REPLY -eq 0 ]; then
        clear
        print_tablemainmenu
        break
  else
    echo "Invalid selection. Please try again."
  fi

  print_numbered_files "${files[@]}"
done
