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
		
	- add an option `gbpunctin` to control the output of `//` before bookauthor for entrytypes like inbook/incollection/inproceedings. `gbpunctin=true` to output `//`, `gbpunctin=false` to output the bibstring for English is IN:, If want to eliminate it at all, please add a cmd `\DefineBibliographyStrings{english}{in={}}` in the preamble. This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbpunctin=true]{biblatex}`
		
	- add an option `gbcodegbk` to deal tex file encoded with GBK. if want to compile GBK file with pdflatex or latex，set `gbcodegbk=true` is needed. if compile with xelatex, it should be none or `gbcodegbk=false`. This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbcodegbk=false]{biblatex}`
		
	- add an option `gbstrict` to control the output of some unnecessary filed for GB/T7714-2015. If want to output them as the standard styles, it should be `gbstrict=false`. defaulty the option is set with `true`. This option is also for author year style.

        `\usepackage[backend=biber,style=gb7714-2015,gbstrict=true]{biblatex}`

* for author year style

    `\usepackage[backend=biber,style=gb7714-2015ay,gbpub=true]{biblatex}`

    - add an option `gbnoauthor` for dealing undefined author, option value = `true` for gb7714 style or `false` for standard style. 

        `\usepackage[backend=biber,style=gb7714-2015ay,gbnoauthor=true]{biblatex}`
	
* for perl script transformation tool(only for the numerical style)

    `perl gb7714texttobib.pl in=textfilename out=bibfilename`

A demonstration database is provided to show how to format input for the style. The biblatex-gb7714-2015 style works with texlive2014, texlive2015, texlive2016, texlive2017 and so on.

please see the file 'biblatex-gb7714-2015.pdf' for further information!


## Applications

* [SJTUThesis(上海交通大学学位论文模板)](https://github.com/sjtug/SJTUThesis)(母校的论文模板，不得不说缘分真的很神奇)
* [fduthesis(复旦大学论文模板)](https://github.com/Stone-Zeng/fduthesis)
* [ECNU-Undergraduate-LaTeX(华东师范大学本科毕业论文模板)](https://github.com/YijunYuan/ECNU-Undergraduate-LaTeX)
* [UCASthesis(中国科学院大学学位论文模板**国科大新版标准**)](https://github.com/xiaoyao9933/UCASthesis)
* [nuaathesis(南京航空航天大学(非官方)本科生学位 LaTeX 模板)](https://github.com/nuaatug/nuaathesis)
* [Study-LaTeX(LaTeX学习笔记)](https://github.com/Zousiyu/Study-LaTeX)
* [LaTeX-template(开箱即用的 LaTeX 模板)](https://github.com/tsai1993/LaTeX-template)
* [...]




## Related Links

* [Biblatex 宏包](https://github.com/plk/biblatex)
* [Beamer 文档类](https://github.com/josephwright/beamer)
* [biblatex 宏包中文手册 ](https://github.com/hushidong/biblatex-zh-cn)
* [biblatex 简明使用手册](https://github.com/hushidong/biblatex-solution-to-latex-bibliography)
* [biblatex-caspervector: caspervector 设计的中文参考文献样式](https://github.com/CasperVector/biblatex-caspervector)
* [gbt7714-bibtex-style: GB/T7714-2015 标准的bst实现版本](https://github.com/zepinglee/gbt7714-bibtex-style)
* [LaTeX学习网站](http://www.latexstudio.net/)
* [LaTeX交流论坛](http://bbs.ctex.org/)

---------------------------------------------------------

<h2 id="jumptotutorial">Tutorial/使用入门</h2>

[comment]: # (这里这种方式不适合可能主要是因为标题所导致，因此用上面的方式进行处理
<span id="jumptotutorial">## Tutorial/使用入门</span>)


<h3 id="jumptotexsrcf">1. Tex source file/tex文档一般结构</h3>

```
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

4. 顺序编码制中同时输出作者和顺序编码标签，比如：
（一）直接的方法：见\citeauthor{refb}\cite{refb},\citeauthor{refc}\cite{refc}
（二）定义新的标注命令：见\authornumcite{refb,refc}
（三）用textcite但没有上标：见\textcite{refb,refc}

5. 作者年制文中已有作者还需要年份和页码的情况，使用命令yearpagescite，比如:
见赵耀东\yearpagescite[][205]{赵耀东1998--}和Simon\yearpagescite[][15]{Simon2001--}

6. 作者年制文中已有作者只需要年份的情况，使用命令yearcite和手动方式，比如:
见赵耀东\yearcite{赵耀东1998--}
见赵耀东(\cite*{赵耀东1998--})
见赵耀东(\citeyear{赵耀东1998--})

7. 在页脚中引用和打印文献表:
\footnote{在脚注中引用\footcite{赵学功2001--}}  \footfullcite{赵学功2001--}


%打印参考文献表
\printbibliography[heading=bibliography,title=参考文献]
\end{document}
```

### 2. Compile method/文档编译方式

```
xelatex jobname.tex
biber jobname
xelatex jobname.tex
xelatex jobname.tex
```

### 3. Recommended environment/推荐使用环境
    
- Texlive+Winedt
- Texlive+Texstudio
	
### 4. Common questions/常见问题

#### 4.1 Installation and use/安装和使用

* <b>怎么利用biblatex生成国标GB/T 7714-2015格式的参考文献表？</b>

> (1)在导言区加载biblatex宏包，并使用gb7714-2015样式:

> `\usepackage[backend=biber,style=gb7714-2015]{biblatex}`

> (2)正文中引用参考文献:

> `见文献\cite{referencbibtexkey}`

> (3)在需要的地方打印参考文献表:

> `\printbibliography`
	   
更直接的例子见前述的[tex源文档](#jumptotexsrcf)
		
* <b>请问我应该怎么安装和更新biblatex-gb7714-2015宏包？</b>
		
> biblatex-gb7714-2015宏包是基于biblatex的样式宏包，目前texlive，miktex都已收录，因此可以直接使用，不需要安装。
> 当你使用的环境下，系统提示找不gb7714-2015.bbx或gb7714-2015ay.bbx文件时，说明系统不存在gb7714-2015样式文件，
> 这时需要安装。最简单的方法是从本项目源码中下载gb7714-2015.bbx,gb7714-2015ay.bbx,gb7714-2015.cbx,
> gb7714-2015ay.cbx四个文件放到你要编译的主文档所在目录。对于已经安装的用户需要更新到最新版，
> 则可以下载这四个文件替换系统已经安装的文件。

* <b>为什么我之前使用样式`style = caspervector`进行编译没有问题，换成`style = gb7714-2015`后，编译就出现错误？</b>
	
> 可能有三个原因：

> 1. 辅助文件没有清理导致，当采用caspervector样式时编译产生的辅助文件中可能带有该样式的一些特有信息，可能产生一些不兼容。因此需要的操作是，清除辅助文件，然后再进行编译。清除命令为(下面的命令是windows下的，linux下的是类似的只需把删除命令换成`rm -f`)：

`del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy) *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk`

> 2. biblatex-gb7714-2015版本过于陈旧，可能对于一些特殊情况考虑不全面。因此需要的操作是更新biblatex-gb7714-2015。方法见上一个问题。

> 3. 编译命令问题，通常情况下tex文档和bib文档是utf8编码的，因此最好采用xelatex编译，而不用pdflatex。因此如果编译时用pdflatex出现错误，请换成xelatex。


* <b>为什么利用ctex2.9套装进行编译时，编译出现错误？</b>
	
> 由于ctex2.9套装多年未更新，其中的biblatex宏包过老，所以需要更新一下biblatex。
	   
* <b>我希望参考文献表中的文献不是按引用顺序而是以文献的字母顺序排序，怎么实现？</b>
		
> 一般情况下文献表是按引用顺序进行排列，标签是顺序的数字，这种方式称为顺序编码制。
> 如果要以文献作者字母顺序排列，那么需要换一种编制方式，称为作者年制:
		
> `\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}`
		
* <b>英文文献能按字母顺序排列，那么参考文献表中的中文文献能否以拼音或者笔画进行排序呢？</b>
	
> 可以，主要通过编译时，在biber编译参考文献信息命令中设置参数选项来实现:
		
```
%按拼音排序，biber命令
biber -l zh__pinyin jobname
%按笔画排序，biber命令
biber -l zh__stroke jobname
```
		
* <b>作者年制参考文献表目前的排序时升序排列，能不能改成降序排序？</b>
		
> 能，这需要通过修改gb7714-2015ay.bbx中的代码来实现，找到:
> `\sort{%[direction=descending]`
> 修改为:
> `\sort[direction=descending]{%`

* <b>我希望文献表以阿拉伯数字编号，而正文中的引用标签使用作者和年份标注而不是数字，请问我该如何处理？</b>

> 可以设置不同的标注和著录样式，比如标注样式用作者年制，而著录样式用顺序编码制，比如:

> `\usepackage[backend=biber,citestyle=gb7714-2015ay,bibstyle=gb7714-2015]{biblatex}`

> 参见:[issue:参考文献的顺序](https://github.com/sjtug/SJTUThesis/issues/300)

* <b>请问我还希望顺序编码的文献著录表以拼音排序，该怎么操作？</b>

> 顺序编码文献著录表默认是按引用顺序排序，但可以通过设置sorting选项进行调整，比如sorting=nyt表示按作者姓名年份以及文献标题进行排序，比如:

> `\usepackage[backend=biber,citestyle=gb7714-2015ay,bibstyle=gb7714-2015,sorting=nyt]{biblatex}`

> 同时，因为默认情况下中文字符排序是按unicode编码顺序进行排序，因此要按拼音排序，还需要使用biber的按拼音排序编译选项，比如:

> `biber -l zh__pinyin jobname`

		
* <b>请问参考文献中存在一些特殊字符比如&或者一些特殊命令比如\LaTex{}是不是会出现问题？</b>
	
> 通常不会出现问题，直接输入即可，当出现问题时可以手动调整比如修改为`\&`和`{\LaTex{}}`
		
* <b>我习惯用传统的bst文件来生成参考文献，有没有GB/T 7714-2015标准的实现版本？</b>
	
> GB/T 7714-2015标准实现的bst版本，已经由[zeping lee](https://github.com/zepinglee/gbt7714-bibtex-style)开发完毕，直接使用即可。
		
* <b>我在使用过程中遇到了一些无法理解和无法解决的问题，怎么办？</b>
	
> 请邮件联系hzzmail@163.com或在项目内发issue提问即可。
		
	
#### 4.2 Bibliography format/文献表著录格式

* <b>请问可以在参考文献表中实现类似于word那样的与文献内容等间距标签对齐格式么？</b>
	
> 可以，latex的列表通常用list来实现，因此一般列表的内容都是对齐的，
> 此时如果标签右对齐的，那么标签和内容等间距，但标签左侧是不对齐的。
> 如果标签是左对齐的，那么标签和内容的间距不相等。
> 如果要求标签左侧对齐，且标签与内容等间距必须放弃使用list。
> biblatex-7714-2015的顺序编码制样式特别设计了这样的环境，以保持和word一致。通过设置选项gbalign来实现:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,gbalign=gb7714-2015]{biblatex}`
		
* <b>请问如果不希望在参考文献表中出现类似“出版地不详”“出版者不详”等信息时，该怎么处理？</b>
	
> 设置选项gbpub可以实现，当gbpub=false时，biblatex-gb7714-2015宏包会放弃国标的要求，不使用“出版地不详”等补充信息:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,gbpub=false]{biblatex}`

		
* <b>我觉得文献表中英文作者全部用大写不好看，请问能换一种大小写方式么？</b>
	
> 能，通过设置gbnamefmt可以实现，默认情况下gbnamefmt=uppercase，作者姓名字母全部大写。
> 当设置gbnamefmt=lowercase时，biblatex-gb7714-2015宏包对于bib文件中的作者姓名的大小写不做改变，
> 这时可以在bib文件中手动设置想要的大小写方式。
> 当要实现类似ZHAO Yu-xin这样的拼音方式，则可以设置gbnamefmt=pinyin:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,gbnamefmt=lowercase]{biblatex}`
		
* <b>请问如果不希望在参考文献表中出现类似“[M]”“[J]”等文献类型标识符时，该怎么处理？</b>
	
> 可通过设置选项gbtype=false实现:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,gbtype=false]{biblatex}`
		
* <b>请问如果不希望在参考文献表中出现网址信息时，该怎么处理？</b>
	
> 可通过设置选项url=false实现:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,url=false]{biblatex}`
		
* <b>请问如果不希望在参考文献表中出现DOI信息时，该怎么处理？</b>
	
> 可通过设置选项doi=false实现:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,doi=false]{biblatex}`
		
* <b>请问参考文献没有作者时，希望用佚名或Noauthor代替作者时，该怎么处理？</b>
	
> 可通过设置选项gbnoauthor=true实现，注意该方式主要用在作者年制中:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,gbnoauthor=true]{biblatex}`
		
* <b>请问希望参考文献表中参考文献作者数量超过国标规定的3个时，该怎么处理？</b>
	
> 可通过设置选项maxbibnames，minbibnames实现，比如下面的设置用于显示5个作者:
		
> `\usepackage[backend=biber,bibstyle=gb7714-2015,maxbibnames=5,minbibnames=5]{biblatex}`
	
	
* <b>请问如何使文献表中文献的标题的是句首字母大写而其它所有字母均小写？</b>
	
> 默认情况下，biblatex-gb7714-2015不对标题的字母大小写做处理，因此要得到想要的字母大小写格式，
> 需要在bib文件输入参考文献信息时给出需要的大小写格式。
		
* <b>请问如何使文献表中期刊名的是单词首字母大写的？</b>
	
> 默认情况下，biblatex-gb7714-2015不对期刊名的字母大小写做处理，
> 因此需要在bib文件输入参考文献信息时给出需要的大小写格式。
		
		
* <b>请问我想得到中英文对照的双语参考文献，该如何处理？</b>
	
> biblatex-gb7714-2015设计了两种多语言对照参考文献的实现方式，
> 一种是利用条目集的概念，另一种是利用关联条目的概念。
> 因此有两种方法:

> 方法一，动态定义条目集:
> 在导言区或正文中定义:
> `\defbibentryset{易仕和，等，2013}{易仕和2013--,Yi2013--}

> 在正文中引用:
> 双语文献引用\cite{易仕和，等，2013}`

> 方法二，动态定义关联条目:
> 在导言区定义:
> `\defdoublelangentry{易仕和2013--}{Yi2013--}`

> 在正文中引用:
> `双语文献引用\cite{易仕和2013--}`
		
	
	
#### 4.3 Citation format/正文引用的标注格式

* <b>我希望在正文中同时使用上标和非上标的引用标签，该怎么操作？</b>
	
> 可以使用不同的命令来实现上标和非上标的标签，
> 上标标签的命令为`\cite{bibtexkey}`，非上标标签的命令为`\parencite{bibtexkey}`。
> 当希望上标的标签也给出国标要求的页码时，则可以使用`\pagescite[][50-55]{bibtexkey}`给出指定页码
> 或者`\pagescite{bibtexkey}`使用bib文件中的页码。
		
* <b>我在引用文献时已经给出作者信息，希望引用标签仅包含年份和页码信息或者仅包含年份信息时，该怎么操作？</b>
	
> 需要给出年份的标签是作者年制的标签，可以使用命令`yearpagescite{bibtex}`给出仅包含年份和页码信息的标签，
> 使用命令`yearcite{bibtex}`给出仅包含年份的标签。

* <b>在使用作者年制时，我希望文献表是按作者年份标题排序，而正文某处一个cite命令引用多个参考文献，且这些文献的标签是按年份作者标题排序，该怎么操作？</b>
	
> 有两种方法:
> 一是自动排序
> 宏包加载时使用
> `\usepackage[backend=biber,style=gb7714-2015ay,sortcite,sorting=ynt]{biblatex}`
> 正文中引用:
> `\cite{refa2010,refb2008,refc2009}`
> 然后在文献打印前加
> `\newrefcontext[sorting=nyt]`

> 二是手动给出排序
> 宏包加载时使用
> `\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}`
> 引用多个文献时按照年份顺序给出引用关键字，即正文中引用:
> `\cite{refb2008,refc2009,refa2010}`

> 参考:[issue:citation的顺序和bibliography的顺序如何不关联](https://github.com/hushidong/biblatex-gb7714-2015/issues/30)


		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量超过国标规定的1个时，该怎么处理？</b>
	
> 可通过设置选项maxcitenames，mincitenames实现，比如下面的设置用于显示5个作者:

> `\usepackage[backend=biber,bibstyle=gb7714-2015,maxcitenames=5,mincitenames=5]{biblatex}`
		
		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量只能是1个，而不管是否存在歧义时，该怎么处理？</b>
	
> 可通过设置选项uniquelist=false实现，该设置标签中的作者只会是指定的1个:

> `\usepackage[backend=biber,bibstyle=gb7714-2015,uniquelist=false]{biblatex}`
		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量只能是1个，且只用其作者的姓而不管是否存在歧义时，该怎么处理？</b>
	
> 可通过设置选项uniquelist=false, uniquename=false实现，该设置标签中的作者只会是指定的1个且只用该作者的姓:

> `\usepackage[backend=biber,bibstyle=gb7714-2015,uniquelist=false,uniquename=false]{biblatex}`
	
	
	
### 5. Examples/著录和标注结果示例
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
    * entry without author: the delimiter between title and year?
	* more languages, to be compatible with language field in old bib file?
	* more complex citation cmd?
	* gbk encoding ？
	* gbstrict to eliminate fields not in GB？

---------------------------------------------------------

## Update history:


\updateinfo[2018-04-03]{date of update: 2018-04-03 to version v1.0k}\label{up:180403}

\begin{enumerate}

\item 增加了标注命令authornumcite，用于在标注标签中同时输出作者和顺序编码。（20180427）

add a citation cmd：authornumcite to print author and numeric number at the same time.

\item 增加了字体控制命令bibauthorfont，bibtitlefont，bibpubfont，用于控制文献表中作者、标题、出版项的字体和颜色。（20180427）

add 3 font set cmd：bibauthorfont，bibtitlefont，bibpubfont to control the font and color of author，title，and publication items.

\item 增加了gbpunctin选项，用于控制inbook等类型是否输出析出来源文献前的//符号，主要是为方便用户定制。

add an option gbpunctin to control the output of // before bookauthor for entry types like inbook.

\item 修正了析出文献来源的作者为editor是出现两次的问题，这个很简单的问题如果用bookauthor就不会出现问题，所以以前一直没有发现，才由杨志红提出来，感谢。

correct a bug that the editor appears twice for the entry with booktitle's bookauthor is editor, which is reported by Yang zhihong,3ks!

\item 完善了github上的wiki。

WIKI on github was accomplished.

\item 修正了gbnamefmt中的一些小错误。

correct some flaws for gbnamefmt option.

\item 修改了代码用于兼容3.11版本

change the separator before related block for v3.11.

\item 页码范围的间隔符从en dash改为hyphen

change the pages range separator from en dash to hyphen.
	
\item 修正了v3.7以上版本中专利文献中公告日期后多出点的问题，该bug是由于输入公告日期没有使用printtext导致异步标点机制破坏所致。

correct a bug of newsdate in patent for biblatex >v3.7, which added an additional dot before urldate caused by broken asynchronous punctuation .

\item 修正了texlive2017以上版本中beamer类中标题后面多出点的问题，由于beamer会对bibmacro\{title\}做patch导致其输出不同于普通文档类，该bug是由于beamer升级后patch的内容发生变化导致。

correct a bug of punctuation after title with beamer for >texlive2017, the bug is caused by the update of beamer.
\end{enumerate}

[update latest](example/updatehistory.tex)

[update v1.0-v1.0j](example/updatehistoryold.md)


