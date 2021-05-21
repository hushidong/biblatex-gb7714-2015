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
for  %%a in ( tgb*.tex ) do (
call makeclearfig
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
xelatex.exe -no-pdf !jobfile!
biber !jobname!
xelatex.exe -no-pdf !jobfile!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION


set bv="false"
biber --version | findstr "2.13" && set bv="true"
biber --version | findstr "2.14" && set bv="true"
echo %bv%

if %bv% == "true" (
xelatex.exe -no-pdf tngbcitationaynew.tex
biber tngbcitationaynew
xelatex.exe -no-pdf tngbcitationaynew.tex
xelatex.exe --synctex=-1 tngbcitationaynew.tex
) else (
xelatex.exe -no-pdf tngbcitationay.tex
biber tngbcitationay
xelatex.exe -no-pdf tngbcitationay.tex
xelatex.exe --synctex=-1 tngbcitationay.tex
)




call makeclearfig


del *.bbx /Q
del *.cbx /Q
del *.def /Q
del eg*.bib /Q




::pause
