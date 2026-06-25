#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ] 
    then
        echo "Execute the script with root user"
    fi
    }

USAGE(){
    if [ $# -e 0]
    then
        echo "USAGE :: sh $0 packagename1 packagename2"
    fi
    }

CHECK_ROOT

for package in $@
USAGE
do
  dnf list installed $package 
  if [ $? -ne 0]
  then
    echo "$package is not installed going to intall"
    dnf intall $package -y
  else 
    echo "$package is already installed ...nothing to do"
  fi
done