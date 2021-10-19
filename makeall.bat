:: Copyright (c) 2012-2016 hzz

@echo off

title %date% %time% makefileall

if exist *.userbak (
    del *.userbak /Q
)
FOR %%c IN (gb*.pdf) DO (
    copy /Y "%%c" "%%c.userbak"
)
if exist gb*.pdf (
    del gb*.pdf /Q
)

::pause

cd example

call makefileeg

call makefileegstyle.bat

cd ..

cd egfigure

call makecompilefig.bat

call makecompileGBT.bat

cd ..

cd egphoto

call makecompileph.bat


cd ..

cd egthesis

call makecompilethesis.bat

cd ..


echo biblatex-gb7714-2015.tex >> example/makerecord.dat

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe biblatex-gb7714-2015.tex

cd tool

xelatex.exe gbT7714-2015.tex

xelatex.exe gbT7714-2015ms.tex

xelatex.exe gbT7714-2015eg.tex

xelatex.exe gbT7714-2015eg.tex

xelatex.exe gbT7714-2015fmt.tex

xelatex.exe gbT7714-2015fmt.tex

xelatex.exe gbT7714-2015lan.tex

xelatex.exe gbT7714-2015lan.tex

xelatex.exe gbT7714-2015thesis.tex

xelatex.exe gbT7714-2015thesis.tex

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)

python -m diff_pdf_visually -v gbT7714-2015.pdf stdgbT7714-2015.pdf >stdGB.log

python -m diff_pdf_visually -v gbT7714-2015eg.pdf stdgbT7714-2015eg.pdf >stdGBeg.log

python -m diff_pdf_visually -v gbT7714-2015fmt.pdf stdgbT7714-2015fmt.pdf >stdGBfmt.log

python -m diff_pdf_visually -v gbT7714-2015lan.pdf stdgbT7714-2015lan.pdf >stdGBlan.log

python -m diff_pdf_visually -v gbT7714-2015thesis.pdf stdgbT7714-2015thesis.pdf >stdGBthesis.log

