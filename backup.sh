#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)



USAGE (){
    echo "USAGE : sh 19-backup.sh <source> <destination> <days(optional)>"
    exit 1
}

if [ $# -lt 2 ]
then 
    USAGE
    exit 1
fi

if [ -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR  exist"
else
    echo "$SOURCE_DIR does not exist"
    exit 1 
fi

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR does not exist"
    exit 1
else
    echo "$DEST_DIR  exist"
fi

Log_Files=$(find $SOURCE_DIR -name "*.log" -mtime +14)

if [ ! -z $Log_Files  ]
then
    echo " files more than $DAYS are present"
    ZIP_FILES="$DEST_DIR/app_log-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +14 | zip $ZIP_FILES -@

    if [ -f $ZIP_FILES ]
    then 
        echo " files are zipped"
    else
        echo " zipping files failed"
    fi
        
else
    echo "fiels more than $DYAS does not present"
fi

    





