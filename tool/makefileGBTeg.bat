:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBTeg

cd ..

cd example

call makefileeg.bat

call makefileegstyle.bat

cd ..

cd tool


xelatex.exe  gbT7714-2015eg.tex

xelatex.exe  gbT7714-2015eg.tex

xelatex.exe  gbT7714-2015fmt.tex

xelatex.exe  gbT7714-2015fmt.tex

xelatex.exe  gbT7714-2015lan.tex

xelatex.exe  gbT7714-2015lan.tex

::call makeclear


python -m diff_pdf_visually -v gbT7714-2015eg.pdf stdgbT7714-2015eg.pdf >stdGBeg.log

python -m diff_pdf_visually -v gbT7714-2015fmt.pdf stdgbT7714-2015fmt.pdf >stdGBfmt.log

python -m diff_pdf_visually -v gbT7714-2015lan.pdf stdgbT7714-2015lan.pdf >stdGBlan.log



