#!/bin/bash
IFS=$'\n'
for i in *
    do 
        error=$(ffmpeg -v error -i "$i" -f null 2>&1 /dev/null)
        #if ! ffmpeg -v error -i "$i" -f null /dev/null;
        if [[ $? -ne 0 ]];
        then
            str=$(echo ${error}|tr '\r\n' ' ')
            printf "%s|%s \n" "$i" "$str"
        fi

#do printf "$i" $(ffmpeg -v error -i "$i" -f null -)
done
