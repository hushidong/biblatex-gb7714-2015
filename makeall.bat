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

xelatex.exe gbT7714-2015.tex

xelatex.exe gbT7714-2015ms.tex

xelatex.exe gbT7714-2015eg.tex

xelatex.exe gbT7714-2015eg.tex

xelatex.exe gbT7714-2015thesis.tex

xelatex.exe gbT7714-2015thesis.tex

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)