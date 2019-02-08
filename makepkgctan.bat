title %date% %time% make-ctan-pkg

cd ..

mkdir biblatex-gb7714-2015

copy biblatex-gb7714-2015-master\*.* biblatex-gb7714-2015\*.* /Y

cd biblatex-gb7714-2015


del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy)

del /q *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk


del /q *.gitignore

del /q *.otf *.ttf *.ttc 

del gbT*.pdf  std*.pdf/Q

cd ..

del /q biblatex-gb7714-2015\*.bat biblatex-gb7714-2015\*.sh

zip.exe -r -q -v biblatex-gb7714-2015.zip biblatex-gb7714-2015

pause