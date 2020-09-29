 IFS=$'\n'; for f in $(find . -type d); do pushd "$f" > /dev/null; if [[ -d .git  &&  $(git status -s . 2> /dev/null | wc -l) != 0 ]]; then echo $f ; fi; popd > /dev/null; done
