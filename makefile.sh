#!/bin/bash
# Copyright (c) 2012-2016 hzz

# exec path for tex live 2016
export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

#compile the tex file
xelatex --synctex=-1 egbibenv-right.tex
biber egbibenv-right
xelatex --synctex=-1 egbibenv-right.tex
xelatex --synctex=-1 egbibenv-left.tex
biber egbibenv-left
xelatex --synctex=-1 egbibenv-left.tex
xelatex --synctex=-1 egbibenv-gb7714-2015.tex
biber egbibenv-gb7714-2015
xelatex --synctex=-1 egbibenv-gb7714-2015.tex

xelatex --synctex=-1 biblatex-gb7714-2015.tex

#pause

biber biblatex-gb7714-2015

#pause

xelatex --synctex=-1 biblatex-gb7714-2015.tex

#to do it again for backref 
xelatex --synctex=-1 biblatex-gb7714-2015.tex

#clear aux files

./makeclear.sh

#compile the tex file

xelatex --synctex=-1 biblatex-gb7714-2015ay.tex

#pause

biber biblatex-gb7714-2015ay

#pause

xelatex --synctex=-1 biblatex-gb7714-2015ay.tex

#to do it again for backref 
xelatex --synctex=-1 biblatex-gb7714-2015ay.tex

# clear aux files

./makeclear.sh
