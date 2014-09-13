#!/bin/bash

IFS=$'\n'
for f in `find . -type f -name *.flac`
do
    newf=$(dirname "$f")/$(basename "$f" | sed -E "s/Disc ([0-9]) - ([0-9]) - (.*)/Disc \1 - 0\2 - \3/")
    if [ "$f" != "$newf" ]
    then
        echo "$f => $newf"
        mv "$f" "$newf"
    fi
done
