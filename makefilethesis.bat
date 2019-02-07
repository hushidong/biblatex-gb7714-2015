:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBT

cd egthesis

call makecompilethesis.bat

cd ..


xelatex.exe  gbT7714-2015thesis

xelatex.exe  gbT7714-2015thesis
::call makeclear

