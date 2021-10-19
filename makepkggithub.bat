title %date% %time% make-pkg-github

cd ..

mkdir biblatex-gb7714-2015-github

cd biblatex-gb7714-2015-github

mkdir example

mkdir egfigure

mkdir egthesis

mkdir egphoto

mkdir tool

cd ..

copy biblatex-gb7714-2015-master\*.* biblatex-gb7714-2015-github\*.* /Y

copy biblatex-gb7714-2015-master\example\*.* biblatex-gb7714-2015-github\example\*.* /Y

copy biblatex-gb7714-2015-master\egfigure\*.* biblatex-gb7714-2015-github\egfigure\*.* /Y

copy biblatex-gb7714-2015-master\egthesis\*.* biblatex-gb7714-2015-github\egthesis\*.* /Y

copy biblatex-gb7714-2015-master\egphoto\*.* biblatex-gb7714-2015-github\egphoto\*.* /Y

copy biblatex-gb7714-2015-master\tool\*.* biblatex-gb7714-2015-github\tool\*.* /Y

cd biblatex-gb7714-2015-github

cd tool

call makeclearall

cd tool

call makeclearpdf

del stdbiblatex-gb7714-2015.pdf /Q

cd tool

call makeclearfont

cd ..

zip.exe -r -q -v biblatex-gb7714-2015-github.zip biblatex-gb7714-2015-github

pause