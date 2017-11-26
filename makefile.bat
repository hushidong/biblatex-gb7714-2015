:: Copyright (c) 2012-2016 hzz

@echo off


:: compile the tex file

call makeclear

::pause

echo biblatex-gb7714-2015.tex >> makecompilerec.dat

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

:: clear aux files

::call makeclear

