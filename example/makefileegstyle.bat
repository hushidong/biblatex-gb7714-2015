@echo off

rem 用于测试英文中文分别采用两种样式的情况
rem 即测试gb7714-2015ms
rem 需要biblatex3.10以上版本，即从texlive2018开始，而texlive2017中的biblatex3.7也不会报错，但一些细节可能没有支持。

copy ..\gb7714-2015.bbx . /y
copy ..\gb7714-2015.cbx . /y
copy ..\gb7714-2015ay.bbx . /y
copy ..\gb7714-2015ay.cbx . /y
copy ..\gb7714-2015ms.bbx . /y
copy ..\gb7714-2015ms.cbx . /y
copy ..\gb7714-2015-gbk.def . /y


echo compiled files info: > makerecord.dat



setlocal enabledelayedexpansion
for  %%a in ( eg-opt*.tex ) do (
call makeclear
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



call makeclear


del *.bbx /Q
del *.cbx /Q
del *.def /Q
del cls-*.bib /Q
del opt*.bib /Q
del eg-opt*.bib /Q
del code*.bib /Q
del test*.bib /Q



::pause
