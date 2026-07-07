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




