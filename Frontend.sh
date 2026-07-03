LOG_PATH="/var/log/expense"
SCRIPT_NAME=$(basename "$0" .sh)
TIMESTAMP=$(date)


USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "Permission denied"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo " $2 is failed " | tee -a $LOG_FILE
    else 
        echo " $2 is success " | tee -a $LOG_FILE
    fi
}

CHECK_ROOT
echo " Script started executing $TIMESTAMP "

mkdir -p $LOG_PATH 

LOG_FILE="$LOG_PATH/$SCRIPT_NAME-$TIMESTAMP.log"

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "nginx installation" 

systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "enable nginx"

systemctl start nginx &>>$LOG_FILE
VALIDATE $? " nginx started "

rm -rf /usr/share/nginx/html/*  &>>$LOG_FILE
VALIDATE $? " files removed "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "Source code"

cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOG_FILE
VALIDATE $? "Copied expense conf"

systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "nginx restart"


