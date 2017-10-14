FLACDIR=~/Music/src
DESTDIR=~/Music/mp3

for a in *.flac; do
  ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
done
