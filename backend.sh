#!/bin/bash

LOG_PATH="/var/log/expense"
Scritpname=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOG_PATH/$Scritpname-$TIMESTAMP.log"

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "persmission denied" | tee -a &>>LOG_FILE
        exit 1
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo " $2 is failed " | tee -a &>>LOG_FILE
    else 
        echo " $2 is success " | tee -a &>>LOG_FILE
}

USER_VALIDATION(){
    id -$1
    if [ $? -e 0]
    then
        echo "user  $1 created successfully "
        exit 1
    else
        echo "user $1 created successfully "
    fi
}
mkdir -p $LOG_PATH

dnf module disable nodejs -y &>>LOG_FILE
VALIDATE $? "disabled nodejs"  tee -a &>>LOG_FILE
dnf module enable nodejs:20 -y  &>>LOG_FILE
VALIDATE $? "Enabled nodejs:20" tee -a &>>LOG_FILE
dnf install nodejs -y  &>>LOG_FILE
VALIDATE $? "Nodejs installed" tee -a &>>LOG_FILE


USER_VALIDATION expense 

mkdir /app
VALIDATE $? "directory created"
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>LOG_FILE
VALIDATE $? "Source code downloaded"
cd /app
rm -rf *
unzip /tmp/backend.zip &>>LOG_FILE
npm install &>>LOG_FILE
VALIDATE $? "npm installed"
cp /home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service
systemctl daemon-reload &>>LOG_FILE
VALIDATE $? " daemon reloaded "
systemctl start backend &>>LOG_FILE
VALIDATE $? "backend started"
systemctl enable backend &>>LOG_FILE
VALIDATE $? "backend enabled"

dnf install mysql -y &>>LOG_FILE
VALIDATE $? "Mysql installed"
mysql -h mysql.livenawsdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>LOG_FILE
VALIDATE $? "password setup "
systemctl restart backend &>>LOG_FILE
VALIDATE $? "backend restarted"

