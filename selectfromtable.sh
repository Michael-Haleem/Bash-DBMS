#! /bin/bash

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
        echo "-----------------------------------------"
        awk -F':' 'NR > 1 {print $1}' $file.meta | paste -sd ':';
        echo "-----------------------------------------"
        cat $file
        echo "-----------------------------------------"
        echo
  elif [ $REPLY -eq 0 ]; then
        clear
        print_tablemainmenu
        break
  else
    echo "Invalid selection. Please try again."
  fi
  print_numbered_files "${files[@]}"
done