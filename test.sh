#!/bin/bash

source test_functions.sh
source ctos-functions
lineBreak="<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>"
myLocalRepo="pkgBld/ctos-side-repo"
myArch="x86_64/"
thRepo="$HOME/$myLocalRepo/$myArch"
cd "$PWD"
currentDir=${PWD##*/}
clear
##  Testing stuff

if !( get_list $thRepo $currentDir "zst" ); then
    something_wrong
else
    echo "Source functions worked."
    echo "See above for results."
    echo "See what has been passed?"
    to_continue
    echo "Here is the string that was passed:"
    echo "$?"
fi
