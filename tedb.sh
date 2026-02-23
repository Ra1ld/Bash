#!/bin/bash



if [ "$1" == "-a" ]; then
	echo -n "Please enter the first name: "
	read first
	echo -n "Please enter the last name: "
	read last
	echo -n "Please enter the town: "
	read town
	echo -n "Please enter the telephone number: "
	read tel
	echo "$first $last $town $tel" >> catalog.txt
elif [ "$1" == "-l" ]; then
	grep -i [0-9,a-z]  catalog.txt | cat -n
elif [ "$1" == "-s" ]; then
	if [ "$2" -ge 5  -o  "$2" -le 0 ]; then
		echo "Invalid second parameter: $2"
		echo "Second parameter surpasses the number of columns(1-4)"
	else 	
		sort -k"$2" catalog.txt
	fi	
elif [ "$1" == "-c" ]; then
	c=`grep -c $2 catalog.txt`
	if [ $c -eq 0 ]; then
		echo "No lines found containing the keyword $2"
	else
		grep $2 catalog.txt
	fi		
elif [ "$1" == "-d" ]; then
	c=`grep -c $2 catalog.txt`	
	if [ $c -eq 0 ]; then
		echo "No lines found containing the keyword $2"
	else	 
		if [ "$3" == "-b" ]; then
			sed -i "s/.*$2.*//" catalog.txt 
			echo "Line replaced!"
		elif [ "$3" == "-r" ]; then
			sed -i '/'"$2"'/d' catalog.txt
			echo "Line Deleted!"
		else
			echo "This option $3 is invalid"
		fi
	fi	
elif [ "$1" == "-n" ]; then
	emp=`grep -c '^\s*$' catalog.txt`
	if [ $emp -eq 0 ]; then
		echo "No empty lines found"
	else	
		echo "Empty lines found : $emp"	
		echo -en "Do you wish to delete them? <Y/N>? "
		read  del
		while [ $del != "Y" -a  $del != "N" ]
		do
			echo -e "\nWrong input"
			echo -n "Please answer either with Y or N <Y/N> "
			read del
		done	
		if [ $del == "Y" ]; then
			sed -i '/^\s*$/d' catalog.txt
			echo -e "\nEmpty lines deleted"
		fi	
	fi	
else
	clear
	echo "************************************************************************************************************************************************************************"
	echo -e '\033[1mUsage Manual\033[0m \n\n'
	echo -e '\033[1mDescription\033[0m'
	echo -e "	This script works as a telephone database allowing you to add/edit/show registrations based on input(options)\n"
	echo -e "	All registrations are stored into a file, and look like this: {First_name}  {Last_name}  {Town}  {Telephone_number}"
	echo -e '\033[1mOptions\033[0m \n'
	echo -e '\033[1m   -a\033[0m  Adds a new registration\n'
	echo -e '\033[1m   -l\033[0m  Shows the current database registrations\n'
	echo -e '\033[1m   -s --second parameter\033[0m'
	echo -e "       Same as -l but sorted based on a second parameter that inidacates the column to be sorted with\n"
	echo -e '\033[1m   -c --second parameter\033[0m'
	echo -e "       Shows registrations based on a keyword(second parameter)\n"
	echo -e '\033[1m   -d, --second parameter, --third parameter\033[0m'
	echo -e "       Delete or replace registrations based on a keyword(second parameter). Registrations can only be replaced"
	echo -e "       either with an empty line(-b as thrid parameter) or just be deleted(-r as third parameter)\n"
	echo -e '\033[1m   -n\033[0m shows how many empty registrations are stored in the database and asks to delete them\n'	
	echo -e '\033[1mExamples\033[0m'
	echo -e "       ./teldb.sh -d George -b\n"  
	echo -e "       ./teldb.sh -s 1\n"    
	echo -e "       ./teldb.sh -c Mamalis\n"   	
	echo -e '\033[1mImportant notes\033[0m'	
	echo -e "	The script is case sensitive so keywords and parameters that dont match exactly, will not work! \n"
	echo -e "	e.g George is not the same as george"
	echo -e "	    -a is not the same as -A \n"
	echo -e '\033[1mAuthor\033[0m'
	echo -e "	Programmed by George Tassios. An undergraduate student of Universtiy of West Attica"
fi	

		