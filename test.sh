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

if !( find_old_pkgs $thRepo $currentDir "zst" ); then
    something_wrong
else
    echo "Source functions worked."
    echo "See above for results."
fi
