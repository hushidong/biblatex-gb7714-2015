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

::call makefiletest

::call makefilegbk

cd ..

call makeclear

call makefile

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)