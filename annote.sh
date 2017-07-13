#!/bin/bash
#
# Use linux extended attributes to manage tagging and retrieval of research articles

function get_annotation() {
    local query=user.${1}
    local annotation=$(getfattr -d --match=$1 "${*:2}" | sed -n "s/${query}=\"\(.*\)\"/\1/p")
    echo $annotation
}

function set_annotation() {
    attr -s $1 -V "${*:3}" $2
}

function rm_annotation() {
    attr -r $1 $2
}

function search() {
    find $LIBRARY -exec getfattr -d --match=$1 {} + | \
    grep --color=always --ignore-case "${*:2}"
} >&2 

opt=$1
case "$opt" in
    search)
        args=${@:3:${#}-2}
        # Check for user set LIBRARY location
        if [ -z $LIBRARY ]; then
            echo "LIBRARY not set for user"
            exit 1
        fi
        LIBRARY=$(realpath --relative-to=$PWD $LIBRARY)
        search $2 $args 
        ;;
    *) 
        filename="${@: -1}"
        args=${@:3:${#}-3}  
        ;;&
    a+)
        cannotation=$(get_annotation $2 $filename)
        if [ -z "$cannotation" ]; then
            set_annotation $2 "$filename" $args
        else
            set_annotation $2 "$filename" $cannotation $args
        fi
        ;;
    w+)
        if [ -z "$args" ]; then
            echo "Invalid argument"
        else
            set_annotation $2 "$filename" $args
        fi
        ;;
    rm)
        if [ -z "$args" ]; then
            rm_annotation $2 "$filename"
        else
            echo "Invalid argument"
        fi
        ;;
    *)
        echo "Usage: $0 {search|w+|a+|rm}"
        exit 1
esac
