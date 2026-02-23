#! /bin/bash  
flag="Y"
count=0
sum1=0
sum2=0
sum3=0
sum4=0
sum5=0
all=0
while [ "$flag" == "Y" ]
do	
	echo -e "\n"
	echo -n "Please give the name of the directory: "
	read dir	

	#First question
	echo -e "\nFirst list"
	echo -n "Files Found: "
	find $dir -type f  -perm $1 |  wc -l 
	add=`find $dir -type f  -perm $1 |  wc -l`
	sum1=$(( sum1+add ))
	echo -e "\n"
	find $dir -type f  -perm $1 
	echo -e "\n"
	all=$(( all+sum1 ))


	#Second question
	echo "Second list"
	echo -n "files found: "
	find $dir -type f -mtime -"$2" | wc -l
	add=`find $dir -type f -mtime -"$2" | wc -l`
	sum2=$(( sum2+add ))
	echo -e "\n"
	find $dir -type f -mtime -"$2" 
	echo -e "\n"
	all=$(( all+sum2 ))
	
	
	#Thrid question
	echo "Third list"
	echo -n "files found: "
	find $dir -type d -atime -"$2" | wc -l
	add=`find $dir -type d -atime -"$2"  | wc -l`
	sum3=$(( sum3+add ))
	echo -e "\n"
	find $dir -type d -atime -"$2" 
	echo -e "\n"
	all=$(( all+sum3 ))
	
	
	#Fourth question
	echo "Fourth list"
	echo -n "files found: "
	ls -lR $dir | grep -c ^'-r..r..r..' 
	add=`ls -lR $dir  | grep -c  ^'-r..r..r..'`
	sum4=$(( sum4+add ))
	echo -e "\n"
	ls -lR $dir | grep  ^'-r..r..r..' 
	echo -e "\n" 
	all=$(( all+sum4 ))
	
	
	#Fifth question
	echo "Fifth list"
	echo -n "files found: "
	ls -lR $dir | grep -c ^'d.w..w..w.'
	add=`ls -lR $dir | grep -c ^'d.w..w..w.'`
	sum5=$(( sum5+add ))
	echo -e "\n"
	ls -lR $dir | grep  ^'d.w..w..w.'
	echo -e "\n"
	all=$(( all+sum5 ))
	

	#loop check
	echo -n "Again <Y/N>? "
	read flag
	while [ "$flag" != "Y"  -a  "$flag" != "N" ] 
	do
		echo -e "\n"
		echo "Please answer with either a Y or N"
		echo -n "Again <Y/N>? "
		read flag
	done	
done
#Results
echo -e "\nFirst=$sum1"
echo "Second=$sum2"
echo "Third=$sum3"
echo "Fourth=$sum4"
echo "Fifth=$sum5"
echo -e "\nAll the files/directories that were found: $all"