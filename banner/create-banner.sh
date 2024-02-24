#!/bin/bash

#toilet -d "$script_dir" -f epic -F metal Debian >debian-bannert.txt

POSITIONAL=()
while (($# > 0)); do
    case "${1}" in
    -h | --help)
        echo flag: "${1}"
        shift # shift once since flags have no values
        ;;
    -l | --list)
        echo flag: "${1}"
        shift # shift once since flags have no values
        ;;
    -s | --switch)
        numOfArgs=1 # number of switch arguments
        if (($# < numOfArgs + 1)); then
            shift $#
        else
            echo "switch: ${1} with value: ${2}"
            shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
        fi
        ;;
    *) # unknown flag/switch
        POSITIONAL+=("${1}")
        shift
        ;;
    esac
done

set -- "${POSITIONAL[@]}" # restore positional params

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
filters=(
    "crop"   #crop unused blanks
    "gay"    #add a rainbow colour effect
    "metal"  #add a metallic colour effect
    "flip"   #flip horizontally
    "flop"   #flip vertically
    "180"    #rotate 180 degrees
    "left"   #rotate 90 degrees counterclockwise
    "right"  #rotate 90 degrees clockwise
    "border" #surround text with a border
)

#for item in "${filters[@]}"; do
#    toilet -d "$script_dir" -f epic -F "$item" Debian >>debian-bannert.txt
#done
