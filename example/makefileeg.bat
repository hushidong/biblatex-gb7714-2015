@echo off


copy ..\example.bib . /y
copy ..\gb7714-2015.bbx . /y
copy ..\gb7714-2015.cbx . /y
copy ..\gb7714-2015ay.bbx . /y
copy ..\gb7714-2015ay.cbx . /y
copy ..\gb7714-2015ms.bbx . /y
copy ..\gb7714-2015ms.cbx . /y
copy ..\gb7714-2015mx.bbx . /y
copy ..\gb7714-2015mx.cbx . /y
copy ..\chinese-erj.cbx . /y
copy ..\chinese-erj.bbx . /y
copy ..\gb7714-2015-gbk.def . /y
copy ..\gb7714-2005.bbx . /y
copy ..\gb7714-2005.cbx . /y
copy ..\gb7714-2005ay.bbx . /y
copy ..\gb7714-2005ay.cbx . /y
copy ..\gb7714-1987.bbx . /y
copy ..\gb7714-1987.cbx . /y
copy ..\gb7714-1987ay.bbx . /y
copy ..\gb7714-1987ay.cbx . /y


echo compiled files info: > makerecord.dat

setlocal enabledelayedexpansion
for  %%a in ( test*.tex ) do (
call makecleareg
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makerecord.dat
xelatex.exe -no-pdf !jobfile!
biber !jobname!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

setlocal enabledelayedexpansion
for  %%a in ( cls*.tex ) do (
call makecleareg
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makerecord.dat
xelatex.exe -no-pdf !jobfile!
biber !jobname!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

setlocal enabledelayedexpansion
for  %%a in ( opt*.tex ) do (
call makecleareg
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makerecord.dat
xelatex.exe -no-pdf !jobfile!
biber !jobname!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

setlocal enabledelayedexpansion
for  %%a in ( code*.tex ) do (
call makecleareg
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makerecord.dat
pdflatex.exe !jobfile!
biber !jobname!
pdflatex.exe !jobfile!
pdflatex.exe !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

call makecleareg


del *.bbx /Q
del *.cbx /Q
del *.def /Q
del cls-*.bib /Q
del opt*.bib /Q
del code*.bib /Q
del test*.bib /Q



::pause
