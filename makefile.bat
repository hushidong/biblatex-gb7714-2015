:: Copyright (c) 2012-2016 hzz

@echo off

:: compile the tex file

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

::pause

biber biblatex-gb7714-2015

::pause

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

:: clear aux files

del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz