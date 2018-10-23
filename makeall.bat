:: Copyright (c) 2012-2016 hzz

@echo off

if exist *.userbak (
    del *.userbak /Q
)
FOR %%c IN (*.pdf) DO (
    copy /Y "%%c" "%%c.userbak"
)
if exist *.pdf (
    del *.pdf /Q
)

::pause

cd example

call makefileeg

call makefileegstyle.bat

cd ..

echo biblatex-gb7714-2015.tex >> example/makerecord.dat

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

biber biblatex-gb7714-2015

xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

::to do it again for backref 
xelatex.exe --synctex=-1 biblatex-gb7714-2015.tex

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)