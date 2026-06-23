#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then 
        echo "Execute the script with root user"
        exit 1
    fi
}



VALIDATE(){
    if [ $2 -ne 0 ]
    then
       echo -e "$1 \e[31m not installed check it"
       exit 1
    else
        echo -e " $1 installed \e[32m sucessfully"
    fi  
}

INSTALL_PACK(){
dnf list installed $1 

if [ $? -ne 0 ]
then
    echo "$1 is not intalled going to install" 
    dnf installl $1 -y
    dnf list installed $1
    VALIDATE $1 $? 
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
     echo -e "\e[33m $1 is intalled nothing to do"
fi
}
CHECK_ROOT
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