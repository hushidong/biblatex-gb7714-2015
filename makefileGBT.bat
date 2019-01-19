:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBT

cd egfigure

call makefileGBT.bat

cd ..


xelatex.exe  GBT7714-2015.tex

::call makeclear

