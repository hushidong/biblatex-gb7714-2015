Date of last change:2016-11-11 to version v1.0b

# biblatex-gb7714-2015: a biblatex style  package
---------------------------------------------------------

Maintainer: huzhenzhen <hzzmail@163.com>

Homepage: <https://github.com/hushidong/biblatex-gb7714-2015>

License: LaTeX Project Public License 1.3 or later


A biblatex implementation of the GBT7714-2015 bibliography style for Chinese users

The biblatex-gb7714-2015 package provides an implementation of the bibliography style of the GBT7714-2015 bibliography style. This implementation follows GBT7714-2015 standard, and can be used simply by loading biblatex with the appropriate option

%for numerical sequence

`\usepackage[backend=biber,style=gb7714-2015]{biblatex}`

%for author year sequence

`\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}`

A demonstration database is provided to show how to format input for the style. The biblatex-gb7714-2015 style works with texlive2014, texlive2015, texlive2016 and so on.

please see the file 'biblatex-gb7714-2015.pdf' for more information!

---------------------------------------------------------

update history:

date of change: 2016-11-11 to version v1.0b

* Changes to pkg code:to match the GBT7714-2015 standard
- "*.bbx",: change a few local strings from english.blx such as bibliography,references
- "*.bbx",: set new maxnamenumber for authoryear style
- "*.bbx",: add translator field and modify version format for report and manual driver 
- "*.bbx",: remove the space before edition/version field, which was brought in with testCJKfirst function

* Changes to documentation:
- biblatex-gb7714-2015.tex: correct a few flaws and add more instructions.

date of change: 2016-10-23 to version v1.0a

* Changes to pkg code:
- "*.bbx","*.cbx": add some information like version information.

* Changes to documentation:
- biblatex-gb7714-2015.tex: correct a few flaws .
- paperone.bib: refine some entries.