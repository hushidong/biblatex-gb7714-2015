#!/bin/bash

export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

for egfile in eg*.tex;
do 
./makeclear.sh
echo "$egfile"
echo "${egfile%.tex}"
xelatex --synctex=-1 "$egfile"
biber "${egfile%.tex}"
xelatex --synctex=-1 "$egfile"
./makeclear.sh;
done



