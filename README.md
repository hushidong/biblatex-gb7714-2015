Date of last change:2016-12-07 to version v1.0e

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

date of change: 2016-12-07 to version v1.0e

* Changes to pkg code:to fix a few bugs
- "*.bbx": add overwite option when map keywords field with note field
- "*.bbx": modify the punction after publisher in gb7714-2015.bbx

* Changes to documentation:
- biblatex-gb7714-2015.tex: add a summary of the features of the package
- *.sh/bad: add the autoexec files for windows/linux OS 
- *.bib: refine the bib database

date of change: 2016-11-24 to version v1.0d

* Changes to pkg code:to fix a few bugs to work with beamer class correctly
- "*.bbx": redefine the DeclareFieldFormat for title to eleminate the redundant dot after title in beamer class
- "*.bbx": add some comment in drivers to eleminate the needless space

* Changes to documentation:
- biblatex-gb7714-2015.tex: revise this document and add some explication


date of change: 2016-11-14 to version v1.0c

* Changes to pkg code:to fix a few bugs
- "*ay.bbx": add noauthor or "佚名" for the authoryear style
- "*ay.bbx": add some map cmds to automatically fill the userb field for sorting of the authoryear style
- "*ay.bbx": add a command yearpagescite for the authoryear style
- "*.bbx": add a dot after the null publisher with nothing followed
- "*.bbx": modify the english local string backrefpage to chinese "引用页:"
- "*ay.bbx": add some options such as uniquelist,labeldate,uniquename for the authoryear style

* Changes to documentation:
- biblatex-gb7714-2015.tex: revise this document.

date of change: 2016-11-11 to version v1.0b

* Changes to pkg code:to match the GBT7714-2015 standard
- "*.bbx": change a few local strings from english.blx such as bibliography,references
- "*.bbx": set new maxnamenumber for authoryear style
- "*.bbx": add translator field and modify version format for report and manual driver 
- "*.bbx": remove the space before edition/version field, which was brought in with testCJKfirst function

* Changes to documentation:
- biblatex-gb7714-2015.tex: correct a few flaws and add more instructions.
- "*.bib":: refine some entries


date of change: 2016-10-23 to version v1.0a

* Changes to pkg code:
- "*.bbx","*.cbx": add some information like version information.

* Changes to documentation:
- biblatex-gb7714-2015.tex: correct a few flaws .
- paperone.bib: refine some entries.