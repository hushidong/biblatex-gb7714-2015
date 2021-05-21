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



setlocal enabledelayedexpansion
for  %%a in ( eg*.tex ) do (
call makeclearfig
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
xelatex.exe -no-pdf !jobfile!
biber !jobname!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION



call makeclearfig


del *.bbx /Q
del *.cbx /Q
del *.def /Q
del eg*.bib /Q




::pause
