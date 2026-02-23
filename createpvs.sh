#!/bin/bash

#1: ROOTFOLDER
#2: no_of_DBFOLDERS
#3: no_of_DATAFOLDERS
#4: USERNAME



#Checks
if [ "$#" -eq 4 ]; then 	#parameters=4
	if [ -d "$1" ]; then	#rootfolder($1) exist?
		name=`grep -c "^$4" /etc/passwd`	
		if [ $name -eq 1 ]; then    	#username check[ if name is found one or more times ]
		
			#Creating dbfolders
			c=1
			db=`ls $1 | grep -c "dbfolder*"`
			if [ $db -ge 1 ]; then	
				while [ $c -le $2 ]	#create dbfolders(no overwrite)
				do
					let "db=db+1"
					mkdir $1/dbfolder"$db" 
					ls "dbfolder$db" $1 | sudo chown $4 $1/dbfolder"$db"
					let "c=c+1"
				done	
			else				#create dbfolders(first time)
				while [ $c -le $2 ]	
				do
					mkdir $1/dbfolder"$c" 
					ls "dbfolder$c" $1 | sudo chown $4 $1/dbfolder"$c"
					let "c=c+1"
				done
			fi
			
				
			#Creating datafolders
			c=1
			data=`ls $1 | grep -c "datafolder*"`
			if [ $data -ge 1 ]; then	#create datafolders(no overwrite)
				while [ $c -le $3 ]	
				do
					let "data=data+1"
					mkdir $1/datafolder"$data" 
					ls "datafolder$data" $1 | sudo chown $4 $1/datafolder"$data"
					let "c=c+1"
				done
			else				#create datafolders(first time)
				while [ $c -le $3 ]	
				do
					mkdir $1/datafolder"$c" 
					ls "datafolder$c" $1 | sudo chown $4 $1/datafolder"$c"
					let "c=c+1"
				done
			fi
			
			
			if [ $2 -le -1 ]; then
				echo "You cannot subtract dbfolders"
			else
				echo "$2 dbfolders   added (owner $4)"
			fi	
			
			if [ $3 -le -1 ]; then
				echo "You cannot subtract datafolders"
			else
				echo "$3 datafolders added (owner $4)"
			fi	
			
			
									
		else
			echo "Username $4 does not exist"
		fi		
	else
		echo "Folder path $1 does not exist"
	fi		
else
	echo "You entered $# parameters"
	echo "Please enter only four parameters" 
fi	
