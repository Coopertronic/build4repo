#!/bin/bash
#set -x
#source test_functions.sh
source ctos-functions
lineBreak="<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"
myLocalRepo="pkgBld/ctos-side-repo"
myArch="x86_64/"
thRepo="$HOME/$myLocalRepo/$myArch"
cd "$PWD"
currentDir=${PWD##*/}
declare -a thFiles
clear
function get_list() {
    ##  Fill array
    lineBreak="<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"
    local thLocation=$1
    local thPrefix=$2
    local thExtention=$3
    #thFiles=()
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
    #thFilesString=""
    for i in "${thFiles[@]}"; do
        echo "File $((count+1)): "$i
        #thFilesString="${thFilesString}${i},"
        ((count++))
    done
    echo $lineBreak
    #echo "The string to be passed:"
    #echo "$thFilesString"
}
##  Testing stuff
if !( get_list $thRepo $currentDir "zst" ); then
    something_wrong
else
    echo "Source functions worked."
    echo "See above for results."
    echo "See what has been passed?"
    to_continue
    echo "Here is the string that was passed:"
    echo "${thFiles[@]}"
fi

#get_list $thRepo $currentDir "zst" returnString ; zstFiles=${returnString}

