@echo off


del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy)
del /q *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk


cd example

call makeclear

del *.bbx /Q

del *.cbx /Q

del *.def /Q

del *.pdf /Q