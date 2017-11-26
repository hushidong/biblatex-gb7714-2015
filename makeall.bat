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

call makeclear

call makefileeg

call makefile

::call makeclear

if exist *.userbak (
    del *.userbak /Q
)