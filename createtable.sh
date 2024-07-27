#! /bin/bash

source ../../utilities_functions.sh

clear

while true 
do
    echo -n "Enter the Table name or press 0 then press Enter to return to previous menu: "

    read tablename

    if [ "$tablename" = "0" ]; then
        clear
        print_tablemainmenu
        break
    fi

    if validate_name "$tablename"; then

        if ! [ -e "$tablename"  ]; then

            while true
            do
                read -p "Enter the number of fields: " num

                if [[ ! $num =~ ^[0-9]+$ ]]; then
                    echo "Invalid input. Please enter a positive integer."
                else
                    break
                fi
            done

            for ((i = 1; i <= num; i++)); do

                if [ $i -eq 1 ];then

                    while true
                    do                                
                        read -p "Enter primary key field name: " pkname

                        if validate_name "$pkname"; then

                            PS3="Please select the data type of $pkname field: "
                            pktype=""
                            select option in "String" "Integer"; do
                                case $option in
                                    "String"|"Integer")
                                        pktype=$option
                                        break
                                        ;;
                                    *)
                                        echo "Invalid option. Please select 1, 2, or 3"
                                        ;;
                                esac
                            done
                            break;
                        fi
                    done

                    echo "NF:$num" > "$tablename.meta"
                    echo "$pkname:$pktype" >> "$tablename.meta"
                else
                    while true
                    do                                
                        read -p "Enter field $i name: " name

                        if validate_name "$name"; then

                            PS3="Please select the data type of $name field: "
                            type=""
                            select option in "String" "Integer" "Boolean"; do
                                case $option in
                                    "String"|"Integer"|"Boolean")
                                        type=$option
                                        break
                                        ;;
                                    *)
                                        echo "Invalid option. Please select 1, 2, or 3"
                                        ;;
                                esac
                            done
                            break;
                        fi
                    done
                    echo "$name:$type" >> "$tablename.meta"
                fi
            done
            touch "$tablename"
            clear
            print_tablemainmenu
            break
        else
            echo "The name is already taken"
        fi
    fi
done