#!/bin/bash
# Copyright (c) 2012-2016 hzz

# exec path for tex live 2016
export PATH=${PATH}:/usr/local/texlive/2016/bin/x86_64-linux

# compile the tex file
# 显然tex文件前的./不一定需要的，反而是上面的Path路径反而是关键
xelatex --synctex=-1 ./biblatex-gb7714-2015-beamer.tex

#pause

biber ./biblatex-gb7714-2015-beamer

#pause

xelatex --synctex=-1 ./biblatex-gb7714-2015-beamer.tex

#to do it again for backref 
xelatex --synctex=-1 ./biblatex-gb7714-2015-beamer.tex

# clear aux files

rm -r *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz
rm -r *.nav *.snm *.vrb 

# compile the tex file

xelatex --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

#pause

biber biblatex-gb7714-2015ay-beamer

#pause

xelatex --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

#to do it again for backref 
xelatex --synctex=-1 biblatex-gb7714-2015ay-beamer.tex

# clear aux files

rm -r *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz
rm -r *.nav *.snm *.vrb 
