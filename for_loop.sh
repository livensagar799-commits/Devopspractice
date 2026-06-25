#!/bin/bash

USERID=$(id -u)
LOG_PATH=/var/log/rpminstallation
Scritpname=$(echo "$0" | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_PATH/$Scritpname-$TIMESTAMP.log"
mkdir -p /var/log/rpminstallation

CHECK_ROOT(){
    if [ $USERID -ne 0 ] 
    then
        echo "Execute the script with root user" | tee -a $LOG_FILE
    fi
    }



CHECK_ROOT
if [ $# -eq 0 ]
     then
         echo "USAGE :: sh $0 packagename1 packagename2" | tee -a $LOG_FILE
         exit 1
      fi
for package in $@
do
  dnf list installed $package &>>$LOG_FILE
  if [ $? -ne 0 ]
  then
    echo "$package is not installed going to intall" | tee -a $LOG_FILE
    dnf install $package -y &>>$LOG_FILE
    exit 1
  else 
    echo "$package is already installed ...nothing to do" | tee -a $LOG_FILE
  fi
done