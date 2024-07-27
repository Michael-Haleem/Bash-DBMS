#! /bin/bash

source ../../utilities_functions.sh

clear

files=(`ls | grep -v '\.meta$'`)

if [ ${#files[@]} -eq 0 ]; then
  echo -e "This database doesn't have tables to select from\n"
  print_tablemainmenu
  continue
fi

PS3="Select a Table to select from or press 0 then press Enter to return to table main menu:"
select file in "${files[@]}";
do
  if [[ -n "$file" ]]; then

    clear
    echo "Choose an option or press 0 then Enter to return to previous menu"

    options="Select_all_table select_columns select_from_table_based_on_conditions"

    create_select_menu "$options"
    opt_num="$?"
    
    clear
    
    if [ $opt_num -eq "1" ]; then
      clear
      echo "---------------- $file table ----------------"
      awk -F':' 'NR > 1 {if (NR == 2) header=$1; else header=header"::"$1} END {print header}' "$file.meta"
      echo "---------------------------------------------"
      cat $file
      echo "---------------------------------------------"
      echo
      PS3="Select a Table to select from or press 0 then press Enter to return to table main menu:"
    elif [ $opt_num -eq "2" ];then
      clear
      while true
      do
        echo "Choose a column to add to select list or press 0 then Enter to execute or select all"
        col_names=$(get_table_header $file)
        create_select_menu "$col_names"
        selected_col="$?"
        if [ $selected_col -eq "0" ]; then
          # PS3="Select a Table to select from or press 0 then press Enter to return to table main menu:"  
          clear
          break
        fi
        cols="$cols $selected_col"
      done
      echo "---------- Result ----------"
      get_table_col "$file" "$cols"
      echo "----------------------------"
      cols=""
      echo
      PS3="Select a Table to select from or press 0 then press Enter to return to table main menu:"
    elif [ $opt_num -eq "3" ];then
      clear
      res=$(get_full_table $"$file")
      while true
      do
        echo "Choose a column to add to the filter or press 0 then Enter to return to table menu"
        col_names=$(get_table_header $file)
        create_select_menu "$col_names"
        selected_col="$?"
        if [ $selected_col -eq "0" ]; then
          PS3="Select a Table to select from or press 0 then press Enter to return to table main menu:"  
          clear
          break
        fi
        col_type=$(get_col_type "$file" "$selected_col")
        type_operations=$(get_operations "$col_type")
        echo "Please select an operation"
        create_select_menu "$type_operations"
        selected_opr="$?"
        while true
        do
          read -p "Please enter the value to perform operations on: " val
          if check_type "$col_type" "$val" ;then
            break
          else
            echo "The entered value doesn't match the column data type please enter a valid value."
          fi
        done
        clear
        res=$(filter_table_rows "$res" "$selected_col" "$selected_opr" "$val")
        echo "---------- Result ----------"
        echo "$res"
        echo "----------------------------"
        echo
      done
    fi
  elif [ "$REPLY" == "0" ]; then
    clear
    print_tablemainmenu
    break
  else
    echo "Invalid selection. Please try again."
  fi
  print_numbered_files "${files[@]}"
done