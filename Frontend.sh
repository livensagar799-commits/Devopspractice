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

dnf install nginx -y &>>$LOG_PATH
VALIDATE $? "nginx installation" 

systemctl enable nginx &>>$LOG_PATH
VALIDATE $? "enable nginx"

systemctl start nginx &>>$LOG_PATH
VALIDATE $? " nginx started "

rm -rf /usr/share/nginx/html/* 
VALIDATE $? " files removed "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_PATH
VALIDATE $? "Source code"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

cp /home/ec2-user/expense-shell/expense.conf /etc/nginx/default.d/expense.conf
VALIDATE $? "Copied expense conf"

systemctl restart nginx
VALIDATE $? "nginx restart"


