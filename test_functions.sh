#!/bin/bash

##  I don't know if I can get this going with global array. It works when placed in the main script.

source ctos-functions

get_list() {
    ##  Fill array
    lineBreak="<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"
    thLocation=$1
    thPrefix=$2
    thExtention=$3
    thFiles=()
    echo "The Path: " $thLocation
    echo "The Prefix: " $thPrefix
    echo "The Extention: " $thExtention
    newFileLocation=$(ls -t $thLocation$thPrefix*.$thExtention | head -1)
    echo $lineBreak
    newFile=${newFileLocation##*/}
    echo "Here is the newest file: " $newFile
    for f in $thLocation$thPrefix*.$thExtention; do
        fileName=${f##*/}
        if [ "$fileName" != "$newFile" ]; then
            thFiles+=($fileName)
        fi
    done
    ##  make delimited string
    echo $lineBreak
    echo "Here are all the $thExtention files apart from the newest one."
    echo "Total files in function: ${#thFiles[@]}"
    count=0
    thFilesString=""
    for i in "${thFiles[@]}"; do
        echo "File $((count+1)): "$i
        thFilesString="${thFilesString}${i},"
        ((count++))
    done
    echo $lineBreak
    echo "The string to be passed:"
    echo "$thFilesString"
    eval "$4=$thFilesString"
}
