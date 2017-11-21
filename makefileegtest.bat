:: Copyright (c) 2012-2016 hzz

@echo off


:: compile the tex file

xelatex.exe --synctex=-1 egtest.tex
biber egtest
xelatex.exe --synctex=-1 egtest.tex



