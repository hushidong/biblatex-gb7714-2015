:: Copyright (c) 2012-2016 hzz

@echo off


:: compile the tex file

call makeclear

::pause

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

:: clear aux files

::call makeclear



:: compile the tex file

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay.tex

biber biblatex-gb7714-2015ay

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015ay.tex

:: clear aux files

::call makeclear