#!/bin/bash

export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

if [-e gb7714-2015.bbx] ; then
	cp ../*.bbx .
	cp ../*.cbx .
fi


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

rm *.bbx
rm *.cbx


