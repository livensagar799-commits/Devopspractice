#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then 
        echo "Execute the script with root user"
        exit 1
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $2 -ne 0 ]
    then
       echo "$1 not installed check it"
       exit 1
    else
        echo "$1 installed sucessfully"
    fi  
}

INSTALL_PACK(){
dnf list installed $1 

if [ $? -ne 0 ]
then
    echo "$1 is not intalled going to install" 
    dnf installl $1 -y
    dnf list installed $1
    VALIDATE $? 
    # dnf list installed $1 
    # if [ $? -ne 0 ]
    # then
    #    echo "$1 not installed check it"
    #    exit 1
    # else
    #     echo "$1 installed sucessfully"
    # fi      
    exit 1
else 
     echo "$1 is intalled nothing to do"
fi
}

INSTALL_PACK $1
# dnf list installed mysql 

# if [ $? -ne 0 ]
# then
#     echo "Mysql is not intalled going to install" 
#     dnf install mysql -y
#     dnf list installed mysql 
#     if [ $? -ne 0 ]
#     then
#        echo "Mysql not installed check it"
#        exit 1
#     else
#         echo "Mysql installed sucessfully"
#     fi      
#     exit 1
# else 
#      echo "Mysql is intalled nothing to do"
# fi