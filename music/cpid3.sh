#!/bin/bash
IFS=$'\n'
SOURCE_BASE="./FLAC"
SOURCE_BASE_LEN=${#SOURCE_BASE}
for f in `find $SOURCE_BASE -name *.flac`
do
    sd=$(dirname $f)
    ddir="MP3${sd:$SOURCE_BASE_LEN}"
    d="$ddir/$(basename ${f%.*}).mp3"

    echo "Copying from flac tags $f to $d"

    eval $(metaflac --export-tags-to - "$f" |sed "s/'/'\\\''/g" |sed "s/=\(.*\)/='\1'/")

    id3v2 -a"$ARTIST" -A"$ALBUM" -t"$TITLE" -T"$TRACKNUMBER/$TRACKTOTAL" --TPE2 "$ALBUMARTIST" "$d"
done

# TITLE=Dream Machines
# ARTIST=Big Deal
# TRACKNUMBER=12
# TRACKTOTAL=16
# ALBUM=Divergent: Original Motion Picture Soundtrack
# MUSICBRAINZ_ALBUMID=c0538d8c-f463-4e3c-ba89-5b479dfce7c9
# MUSICBRAINZ_ALBUMARTISTID=89ad4ac3-39f7-470e-963a-56509c546377
# ALBUMARTIST=Various Artists
# ALBUMARTISTSORT=Various Artists
# MUSICBRAINZ_ARTISTID=c3867418-f669-4952-9384-ce68ee04c5cd
# MUSICBRAINZ_TRACKID=c68ff43d-752a-4fe1-9602-756f84d7728c
# ARTISTSORT=Big Deal
# DISCNUMBER=1
# DISCID=e60e8d10
# MUSICBRAINZ_DISCID=_YTvrtgE9vGhzymqFJy9oMXbLWI-
