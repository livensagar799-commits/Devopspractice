#!/bin/bash

USERID=$(id -u)

if [ $USERID -neq 0]
then
    echo "Execute the script with root user"
    exit 1
fi

dnf install mysql

if [ $? -neq 0]
then 
    echo "Mysql is intalled nothing to do"
    exit 1
else 
    echo "Mysql is not intalled going to install"
fi