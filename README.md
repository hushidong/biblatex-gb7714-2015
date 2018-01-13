<b>Date of last change:2017-11-21 to version v1.0i</b>


# biblatex-gb7714-2015: a biblatex style  package
---------------------------------------------------------

## introduction

Maintainer: huzhenzhen <hzzmail@163.com>

Homepage: <https://github.com/hushidong/biblatex-gb7714-2015>

License: LaTeX Project Public License 1.3 or later


A biblatex implementation of the GB/T7714-2015 bibliography style for Chinese users

The biblatex-gb7714-2015 package provides an implementation of the bibliography style of the GB/T7714-2015 bibliography style. This implementation follows GB/T7714-2015 standard, and can be used simply by loading biblatex with the appropriate option

## usage
* for numerical sequence style

    `\usepackage[backend=biber,style=gb7714-2015]{biblatex}`

    - add an option "align" for the numerical label, option value maybe "right" or "left" or "gb7714-2015"

        `\usepackage[backend=biber,style=gb7714-2015,align=gb7714-2015]{biblatex}`

    - add an option "gbpub" for dealing publishing items, option value = "true" for gb7714 style or "false" for standard style. 

        `\usepackage[backend=biber,style=gb7714-2015,gbpub=true]{biblatex}`

* for author year style

    `\usepackage[backend=biber,style=gb7714-2015ay,gbpub=true]{biblatex}`

    - add an option "gbnoauthor" for dealing undefined author, option value = "true" for gb7714 style or "false" for standard style. 

        `\usepackage[backend=biber,style=gb7714-2015ay,gbnoauthor=true]{biblatex}`
	
* for perl script transformation tool(only for the numerical style)

    `perl gb7714texttobib.pl in=textfilename out=bibfilename`

A demonstration database is provided to show how to format input for the style. The biblatex-gb7714-2015 style works with texlive2014, texlive2015, texlive2016, texlive2017 and so on.

please see the file 'biblatex-gb7714-2015.pdf' for further information!

---------------------------------------------------------

## tutorial/使用入门

### 1. Tex source file/tex文档一般结构

    \documentclass{article}%文档类%导言区开始:
    
    \usepackage{ctex}%加载ctex宏包，中文支持
    \usepackage[left=20mm,right=20mm,top=25mm, bottom=15mm]{geometry}%加载geometry宏包，定义版面
    \usepackage[colorlinks=true,pdfstartview=FitH,linkcolor=blue,anchorcolor=violet,citecolor=magenta]{hyperref}%加载hyperref宏包，使用超链接

    %加载biblatex宏包，使用参考文献
    %其中后端backend使用biber
    %引用样式citestyle，著录样式bibstyle都采用gb7714-2015样式
    \usepackage[backend=biber,bibstyle=gb7714-2015,%nature,%
    citestyle=gb7714-2015%,backref=true%
    ]{biblatex}
    %biblatex宏包的参考文献数据源加载方式
    \addbibresource[location=local]{example.bib}

    
    \begin{document}%正文区开始:

    %正文内容，引用参考文献
    不带页码的引用(上标，方括号包围):
    \cite{Peebles2001-100-100}
    不带页码的引用(非上标，方括号包围):
    \parencite{Miroslav2004--}
    带页码的引用:
    \cite[见][49页]{蔡敏2006--}  \parencite[见][49页]{Miroslav2004--}
    \pagescite{Peebles2001-100-100}  \pagescite[][201-301]{Peebles2001-100-100}
    作者年制文中已有作者只需要年份和页码的情况，使用命令yearpagescite，比如:
    见赵耀东\yearpagescite[][205]{赵耀东1998--}和Simon\yearpagescite[][15]{Simon2001--}的文献。
    在页脚中引用和打印文献表:
    \footnote{在脚注中引用\footcite{赵学功2001--}}  \footfullcite{赵学功2001--}
    

    %打印参考文献表
    \printbibliography[heading=bibliography,title=参考文献]
    \end{document}

### 2. Compile method/文档编译方式

    xelatex jobname.tex
    biber jobname
    xelatex jobname.tex
    xelatex jobname.tex

### 3. Recommended environment/推荐使用环境
    
    Texlive+Winedt
    Texlive+Texstudio

### 4. Examples/著录和标注结果示例
* 顺序编码制

![示例a](egaligngb7714-2015.jpg)
	
* 作者年制

![示例b](egaligngb7714-2015ay.jpg)



---------------------------------------------------------

## update history:

### need to do:
	* special characters in all fields?
    * citation command like cite*?

### date of change: 2017-11-21 to version v1.0i
* Changes to pkg code:
    - "*.bbx": add a new solution for multi-language bibliography based on related entry other than the old @set method for biblatex version >3.8, because biblatex(>v3.8) does not copy info from its first member any longer.
	- "*.bbx": correct a bug of entry's title with \LaTeX{} macro reported by liubenyuan. this bug is raised in CJK char check function when StrChar from xtring pkg to extract chars. 
    - "*.bbx": deal compatibility problem of author-year style for biblatex v>3.8a, include labeldate->labeldateparts and DeclareSortingScheme -> DeclareSortingTemplate.
    - "*.bbx": change the version check macro,using macro form pkg xstring. change version switch method, define version's code first then switch depend on the biblatex version.
	- "*.bbx": replace the \iffieldundef{year} by \iffieldequalstr{year}{} in \newbibmacro*{modifydate}, for the year field is defined with empty string for biblatex version >3.7 after biber dealing with none date info.
	- "*.bbx": change the date format control mechanism for biblatex version >3.7, lower versions keep the old fansion.
	- "*.bbx": rewrite the volume and number parsing macro using xstring pkg.
	- "*.bbx": correct a bug with option gbnoauthor when book entry has none author.
* Changes to documentation:
	- biblatex-gb7714-2015.tex: revise this document 


### date of change: 2017-04-11 to version v1.0h, the last version support texlive2015
* Changes to pkg code:
    - "*.bbx": deal compatibility problem of author year style for texlive2017, because the old cmd printdateextralabel with biblatex3.4 has been replaced by printlabeldateextra with biblatex3.7 in texlive2017.
    - "*.bbx": change the seperator between multi-language reference text from cmd par to cmd newline for the gb7714-2015 align style
	- "*.bbx": fix a flaw reported by Lee Zeping. remove the comma between journaltitle and (number) when the volume is undefined.
    - "*.bbx": add an option gbpub to control the publishing info. if gbpub=false, publishing info's format is the biblatex standard style, otherwise is gb7714-2015 style. The origin idea comes from Wayne08.
    - "*.bbx": fix a flaw reported by zjsdut@163.com. remove the dot before url when url is the only info available。
    - "*.bbx": add an option gbnoauthor for author-year style. when author is undefined, set option gbnoauthor=true then author with "佚名"or"NOAUTHOR" will be defined. note that with biblatex version 3.7 or higher for multiple DeclareStyleSourcemap support, code can be simplifed, because the realization code now with texlive2016(biblatex 3.4) is subjected to the one DeclareStyleSourcemap constraint.
* Changes to documentation:
	- biblatex-gb7714-2015.tex: revise this document 
	- *.bib: correct a warning which is caused by long multi-line url info.
    
    
### date of change: 2017-02-26 to version v1.0g
* Changes to pkg code:
	- "*.bbx": deal the compatibility problem for some entrytypes: mastersthesis,phdthesis,www,electronic,standard,techreport,conference, and newspaper. these entrytypes can be used in the source bib file.
	- "*.bbx": for online type, the revised/changed date is denoted by date/enddate/eventdate
	- "*.bbx": modify the usera field's format, taking into account the standard style's package option url, proposed by Sheng Wenbo.
	- "*.bbx": add a no breakthinspace after the entrytype identifier (like [M]//) to make the next word break correctly
    - "*.bbx": add a feature for automatically dealing with special character(like &/%/#)，compatibility with texlive2015 is done
* Changes to documentation:
	- biblatex-gb7714-2015.tex: revise this document and add some explication
	- *.bib: refine the bib source file
* Changes to tool code:
	- "*.pl": realize the feature of transformation from gb7714-2015 style bibography text to bib file using perl script gb7714texttobib.pl


### date of change: 2016-12-31 to version v1.0f

* Changes to pkg code:
	- "*.bbx": use function iffieldequalstr instead of customized function for testing the value of note field eqs standard/news
	- "*.bbx": deal the compatibility problem for texlive2015, include:
		1. DeclareBibliographyOption of biblatex 3.0 in texlive2015 cmd has no type argument
		2. pkg xstring is not loaded with biblatex 3.0 in texlive2015
		3. new defined bibliography environment with gb7714-2015 label align sytle not works
* Changes to documentation:
	- biblatex-gb7714-2015.tex: add an explaination for the author field input format


### date of change: 2016-12-07 to version v1.0e

* Changes to pkg code:to fix a few bugs
	- "*.bbx": add overwite option when map keywords field with note field
	- "*.bbx": modify the punction after publisher in gb7714-2015.bbx
	- "*.bbx": modify some newbibmacro* to renewbibmacro* to eleminate warnings
	- "*.bbx": add a package option align=right,left,gb7714-2015 for users to choose numeric label align style
	- "*.cbx": restore the origin parencite definition for users to use superscript citecmd(cite) and inline citecmd(parencite) in one document
* Changes to documentation:
	- biblatex-gb7714-2015.tex: add a summary of the features of the package and a compile guide
	- *.bib: refine the bib database
* Changes to tool code:
	- *.sh/bat: add the autoexec files for windows/linux OS 

### date of change: 2016-11-24 to version v1.0d

* Changes to pkg code:to fix a few bugs to work with beamer class correctly
	- "*.bbx": redefine the DeclareFieldFormat for title to eleminate the redundant dot after title in beamer class
	- "*.bbx": add some comment in drivers to eleminate the needless space

* Changes to documentation:
	- biblatex-gb7714-2015.tex: revise this document and add some explication


### date of change: 2016-11-14 to version v1.0c

* Changes to pkg code:to fix a few bugs
	- "*ay.bbx": add noauthor or "佚名" for the authoryear style
	- "*ay.bbx": add some map cmds to automatically fill the userb field for sorting of the authoryear style
	- "*ay.bbx": add a command yearpagescite for the authoryear style
	- "*.bbx": add a dot after the null publisher with nothing followed
	- "*.bbx": modify the english local string backrefpage to chinese "引用页:"
	- "*ay.bbx": add some options such as uniquelist,labeldate,uniquename for the authoryear style

* Changes to documentation:
	- biblatex-gb7714-2015.tex: revise this document.

### date of change: 2016-11-11 to version v1.0b

* Changes to pkg code:to match the GBT7714-2015 standard
	- "*.bbx": change a few local strings from english.blx such as bibliography,references
	- "*.bbx": set new maxnamenumber for authoryear style
	- "*.bbx": add translator field and modify version format for report and manual driver 
	- "*.bbx": remove the space before edition/version field, which was brought in with testCJKfirst function

* Changes to documentation:
	- biblatex-gb7714-2015.tex: correct a few flaws and add more instructions.
	- "*.bib":: refine some entries


### date of change: 2016-10-23 to version v1.0a

* Changes to pkg code:
	- "*.bbx","*.cbx": add some information like version information.

* Changes to documentation:
	- biblatex-gb7714-2015.tex: correct a few flaws .
	- paperone.bib: refine some entries.
