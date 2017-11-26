#!/bin/bash
# Copyright (c) 2012-2016 hzz

# exec path for tex live 2016
export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

#compile the tex file

xelatex --synctex=-1 biblatex-gb7714-2015.tex
biber biblatex-gb7714-2015
xelatex --synctex=-1 biblatex-gb7714-2015.tex
#to do it again for backref 
xelatex --synctex=-1 biblatex-gb7714-2015.tex

#clear aux files

./makeclear.sh


