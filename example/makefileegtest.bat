:: Copyright (c) 2012-2016 hzz

@echo off

IF NOT EXIST gb7714-2015.bbx (
copy ..\gb7714-2015.bbx . /y
copy ..\gb7714-2015.cbx . /y
copy ..\gb7714-2015ay.bbx . /y
copy ..\gb7714-2015ay.cbx . /y
)


:: compile the tex file

xelatex.exe --synctex=-1 egtest.tex
biber egtest
xelatex.exe --synctex=-1 egtest.tex

del *.bbx /Q
del *.cbx /Q





