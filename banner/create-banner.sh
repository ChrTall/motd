#!/bin/bash

#toilet -d "$script_dir" -f epic -F metal Debian >debian-bannert.txt

POSITIONAL=()
while (($# > 0)); do
    case "${1}" in
    -h | --help)
        echo flag: "${1}"
        shift # shift once since flags have no values
        ;;
    -f | --file-output)
        fileOutput=true
        shift # shift once since flags have no values
        ;;
    -F | --filter)
        numOfArgs=1 # number of switch arguments
        if (($# < numOfArgs + 1)); then
            shift $#
        else
            filter="${2}"
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

if [ "${#POSITIONAL[@]}" -eq 1 ]; then
    bannerName=${POSITIONAL[0]}
else
    echo "You must specify the banner name"
    exit 1
fi

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

if [ -z ${filter+x} ]; then
    for item in "${filters[@]}"; do
        banner=$(toilet -d "$script_dir" -f epic -F "$item" "$bannerName")
        output+="
        ${item}:
        ${banner}"
    done
else
    output=$(toilet -d "$script_dir" -f epic -F "$filter" "$bannerName")
fi

if [ $fileOutput ]; then
    echo "$output" >"${bannerName}-banner.txt"
else
    echo "$output"
fi
