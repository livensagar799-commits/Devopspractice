#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Execute the script with root user"
    exit 1
fi

dnf list installed mysql 

if [ $? -ne 0 ]
then
    echo "Mysql is not intalled going to install" 
    dnf install mysql -y
    exit 1
else 
     echo "Mysql is intalled nothing to do"
fi