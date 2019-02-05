:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBTeg


cd example

call makefileeg.bat


cd ..


xelatex.exe  GBT7714-2015eg.tex

::call makeclear

