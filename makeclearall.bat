@echo off



del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy)

del /q *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk


del /q *.gitignore


cd example

call makecleareg

del *.bbx /Q

del *.cbx /Q

del *.def /Q

del *.bib /Q

cd ..



cd egfigure

call makeclearfig

del *.bbx /Q

del *.cbx /Q

del *.def /Q

del *.bib /Q

cd ..



cd egthesis

call makeclearthesis


del *.bbx /Q

del *.cbx /Q

del *.def /Q

del *.bib /Q

cd ..

