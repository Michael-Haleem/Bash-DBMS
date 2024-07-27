#! /bin/bash

source ../../utilities_functions.sh

clear

files=(`ls | grep -v '\.meta$'`)

if [ ${#files[@]} -eq 0 ]; then
  echo -e "This database doesn't have tables to select from\n"
  print_tablemainmenu
  continue
fi

PS3="Select a table to update or press 0 then press Enter to return to table main menu:"
select file in "${files[@]}";
do
  if [[ -n "$file" ]]; then
    clear
    pk_col=$(get_col_name "$file" 1)
    while true
    do
        read -p "Enter the column $pk_col value for the row you want to update or type exit and press Enter to return to previous menu: " val

        if [ "$val" = "exit" ]; then
            clear
            break
        fi

        col_type=$(get_col_type "$file" 1)
        if check_type "$col_type" "$val"; then
            if check_value_exists "$file" 1 "$val"; then

                res=$(get_full_table "$file")
                echo
                row=$(filter_table_rows "$res" 1 "1" "$val")
                echo "$row"
                row_num=$(grep -n "$row" "$file" | cut -d: -f1)
                echo
                while true
                do
                    echo "Choose a column to update or press 0 then press enter to retrun to previous choice"
                    col_names=$(get_table_header $file)
                    col_names=$(echo "$col_names" | sed "s/$pk_col//g")
                    create_select_menu "$col_names"
                    return_val=$?
                    if [ $return_val -eq 0 ]; then
                        clear
                        break
                    fi
                    selected_col=$(( $return_val + 1 ))
                    oldval=$(echo "$row" | awk -F'::' -v col="$selected_col" 'NR > 1 {print $col}')
                    read -p "please enter the new value: " newval
                    col_type=$(get_col_type "$file" "$selected_col")

                    if check_type "$col_type" "$newval"; then
                        echo
                        sed -i "${row_num}s/${oldval}/${newval}/" "$file"
                        clear
                        echo "row after update: "
                        echo
                        res=$(get_full_table "$file")
                        filter_table_rows "$res" 1 "1" "$val"
                        echo    
                    else
                        echo
                        echo "Entered value data type does not match the column value. Please enter a valid value."
                        echo
                    fi
                done
                PS3="Select a table to update or press 0 then press Enter to return to table main menu:"
            else 
                echo
                echo "There is no row with $pk_col value of $val. please enter another value."
                echo
            fi
        else
            echo
            echo "Entered value data type does not match the column value. Please enter a valid value."
            echo
        fi
    done
  elif [ "$REPLY" == "0" ]; then
    clear
    print_tablemainmenu
    break
  else
    echo "Invalid selection. Please try again."
  fi
  print_numbered_files "${files[@]}"
done