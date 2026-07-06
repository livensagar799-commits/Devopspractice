#!/bin/bash

SOURCE_DIR="/home/ec2-user/logs"

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

if [ -d $SOURCE_DIR ]
then 
    echo -e "$SOURCE_DIR $G Exists $N"
else
    echo "$SOURCE_DIR $R does not Exists $N"
fi

Log_Files=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files : $Log_Files"




while IFS= read -r files
do
   echo "deleting file : $files"
   rm -rf "$files"
done <<< "$Log_Files"