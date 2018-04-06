<b>Date of last change: 2018-04-03 to version v1.0k</b>


# biblatex-gb7714-2015: a biblatex style  package
---------------------------------------------------------
[使用入门](#jumptotutorial)  |==| [说明文档](biblatex-gb7714-2015.pdf) |==| [WIKI](https://github.com/hushidong/biblatex-gb7714-2015/wiki) 
    

## Introduction

Maintainer: huzhenzhen <hzzmail@163.com>

Homepage: <https://github.com/hushidong/biblatex-gb7714-2015>

License: LaTeX Project Public License 1.3 or later


A biblatex implementation of the `GB/T 7714-2015` bibliography style for Chinese users

The biblatex-gb7714-2015 package provides an implementation of the bibliography style of the `GB/T 7714-2015` bibliography style. This implementation follows `GB/T 7714-2015` standard, and can be used simply by loading biblatex with the appropriate option

## Usage
* for numerical sequence style

    `\usepackage[backend=biber,style=gb7714-2015]{biblatex}`

    - add an option `gbalign` for the numerical label, option value maybe `right` or `left` or `gb7714-2015`

        `\usepackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015]{biblatex}`

    - add an option `gbpub` for dealing publishing items, option value = `true` for gb7714 style or `false` for standard style. This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbpub=true]{biblatex}`
        
    - add an option `gbnamefmt` for dealing name's letter case(this option is also for author year style):

        `gbnamefmt = uppercase` for gb7714 style 
		
        `gbnamefmt = lowercase` for gb7714 style with no case switch of names 
		
        `gbnamefmt = none` for standard style. 
		
        `gbnamefmt = pinyin` for a common Chinese style, like: ZHANG Min-li, YI Shi-he and so on. 
		
		This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbnamefmt=uppercase]{biblatex}`
		
	- add an option `gbtype` for dealing the reference type and carrier identifier like a [J/OL] for an on-line article, option value = `true` for gb7714 style or `false` for none identifier, e.g. An article title followed by empty string instead of the [J/OL]. This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbtype=true]{biblatex}`

* for author year style

    `\usepackage[backend=biber,style=gb7714-2015ay,gbpub=true]{biblatex}`

    - add an option `gbnoauthor` for dealing undefined author, option value = `true` for gb7714 style or `false` for standard style. 

        `\usepackage[backend=biber,style=gb7714-2015ay,gbnoauthor=true]{biblatex}`
	
* for perl script transformation tool(only for the numerical style)

    `perl gb7714texttobib.pl in=textfilename out=bibfilename`

A demonstration database is provided to show how to format input for the style. The biblatex-gb7714-2015 style works with texlive2014, texlive2015, texlive2016, texlive2017 and so on.

please see the file 'biblatex-gb7714-2015.pdf' for further information!


## Applications

* [SJTUThesis(上海交通大学学位论文模板)](https://github.com/sjtug/SJTUThesis)
* [ECNU-Undergraduate-LaTeX(华东师范大学本科毕业论文模板 )](https://github.com/YijunYuan/ECNU-Undergraduate-LaTeX)


## Related Links

* [biblatex](https://github.com/plk/biblatex)
* [beamer](https://github.com/josephwright/beamer)
* [biblatex说明文档中文版](https://github.com/hushidong/biblatex-zh-cn)
* [LaTeX中文参考文献的biblatex解决方案](https://github.com/hushidong/biblatex-solution-to-latex-bibliography)
* [gbt7714-bibtex-style: GB/T7714-2015 标准的bst实现版本](https://github.com/zepinglee/gbt7714-bibtex-style)
* [LaTeX学习网站](http://www.latexstudio.net/)
* [LaTeX交流论坛](http://bbs.ctex.org/)

---------------------------------------------------------

<h2 id="jumptotutorial">Tutorial/使用入门</h2>

[comment]: # (这里这种方式不适合可能主要是因为标题所导致，因此用上面的方式进行处理
<span id="jumptotutorial">## Tutorial/使用入门</span>)


### 1. Tex source file/tex文档一般结构

    \documentclass{article}%文档类%导言区开始:
    
    \usepackage{ctex}%加载ctex宏包，中文支持
    
    \usepackage[left=20mm,right=20mm,top=25mm, bottom=15mm]{geometry}%加载geometry宏包，定义版面
    
    \usepackage[colorlinks=true,pdfstartview=FitH,%
    linkcolor=blue,anchorcolor=violet,citecolor=magenta]{hyperref}%加载hyperref宏包，使用超链接

    \usepackage[backend=biber,bibstyle=gb7714-2015,%nature,%%加载biblatex宏包，使用参考文献
    citestyle=gb7714-2015%,backref=true%%其中后端backend使用biber
    ]{biblatex}%标注(引用)样式citestyle，著录样式bibstyle都采用gb7714-2015样式
    
    \addbibresource[location=local]{example.bib}%biblatex宏包的参考文献数据源加载方式

    
    \begin{document}%正文区开始:

    %正文内容，引用参考文献
    
    1. 不带页码的引用(上标，方括号包围):
    \cite{Peebles2001-100-100}
    
    2. 不带页码的引用(非上标，方括号包围):
    \parencite{Miroslav2004--}
    
    3. 带页码的引用:
    \cite[见][49页]{蔡敏2006--}  \parencite[见][49页]{Miroslav2004--}
    \pagescite{Peebles2001-100-100}  \pagescite[][201-301]{Peebles2001-100-100}
    
    4. 作者年制文中已有作者还需要年份和页码的情况，使用命令yearpagescite，比如:
    见赵耀东\yearpagescite[][205]{赵耀东1998--}和Simon\yearpagescite[][15]{Simon2001--}
	
	5. 作者年制文中已有作者只需要年份的情况，使用命令yearcite和手动方式，比如:
	见赵耀东\yearcite{赵耀东1998--}
	见赵耀东(\cite*{赵耀东1998--})
	见赵耀东(\citeyear{赵耀东1998--})
    
    6. 在页脚中引用和打印文献表:
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

![示例a](example/egaligngb7714-2015.jpg)
	
* 作者年制

![示例b](example/egaligngb7714-2015ay.jpg)


* 姓名的格式更改

对于bib文件中的如下条目，有:

    @Article{Zhang2007-500-503,
      Title                    = {The design and experimental investigations of supersonic length shorted nozzle},
      Author                   = {Zhang, Min-li and Yi, Shi-he and Zhao, Yu-xin},
      Journal                  = {ACTA AERODYNAMICA SINICA},
      Number                   = {4},
      Pages                    = {500-503},
      Volume                   = {25},
      Year                     = {2007}
    }

    @Book{Yi2013--,
      Title                    = {Supersonic and hypersonic nozzle design},
      Address                  = {Beijing},
      Author                   = {Yi, Shi he and Zhao, Yu xin and He, Lin and Zhang, Min li},
      Publisher                = {National Defense Industry Press},
      Year                     = {2013}
    }

    @Book{LIAO2012--,
      Title                    = {Electronic countermeasure techniques for missile penetration},
      Address                  = {Beijing},
      Author                   = {LIAO, ping and JIANG, qin bo},
      Publisher                = {National Defense Industry Press},
      Year                     = {2013}
    }

    @Book{LIU2003--,
      Title                    = {Introduction of Ballistic Misille Techniques},
      Address                  = {Beijing},
      Author                   = {LIU, shi Qiu},
      Publisher                = {China Astronautic Publishing House},
      Year                     = {2003}
    }

![示例c](example/eggbnamefmt.jpg)

---------------------------------------------------------

## Need to do:
    * special characters in all fields?
    * citestyle is gb7714-2015ay, bibstyle is gb7714-2015?
    * entry without author: the delimiter between title and year?
	* more languages, to be compatible with language field in old bib file?
	* wiki?

---------------------------------------------------------

## Update history:

[update latest](example/updatehistory.tex)

[update v1.0-v1.0j](example/updatehistoryold.md)


