:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBT

cd ..

cd egthesis

call makecompilethesis.bat

cd ..


cd tool

xelatex.exe  gbT7714-2015thesis

xelatex.exe  gbT7714-2015thesis
::call makeclear


python -m diff_pdf_visually -v gbT7714-2015thesis.pdf stdgbT7714-2015thesis.pdf >stdGBthesis.log

