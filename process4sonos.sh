SRCDIR=./7dig

function ensdir() {
   [ -d "${1%/*}" ] || mkdir -p "${1%/*}"
}

function process() {
  S16="$(echo $1 | sed 's|^./7dig|./s16|')"
  MP3="$(echo ${1/%flac/mp3} | sed 's|^./7dig|./mp3|')"
  
  echo "Source: $1"

  eval $(ffprobe -v error -show_entries stream=sample_fmt -of default=noprint_wrappers=1 "$1")
  eval $(ffprobe -v error -show_entries stream=sample_rate -of default=noprint_wrappers=1 "$1")

  ensdir "${S16}"

  if [[ ("$sample_fmt" == "s32") || ("$sample_rate" -gt "44100") ]]
  then
      ffmpeg -i "$1" -c:a flac -sample_fmt s16 -ar 44100 "${S16}"
  else
      cp "$1" "${S16}"
  fi

  ensdir "${MP3}"
  ffmpeg -i "$1" -qscale:a 0 "${MP3}"
}

export -f ensdir
export -f process


#find . -name "*.flac" -path "*7dig*" -type f -exec ls {} \;
#find . -name "*.flac" -type f -path "*7dig*" -exec bash -c 'ensdir "crap"' \;
#find . -name "*.flac" -or -name "*.wav" -path "*7dig*" -type f -exec bash -c 'ensdir "crap"' \;
find . \( -name "*.flac" -or -name "*.wav" \) -path "*7dig*" -type f -exec bash -c 'process "{}"' \;
