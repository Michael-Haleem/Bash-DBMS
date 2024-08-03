#! /bin/bash

source ../../utilities_functions.sh

clear

files=(`ls | grep -v '\.meta$'`)

if [ ${#files[@]} -eq 0 ]; then
  echo -e "This database doesn't have tables to select from\n"
  print_tablemainmenu
  continue
fi

PS3="Select a Table to delete from or press 0 then press Enter to return to table main menu:"
select file in "${files[@]}";
do
  if [[ -n "$file" ]]; then
        clear
        PS3="Choose an Option or press 0 then press Enter to return to the previous menu: "

        select opt in "All" "Based on a condition"; do
            case $REPLY in
                1)
                    > "$file"
                    clear
                    echo -e "table data deleted successfully\n"
                    break
                    ;;
                2)
                    clear
                    read -rp "enter condition column name: " col_name
                    fnum=$(awk -F: -v col_name="$col_name" '$1 == col_name {print NR - 1}' "$file.meta")
                    
                    if [[ $fnum == "" ]]
                    then
                        clear
                        echo -e "Column Not Found\n"
                        break
                    else
                        read -rp "Enter condition value: " val
                        res=$(awk -F: -v fnum="$fnum" -v val="$val" '{if ($fnum == val) print $fnum}' "$file" 2> /dev/null)
                        if [[ $res == "" ]]
                        then
                        clear
                        echo -e "Value Not Found\n"
                        break
                        else
                        NR=$(awk -F: -v fnum="$fnum" -v val="$val" '{ if ($fnum == val) print NR}' "$file")
                        clear
                        sed -i "${NR}d" "$file"
                        echo -e "Row with $col_name = $val in $file table deleted successfully\n"
                        break
                        fi
                    fi             
                    ;;
                0)
                    clear
                    break
                    ;;
                *)
                    echo "Invalid selection. Please try again."
                    ;;
            esac
        done

        PS3="Select a Table to delete from or press 0 then press Enter to return to table main menu:"
  elif [ $REPLY -eq 0 ]; then
        clear
        print_tablemainmenu
        break
  else
    echo "Invalid selection. Please try again."
  fi
  print_numbered_files "${files[@]}"
done