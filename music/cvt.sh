#!/bin/bash
IFS=$'\n'
SOURCE_BASE="./FLAC"
SOURCE_BASE_LEN=${#SOURCE_BASE}
for f in `find $SOURCE_BASE -name *.flac`
do
    sd=$(dirname $f)
    ddir="MP3${sd:$SOURCE_BASE_LEN}"
    d="$ddir/$(basename ${f%.*}).mp3"
    if [ -f "$d" ]; then
        echo "Skipping $d because it exists."
    else
        if [ ! -d "$ddir" ]; then
            echo "mkdir $ddir"
            mkdir -p "$ddir"
        fi
        echo "$f >> $d"
        flac -cd "$f" | lame -b 320 - "$d"

        #copy tags
        eval $(metaflac --export-tags-to - "$f" |sed "s/'/'\\\''/g" |sed "s/=\(.*\)/='\1'/")
        id3v2 -a"$ARTIST" -A"$ALBUM" -t"$TITLE" -T"$TRACKNUMBER/$TRACKTOTAL" --TPE2 "$ALBUMARTIST" "$d"
    fi
done
