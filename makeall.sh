#!/bin/bash
# Copyright (c) 2012-2016 hzz

# exec path for tex live 2016
export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

cd ./example

./makeclear.sh

./makefileeg.sh

cd ..

./makeclear.sh

./makefile.sh

#clear aux files

#./makeclear.sh


