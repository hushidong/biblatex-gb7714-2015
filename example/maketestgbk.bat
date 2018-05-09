@echo off


setlocal enabledelayedexpansion
for  %%a in ( testgbkeg.tex ) do (
call makeclear
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makecompilerec.dat
pdflatex.exe --synctex=-1 !jobfile!
biber !jobname!
pdflatex.exe --synctex=-1 !jobfile!
pdflatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

::call makeclear


::pause
