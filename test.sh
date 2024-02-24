#!/bin/bash

##  Testing stuff

##  Get current folder
#currentDir=${PWD##*/}
#currentDir=${result:-/}
#echo $currentDir

function fillArray() {
    declare -n arrayName=$1

    for i in 0 1 2 3; do
        arrayName+=("new item $i")
    done

    echo "Tot items in function: ${#arrayName[@]}"
    for item in "${arrayName[@]}"; do
        echo $item
    done
    echo
}

myArray=("my item 0" "my item 1")

fillArray myArray

echo "Tot items in main: ${#myArray[@]}"
for item in "${myArray[@]}"; do
    echo $item
done
