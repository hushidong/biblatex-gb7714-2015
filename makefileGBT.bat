:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBT

cd egfigure

call makecompileGBT.bat

cd ..


xelatex.exe  GBT7714-2015.tex

xelatex.exe  GBT7714-2015ms.tex

::call makeclear

