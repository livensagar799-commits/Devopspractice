#!/bin/bash

LOG_PATH="/var/log/expense"
Scritpname="echo $0 || cut -d "." -f1"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_PATH/$Scritpname-$TIMESTAMP.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if ( $USERID -ne 0)
    then
        echo "Permission denied"
    fi
}



VALIDATE(){
    if ( $1 -ne 0)
    then 
        echo -e "$2 is...$R FAILED $N"  | tee -a $LOG_FILE
    else
        echo -e "$2 is... $G SUCCESS $N" | tee -a $LOG_FILE
    fi
}

CHECK_ROOT

echo "Script started executing at: $(date)" | tee -a $LOG_FILE

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing MySQL Server"
systemctl enable mysqld
VALIDATE $? "Enabled mysqld"
mysql -h mysql.livenawsdevops.online -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE
if ( $? -ne 0)
then
    echo "MySQL root password is not setup, setting now" &>>$LOG_FILE
    mysql_secure_installation --set-root-pass ExpenseApp@1
    VALIDATE $? "Setting UP root password"
else 
    echo -e "MySQL root password is already setup...$Y SKIPPING $N" | tee -a $LOG_FILE
fi
