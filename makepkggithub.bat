title %date% %time% make-pkg-github

cd ..

mkdir biblatex-gb7714-2015-github

cd biblatex-gb7714-2015-github

mkdir example

mkdir egfigure

mkdir egthesis

cd ..

copy biblatex-gb7714-2015-master\*.* biblatex-gb7714-2015-github\*.* /Y

copy biblatex-gb7714-2015-master\example\*.* biblatex-gb7714-2015-github\example\*.* /Y

copy biblatex-gb7714-2015-master\egfigure\*.* biblatex-gb7714-2015-github\egfigure\*.* /Y

copy biblatex-gb7714-2015-master\egthesis\*.* biblatex-gb7714-2015-github\egthesis\*.* /Y

cd biblatex-gb7714-2015-github

call makeclearall

cd 

call makeclearpdf

cd 

call makeclearfont

cd ..

zip.exe -r -q -v biblatex-gb7714-2015-github.zip biblatex-gb7714-2015-github

pause