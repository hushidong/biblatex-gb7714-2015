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

cd ..

cd egfigure

call makecompilefig.bat

cd ..


echo biblatex-gb7714-2015.tex >> example/makerecord.dat

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe -no-pdf biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

xelatex.exe --synctex=-1 gbT7714-2015.tex

xelatex.exe --synctex=-1 gbT7714-2015eg.tex

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)