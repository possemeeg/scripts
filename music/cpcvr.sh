#!/bin/bash
IFS=$'\n'
SOURCE_BASE="./MP3"
SOURCE_BASE_LEN=${#SOURCE_BASE}
for f in `find $SOURCE_BASE -name cover.jpg`
do
    sd=$(dirname $f)
    #ddir="/media/peter/KINGSTON/Music${sd:$SOURCE_BASE_LEN}"
    ddir="FLAC${sd:$SOURCE_BASE_LEN}"
    #ddir="/mnt/router/Kingston_095152FD_1/Music${sd:$SOURCE_BASE_LEN}"
    d="$ddir"

    echo "Copying $f to $d"
    #f=$(printf '%q' "$f")
    #d=$(printf '%q' "$d")
    #echo $d
    cp $f $d
    cp $f $d/folder.jpg
done
