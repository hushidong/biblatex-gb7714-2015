title %date% %time% make-ctan-pkg

cd ..

mkdir biblatex-gb7714-2015

cd biblatex-gb7714-2015

mkdir example

mkdir egfigure

cd ..

copy biblatex-gb7714-2015-master\*.* biblatex-gb7714-2015\*.* /Y

copy biblatex-gb7714-2015-master\example\*.* biblatex-gb7714-2015\example\*.* /Y

copy biblatex-gb7714-2015-master\egfigure\*.* biblatex-gb7714-2015\egfigure\*.* /Y

cd biblatex-gb7714-2015

call makeclearall

cd 

call makeclearpdf

cd 

call makeclearfont

cd ..

zip.exe -r -q -v biblatex-gb7714-2015.zip biblatex-gb7714-2015

pause