:: Copyright (c) 2012-2016 hzz

@echo off

:: compile the tex file

xelatex.exe --synctex=-1 biblatex-gb7714-2015-beamer.tex

::pause

biber biblatex-gb7714-2015-beamer

::pause

xelatex.exe --synctex=-1 biblatex-gb7714-2015-beamer.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015-beamer.tex

:: clear aux files

call gbtclear

:: compile the tex file

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

::pause

biber biblatex-gb7714-2015ay-beamer

::pause

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

:: clear aux files

call gbtclear