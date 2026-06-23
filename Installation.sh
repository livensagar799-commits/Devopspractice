#!/bin/bash

USERID=$(id -u)

CHEKC_ROOT(){
    if [ $USERID -ne 0 ]
    then 
        echo "Execute the script with root user"
        exit 1
    fi
}

CHEKC_ROOT

dnf list installed mysql 

if [ $? -ne 0 ]
then
    echo "Mysql is not intalled going to install" 
    dnf install mysql -y
    dnf list installed mysql 
    if [ $? -ne 0 ]
    then
       echo "Mysql not installed check it"
       exit 1
    else
        echo "Mysql installed sucessfully"
    fi      
    exit 1
else 
     echo "Mysql is intalled nothing to do"
fi