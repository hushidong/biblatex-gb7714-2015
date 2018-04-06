@echo off


IF NOT EXIST gb7714-2015.bbx (
copy ..\gb7714-2015.bbx . /y
copy ..\gb7714-2015.cbx . /y
copy ..\gb7714-2015ay.bbx . /y
copy ..\gb7714-2015ay.cbx . /y
)

echo compiled files info: > makecompilerec.dat

setlocal enabledelayedexpansion
for  %%a in ( eg*.tex ) do (
call makeclear
set jobfile=%%a
set jobname=!jobfile:~0,-4!
echo %%a
echo !jobfile!
echo !jobname!
echo !jobfile! >> makecompilerec.dat
xelatex.exe --synctex=-1 !jobfile!
biber !jobname!
xelatex.exe --synctex=-1 !jobfile!
)
setlocal DISABLEDELAYEDEXPANSION

call makeclear

del *.bbx /Q
del *.cbx /Q


::pause
