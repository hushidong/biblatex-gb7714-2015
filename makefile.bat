:: Copyright (c) 2012-2018 hzz

@echo off

title %date% %time% makefile

:: compile the tex file


del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy)



del /q *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk

::pause

echo biblatex-gb7714-2015.tex >> example/makerecord.dat

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex


:: clear aux files

::call makeclear

