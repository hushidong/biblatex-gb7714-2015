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

del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz
del /q *.nav *.snm *.vrb 

:: compile the tex file

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

::pause

biber biblatex-gb7714-2015ay-beamer

::pause

xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

:: clear aux files

del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz
del /q *.nav *.snm *.vrb 