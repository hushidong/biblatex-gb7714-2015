:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileGBT

cd ..

cd egfigure

call makecompileGBT.bat

cd ..

cd tool

xelatex.exe  gbT7714-2015.tex

xelatex.exe  gbT7714-2015.tex

::call makeclear

python -m diff_pdf_visually -v gbT7714-2015.pdf stdgbT7714-2015.pdf >stdGB.log

