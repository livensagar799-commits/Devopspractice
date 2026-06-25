#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if ( $USERID -nq 0 )
    then
        echo "Execute the script with root user"
    fi
}

CHECK_ROOT

for package in &@ 
do
  dnf intall $package -y
done