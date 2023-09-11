<b>Date of last change: 2023-09-10 to version v1.1o</b>


# biblatex-gb7714-2015: a biblatex style  package
---------------------------------------------------------
[使用入门](#jumptotutorial)  |==| [说明文档](biblatex-gb7714-2015.pdf) |==| [WIKI](https://github.com/hushidong/biblatex-gb7714-2015/wiki) 
    

## Introduction

Maintainer: huzhenzhen <hzzmail@163.com>

Homepage: <https://github.com/hushidong/biblatex-gb7714-2015>

ctan-pkg: <https://www.ctan.org/pkg/biblatex-gb7714-2015>

License: LaTeX Project Public License 1.3c or later


A biblatex implementation of the `GB/T 7714-2015` bibliography style for Chinese users

The biblatex-gb7714-2015 package provides an implementation of the bibliography style of the `GB/T 7714-2015` bibliography style. This implementation follows `GB/T 7714-2015` standard, and can be used simply by loading biblatex with the appropriate option


biblatex-gb7714-2015 宏包是中文参考文献著录/标注标准 `GB/T 7714-2015` 的 biblatex 实现。它本质上是一个样式包，提供了顺序编码制和著者年份制样式，在 tex 文档中配合 biblatex 宏包使用，以生成满足《GB/T 7714-2015 信息与文献 参考文献著录规则》要求的参考文献。除了具备 biblatex 提供的不同于传统基于 bibtex 的参考文献解决方案的特点外，还具有如下特点：

* 较强的兼容性。能够兼容 biblatex v2.8 以上版本；能够兼容国标样式的一些常用条目类型、数据域。

* 较高的易用性。标注/著录格式完全由样式实现，不必为排序、多语言等问题手动处理bib文件；提供了丰富的标注（引用）命令，包括一些中文中习惯的命令；提供了多语言对照，多语言文献表等功能。

* 较大的灵活性。提供丰富的选项来帮助用户进行排序调整、著录项（姓名、出版项、文献标识符、标题超链接）格式调整、文献表格式（标签对齐、标签格式、条目格式、字体、段落格式）调整、编码兼容。

* 较好的维护性。样式代码主要是在标准样式基础上提供的中文国标解决方案，保持与标准样式一致的结构、风格和习惯，并提供详尽的注释，用户可轻松理解，并可在其基础上进一步修改以实现其它要求的样式，比如宏包附带的chinese-erj样式，就是基于本样式实现的经济学研究期刊的参考文献样式。

简单使用说明见：[使用入门](#jumptotutorial)

---------------------------------------------------------

## Need to do:

	* 注意：ms.bbx样式引入内容时需要特别注意空格的引入
	* 注意：mx.cbx样式没有更新一些新的设置（比如2篇文献就压缩等），若有需要可以参考15.cbx和15ay.cbx修改。
	* 应该说经过这些年的使用，很多corner case已经处理过了，但还是可能会存在一些，特别是ms和mx两个样式使用的少。
	* special characters in all fields?
	* entry without author: the delimiter between title and year?
	* TEST FOR texlive 2015,2016,2017
	* 标注中包围符号的定义[]、()、圆圈、方框等，有些命令没有去修改。



## Applications
* [BIThesis（bachelor graduation thesis for  Dept. of Undergraduate Academic Affairs of Beijing Institute of Technology.）](https://github.com/BITNP/BIThesis)
* [CAUTemplate(中国农业大学课程论文模板)](https://github.com/Cdmium/CAUTemplate)
* [CSUThesis(中南大学论文 Latex 模板 )](https://github.com/disc0ver-csu/csu-thesis)
* [ElegantBook](https://github.com/ElegantLaTeX/ElegantBook)
* [ECNU-Undergraduate-LaTeX(华东师范大学本科毕业论文模板)](https://github.com/YijunYuan/ECNU-Undergraduate-LaTeX)
* [fduthesis(复旦大学论文模板)](https://github.com/Stone-Zeng/fduthesis)
* [fjnu-bathesis (福建师范大学本科毕业论文LaTeX 模板)](https://github.com/fjnuer/fjnu-bathesis)
* [LaTeX-SWUFE-Bachelor-Thesis （西南财经大学本科毕业论文 LaTeX 模板）](https://github.com/sukanka/LaTeX-SWUFE-Bachelor-Thesis)
* [LZUthesis（兰州大学本科毕业论文LaTeX模板）](https://github.com/szsdk/LZUthesis)
* [neuthesis(东北大学博士学位论文Latex模板)](https://github.com/mervin0502/neuthesis)
* [NJU-thesis-esz（南京大学学位论文-微调整后适用于人文社科）](https://github.com/EdwardSaidZhou/NJU-thesis-esz)
* NKThesis（南开大学硕/博模板）[Template1](https://github.com/procuteboy/NKThesis) [Template2](https://github.com/NewFuture/NKThesis)
* [NKUBachelorThesis（南开大学本科生毕业论文(毕业设计)LaTeX模板）](https://github.com/NKcqx/NKUBachelorThesis)
* [nputhesis（NPU 博士、硕士学位论文 \LaTeX 模板）](https://github.com/NPUSCG/nputhesis)
* [nuaa-thesis（南京航空航天大学本科、硕士和博士学位论文的样式模板）](https://github.com/nuaa803/nuaa-thesis)
* [nudtpaper(nudt学位论文模板)](https://github.com/liubenyuan/nudtpaper)
* [shtthesis (ShangHaiTech university THESIS)](https://github.com/lirundong/shtthesis)
* [SHMTUThesis（上海海事大学 LaTeX 学位论文模板）](https://github.com/hellckt/SHMTUThesis)
* [SJTUThesis(上海交通大学学位论文模板)](https://github.com/sjtug/SJTUThesis) (母校的论文模板，不得不说缘分真的很神奇，16年一出来就用上)
* [sustechthesis（Southern University of Science and Technology Thesis Template LaTeX Template）](https://github.com/Iydon/sustechthesis)
* [SwufeTeX（西南财经大学学位论文LaTeX模板）](https://github.com/OopsYao/swufethesis)
* [Thesis-Template-for-XJTU (西安交大毕业设计模板)](https://github.com/DXie123/Thesis-Template-for-XJTU)
* [ThuThesis（LaTeX Thesis Template for Tsinghua University ）](https://github.com/tuna/thuthesis)
* [TongjiThesis(同济大学硕博士论文LaTeX模板)](https://github.com/marquistj13/TongjiThesis)
* [UCASthesis(中国科学院大学学位论文模板**国科大新版标准**)](https://github.com/xiaoyao9933/UCASthesis)
* [UCASthesis(ucasthesis 国科大学位论文 LaTeX 模板 [最新样式])](https://github.com/mohuangrui/ucasthesis)
* [ustcthesis（中国科学技术大学学位论文 LaTeX 模板）](https://github.com/ustctug/ustcthesis)
* [WUTthesis（武汉理工大学研究生学位论文的 LaTeX 模板）](https://github.com/Jiayin-Gu/WUTthesis)
* [whu-thesis（武汉大学毕业论文 LaTeX 模板）](https://github.com/whutug/whu-thesis)
* [Yet anoter BUPT Thesis LaTeX class (北邮研究生学位设计的LaTeX文档类)](https://github.com/qcts33/BUPTthesis-ctex)
* [Zhejiang University thesis(浙江大学毕业设计/论文模板)](https://github.com/TheNetAdmin/zjuthesis)
* [《经济研究》杂志 LaTeX 论文模板)](https://github.com/EthanDeng/Chinese-ERJ)
* [LaTeX学习笔记（Study-LaTeX)](https://github.com/Zousiyu/Study-LaTeX)
* [...]


## Related Links

* [Biblatex 宏包](https://github.com/plk/biblatex)
* [Beamer 文档类](https://github.com/josephwright/beamer)
* [biblatex 宏包中文手册 ](https://github.com/hushidong/biblatex-zh-cn)
* [biblatex 简明使用手册](https://github.com/hushidong/biblatex-solution-to-latex-bibliography)
* [biblatex-tutorial 摘译](https://github.com/hushidong/biblatex-tutorial-cn)
* [bibmap  bib文件批量修改工具](https://github.com/hushidong/biblatex-map/)
* [biblatex-check bib文件检查工具](https://github.com/Pezmc/BibLatex-Check)
* [biblatex-caspervector: caspervector 设计的中文参考文献样式](https://github.com/CasperVector/biblatex-caspervector)
* [gbt7714-bibtex-style: GB/T7714-2015 标准的bst实现版本](https://github.com/CTeX-org/gbt7714-bibtex-style)
* [LaTeX学习网站](http://www.latexstudio.net/)
* [LaTeX交流论坛](http://www.ctex.org/)

---------------------------------------------------------

<h2 id="jumptotutorial">Tutorial/使用入门</h2>
[//]: # "这里这种方式不适合可能主要是因为标题所导致，因此用上面的方式进行处理"


<h3 id="jumptopkgload">0. pacakge usage/宏包加载方式</h3>
样式包配合biblatex使用，即在biblatex调用时加载样式包：

* 顺序编码制样式(gb7714-2015)：

```
	\usepackage[backend=biber,style=gb7714-2015]{biblatex}
```

* 著者-出版年制样式(gb7714-2015ay)：

```
	\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}
```

* 同一文献表中不同语言区分不同著录格式的样式(gb7714-2015ms)：

```
    %设置gbstyle=false，中文文献使用GB/T 7714-2015著录格式，而其它语言文献使用biblatex标准样式
    \usepackage[backend=biber,style=gb7714-2015ms,gbstyle=false]{biblatex}
```

* 同一文档中不同文献分节区分不同著录格式的样式(gb7714-2015mx)：

```
    %gb7714-2015mx默认使用顺序编码制样式
    \usepackage[backend=biber,style=gb7714-2015mx]{biblatex}
    %如需在某一参考文件分节使用著者年份制样式，比如第2个refsection中使用时，则在导言区设置：
    \setaystylesection{2}
```

* 标注（引用）样式和著录样式区分使用：
```
\usepackage[backend=biber,citestyle=gb7714-2015,bibstyle=gb7714-2015ay]{biblatex}
```
或（类似的方式均可）
```
\usepackage[backend=biber,citestyle=gb7714-2015ay,bibstyle=gb7714-2015]{biblatex}
```

* 宏包选项的使用：

```
    %设置gbalign选项以改变文献表序号标签对齐方式，
    %设置gbpub=false取消缺省出版项自填补信息，比如:
    \usepackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015,gbpub=false]{biblatex}
```



更多宏包选项的说明见：[biblatex-gb7714-2015.pdf](biblatex-gb7714-2015.pdf)

宏包加载的完整文档示例见：[tex文档一般结构](#jumptotexsrcf)

<h3 id="jumptotexsrcf">1. Tex source file/tex文档一般结构</h3>
注意其中加载biblatex宏包的代码：

```
\documentclass{article}%文档类%导言区开始:

\usepackage{ctex}%加载ctex宏包，中文支持

\usepackage{geometry}%加载geometry宏包，定义版面

\usepackage[colorlinks=true,pdfstartview=FitH,%
linkcolor=blue,anchorcolor=violet,citecolor=magenta]{hyperref}%加载hyperref宏包，使用超链接

\usepackage[backend=biber,bibstyle=gb7714-2015,%nature,%%加载biblatex宏包，使用参考文献
citestyle=gb7714-2015%,backref=true%%其中后端backend使用biber
]{biblatex}%标注(引用)样式citestyle，著录样式bibstyle都采用gb7714-2015样式

\usepackage{filecontents}
\begin{filecontents}{egbibdata.bib}
@Book{Peebles2001-100-100,
  Title                    = {Probability, random variable, and random signal Principles and \LaTeX{}},
  Address                  = {New York},
  Author                   = {von Peebles, Jr., P. Z.},
  Edition                  = {4},
  Pages                    = {100},
  Publisher                = {McGraw-Hill},
  Year                     = {2001}
}

@Book{蔡敏2006--,
  Title                    = {UML基础和Rose建模教程},
  Address                  = {北京},
  Author                   = {蔡敏 and 徐慧慧 and 黄柄强},
  Publisher                = {人民邮电出版社},
  Year                     = {2006},
  Month                    = {1}
}
\end{filecontents}

\addbibresource[location=local]{egbibdata.bib}%biblatex宏包的参考文献数据源加载方式

\begin{document}%正文区开始:

%正文内容，引用参考文献

一、基本用法

见文献\cite{Peebles2001-100-100}\\
见文献\parencite{Peebles2001-100-100}\\
见文献\citet{Peebles2001-100-100}\\
见文献\citep{Peebles2001-100-100}\\


二、详细用法

1. 不带页码的引用(顺序编码制上标，方括号包围；作者年制行内，括号包围):\\
	见文献\cite{Peebles2001-100-100}\\
	见文献\upcite{Peebles2001-100-100}\\
	见文献\supercite{Peebles2001-100-100}

2. 不带页码的引用(顺序编码制非上标，方括号包围；作者年制行内，括号包围):\\
	见文献\parencite{Peebles2001-100-100}\\
	见文献\citep{Peebles2001-100-100}

3. 带页码的引用(标准命令，默认样式; 增加命令，GB/T 7714-2015样式):\\
	见文献\cite[见][49页]{蔡敏2006--}\\
	见文献\parencite[见][49页]{Peebles2001-100-100}\\
	见文献\pagescite{Peebles2001-100-100}\\
	见文献\pagescite[201-301]{Peebles2001-100-100}

4. 顺序编码制中同时输出作者和顺序编码标签，比如：\\
	见\citet{蔡敏2006--}（顺序编码标签上标）\\
	见\authornumcite{蔡敏2006--}\\
	见\textcite{蔡敏2006--} (顺序编码标签不上标)
	见\citeauthor{蔡敏2006--}\cite{蔡敏2006--}\\

5. 作者年制文中已有作者还需要年份和页码(顺序编码制与pagescite作用相同，作者年制年份行内页码上标):\\
	见蔡敏\yearpagescite[][205]{蔡敏2006--}和Peebles\yearpagescite[][15]{Peebles2001-100-100}

6. 作者年制文中已有作者只需要年份(顺序编码制与pagescite作用相同，作者年制年份行内):\\
	见赵耀东\yearcite{蔡敏2006--}\\
	见赵耀东(\cite*{蔡敏2006--})\\
	见赵耀东(\citeyear{蔡敏2006--})

7. 作者年制中由标注命令给出作者年份信息，作者以主语方式作为正文内容：\\
	见\cite{蔡敏2006--}\\
	见\parencite{蔡敏2006--}\\
	见\textcite{蔡敏2006--}\\
	见\citet{蔡敏2006--}\\
	见\citep{蔡敏2006--}\\

8. 在页脚中引用和打印文献表:\\
	见文献\footnote{在脚注中引用\footcite{蔡敏2006--}}\\
	见文献\footfullcite{蔡敏2006--}


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

或者

```
	latexmk -xelatex jobname.tex
```

编译引擎使用lualatex也是可以的，只要该引擎编译时ctex宏包能够正确支持中文。


### 3. Recommended environment/推荐使用环境

- Texlive+Winedt
- Texlive+Texstudio
- texlive及其它发行版安装见[安装指南](https://github.com/sjtug/SJTUThesis/wiki/%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97)
	
	
### 4. Common questions/常见问题

#### 4.1 Installation and use/安装和使用

* <b>怎么利用biblatex生成国标GB/T 7714-2015格式的参考文献表？</b>

(1)在导言区加载biblatex宏包，并使用gb7714-2015样式:

```		\usepackage[backend=biber,style=gb7714-2015]{biblatex}```

(2)正文中引用参考文献:

```	见文献\cite{referencbibtexkey}```

(3)在需要的地方打印参考文献表:

```\printbibliography```
更直接的例子见前述的[tex源文档](#jumptotexsrcf)
		
		
		

* <b>请问我应该怎么安装和更新biblatex-gb7714-2015宏包？</b>
		

biblatex-gb7714-2015宏包是基于biblatex的样式宏包，目前texlive，miktex都已收录，因此可以直接使用，一般不需要安装。

如果使用时，系统提示找不gb7714-2015.bbx或gb7714-2015ay.bbx文件的错误，说明当前tex系统未安装biblatex-gb7714-2015样式包，这时需要安装它。

最简单的方法是从本项目源码中下载 gb7714-2015.bbx, gb7714-2015ay.bbx, gb7714-2015.cbx, gb7714-2015ay.cbx 四个文件放到你要编译的主文档所在目录，如果需要使用gbk编码，则还需复制 gb7714-2015-gbk.def 文件。对于已经安装的用户需要更新到最新版，也可以下载这些文件替换系统已经安装的文件。



* <b>请问使用时biblatex-gb7714-2015宏包时出现错误“ Package xkeyval Error: gb****** ' undefined in families blx@opt@pre'. [\blx@processoptions] ”？</b>



因为宏包的功能不断增加和完善，当在tex源文档中，使用新版中的一些选项时，而系统中的biblatex-gb7714-2015宏包是旧版时，就会出现`gb****`选项未定义的错误。解决方法就是更新biblatex-gb7714-2015宏包。更新方法见上一个问题。



* <b>为什么我之前使用样式`style=caspervector`进行编译没有问题，换成`style=gb7714-2015`后，编译就出现错误？</b>

可能有三个原因：

（1） 辅助文件没有清理导致，当采用caspervector样式时编译产生的辅助文件中可能带有该样式的一些特有信息，由此产生一些不兼容。因此需要的操作是，清除辅助文件，然后再进行编译。清除命令为(下面的命令是windows下的，linux下的是类似的只需把删除命令换成`rm -f`)：

```del /q *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.xml *.synctex *.nlo *.nls *.bak *.ind *.idx *.ilg *.lof *.lot *.ent-x *.tmp *.ltx *.los *.lol *.loc *.listing *.gz *.synctex(busy) *.nav *.snm *.vrb *.fls *.xdv *.fdb_latexmk```

（2） biblatex-gb7714-2015 版本过于陈旧，旧版本对于一些特殊情况可能考虑不全面。因此需要的操作是更新biblatex-gb7714-2015，方法见上一个问题。

（3） 编译命令问题，通常情况下tex文档和bib文档是utf8编码的，因此最好采用xelatex编译，而不用pdflatex。因此如果编译时用pdflatex出现错误，请换成xelatex。


* <b>为什么我编译文档后没有出现参考文献表？</b>

当编译过程出现错误时，那么检查错误的原因，并解决它。
当编译过程没有出现错误，那么很有可能是没有采用正确的命令进行文献编译，比如采用了传统的bibtex而不是biber。那么采用正确的编译命令重新编译即可：
```
xelatex jobname.tex
biber jobname
xelatex jobname.tex
```

* <b>使用biblatex时运行简单示例也出现错误，查看biber输出结果似乎不正常，这种情况怎么解决？</b>

由于biber在第一次运行时会在缓存文件夹下创建一些二进制运行文件，如果这些文件被破坏，那么biber运行结果会出现莫名其妙的错误。比如：
biber运行一半就结束了，log信息如下所示：

```
	INFO - This is Biber 2.16
	INFO - Logfile is 'thuthesis-example.blg'
	INFO - Reading 'thuthesis-example.bcf'
	INFO - Found 34 citekeys in bib section 0
	INFO - Processing section 0
	INFO - Looking for bibtex format file 'ref/refs.bib' for section 0
	INFO - LaTeX decoding ...
	INFO - Found BibTeX data source 'ref/refs.bib'
```
这次运行中只是找到了bib文件，并没有下一步的处理，显然是存在问题的。

因此如果出现这种情况，可以手动删除缓存文件夹，让biber重新创建。这些缓存文件夹名字通常为：

```
    par-<hex_encoded_username>/cache-*
    par-<hex_encoded_username>\cache-*
```

在不同的系统下面，缓存文件夹的位置是不同的，可能的位置包括：

```
    /var/folders/*/*/*/ (OSX, local GUI login shell)
    /var/tmp/ (OSX (remote ssh login shell), Unix)
    /tmp/ (Linux)
    C:\Documents and Settings\<username>\Local Settings\Temp (Windows XP/Cyg- win)
    C:\Windows\Temp (Windows)
    C:\Users\<username>\AppData\Local\Temp (Windows 7/8)
```

也可以从运行得到的.blg文件或者命令`biber --cache`来找到缓存文件夹。

删除缓存文件夹操作，在Linux和Mac下可以使用如下命令操作：
```
rm -rf `biber --cache`
```

在windows下，那么其实随便用个清理软件把临时文件夹清理一下就行。直接点就是找到`par-<hex_encoded_username>/cache-*`缓存文件夹然后删除它。


* <b>为什么利用 ctex2.9 套装进行编译时，出现错误？</b>
	

由于ctex2.9套装多年未更新，其中的biblatex宏包过于陈旧，所以需要更新 biblatex。



* <b>请问除了利用xelatex进行编译外，能不能用pdflatex进行编译？</b>
	

能用pdflatex进行编译。但要注意的是因为某些样式比如authoryear等使用了xstring宏包中的一些命令，所以会产生错误，但numeric类样式通常没有问题。这一问题在biblatex更新到3.12版本后取消xstring宏包后得以解决。

中文用户需要注意一些编码的问题：

utf-8编码的文档，采用xelatex编译没有任何注意事项，但使用pdflatex编译时，需要给ctex宏包加载UTF8选项，比如`\usepackage[UTF8]{ctex}`或者在文档类加载时给出也可以比如`\documentclass[[UTF8]{article}`,同时引用文献时使用的引用关键词应使用英文。

当文档使用其他编码时，xelatex编译通常需要指定一个文档编码，比如windows环境下的GB2312编码的文档需要指定`\XeTeXinputencoding "GBK"`， 否则显示乱码。使用pdflatex进行编译，如果biblatex不能正确的处理编码问题，那么需要为其明确的指定texencoding和bibencoding选项。比如windows环境下的GB2312编码的文档，需要指定`\usepackge[texencoding=GBK]{biblatex}`。


* <b>请问要给biblatex-gb7714-2015设置一些选项，但模板已经将biblatex调用写死且不方便修改，该如何处理？</b>

可以使用PassOptionsToPackage命令来实现。，比如将gbnamefmt=lowercase选项传递给biblatex，那么可以使用如下命令：
```
\PassOptionsToPackage{gbnamefmt=lowercase}{biblatex}
```
需要注意的是要使该命令生效，这条命令需要在调用biblatex之前出现，可以放到导言区调用biblatex之前，也可以放到文档类调用之前(即documentclass命令之前)，比如：

```
\PassOptionsToPackage{gbpub=false}{biblatex}

\documentclass[twoside]{article}
\usepackage{ctex}
\usepackage[backend=biber,style=gb7714-2015,gbalign=center]{biblatex}
```



* <b>请问使用backref=true选项后，某个反向超链接总是链接到封面页是怎么回事？</b>
	

对页码进行正确超链接需要一个前提是，当前链接的页码是唯一的。当有两页具有相同的页码时，超链接总是链接到第一各具有该页码的页面上。比如封面页页码是1，正文第一页页码也是1，那么到正文第一页的反向超链接总会链接到封面页上。解决该问题就是要解决页码的唯一性问题。当页码的表示形式不是同一种时，那么也会得到正确的区分。比如封面页用罗马字母I表示，而正文第一页用阿拉伯数字1表示，那么就能得到正确的反向超链接。类似于:

```
\pagenumbering{roman}
\title{title}
\maketitle
\clearpage

\pagenumbering{arabic}
\section{文献表}
```


* <b>我希望参考文献表中的文献不是按引用顺序而是以文献作者的字母顺序排序，怎么实现？</b>
		

一般情况下文献表是按引用顺序进行排列，标签是顺序的数字，这种方式称为顺序编码制。
如果要以文献作者字母顺序排列，那么可以换一种编制方式，称为作者年制:

```\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}```

如果要求使用顺序编码制文献表，又要以文献作者字母顺序排列，那么可以增加排序选项`sorting=nyt`，意为按照姓名、年份、标题的字母顺序进行排序:

```\usepackage[backend=biber,style=gb7714-2015,sorting=nyt]{biblatex}```
	
	
	
* <b>作者年制中英文文献能按字母顺序排列，那么中文文献能否以拼音或者笔画进行排序呢？</b>
	

能，有两种方式实现：

（1）通过编译时给biber设置选项来实现:

```
%按拼音排序，biber命令
biber -l zh__pinyin jobname
%按笔画排序，biber命令
biber -l zh__stroke jobname
```

（2）通过增加 biblatex 选项来实现（此时biber编译无需另加选项），比如：

```\usepackage[backend=biber,style=gb7714-2015ay,sortlocale=zh__pinyin]{biblatex}```



* <b>作者年制参考文献表目前的排序时升序排列，能不能改成降序排序？</b>
		

能，通过修改sorting选项实现:


```\usepackage[backend=biber,style=gb7714-2015ay,sorting=gbnytd]{biblatex}```

可用的选项值包括:
```
nty 按照姓名、标题、年份排序。
nyt 按照姓名、年份、标题排序。
nyvt 按照姓名、年份、卷数、标题排序。
anyt 按照字母标签、姓名、年份、标题排序。
anyvt 按照字母标签、姓名、年份、卷数、标题排序。
ynt 按照年份、姓名、标题排序。
ydnt 按照年份（降序）、姓名、标题排序。
none 不进行排序。所有的条目按照引用顺序处理。
gb7714-2015 以语言、作者、年份、标题、升序排列
gbnytd 以语言、作者、年份、标题、降序排列
gbynta 以语言、年份、作者、标题、升序排列
gbyntd 以语言、年份、作者、标题、降序排列
```

* <b>如果我还希望顺序编码的文献著录表以拼音排序，请问该怎么操作？</b>

顺序编码文献著录表默认是按引用顺序排序，但可以通过设置sorting选项进行调整，比如sorting=nyt表示按作者姓名年份以及文献标题进行排序。要使中文能按拼音排序，可以设置本地化排序调整方案，即sortlocale选项，比如:

```\usepackage[backend=biber,citestyle=gb7714-2015ay,bibstyle=gb7714-2015,sorting=nyt,sortlocale=zh__pinyin]{biblatex}```





* <b>我希望文献表以阿拉伯数字编号，而正文中的引用标签使用作者和年份标注而不是数字，请问我该如何处理？</b>

可以设置不同的标注和著录样式，比如标注样式用作者年制，而著录样式用顺序编码制，比如:

```\usepackage[backend=biber,citestyle=gb7714-2015ay,bibstyle=gb7714-2015]{biblatex}```

但这种情况下，文献表中的年份信息是在出版项里面的，如果要提前到作者后面，可以使用如下方式：

```\usepackage[backend=biber,style=gb7714-2015ay,gbgalign=right]{biblatex}```

如果要让年份信息既出现在作者后面又出现在出版项里面，那么还可以增加mergedate选项进行控制：

```\usepackage[backend=biber,style=gb7714-2015ay,gbgalign=right,mergedate=false]{biblatex}```

这种情况下，直接用gb7714-2015ay下的gbgalign选项来生成数字标签的文献表，而且可以使用right/left/center/gb7714-2015等不同的选项值来实现不同对齐形式的标签。

反过来如果要在文中引用是数字标签，而文献表是无数字标签的样式，那么也可以使用下面两种方式：

```\usepackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015ay]{biblatex}```

这种情况下，文献表中的年份信息是在出版项里面的，如果要提前到作者后面，则使用：

```\usepackage[backend=biber,citestyle=gb7714-2015,bibstyle=gb7714-2015ay]{biblatex}```

类似的也可以使用mergedate选项来控制年份的显示情况：

```\usepackage[backend=biber,citestyle=gb7714-2015,bibstyle=gb7714-2015ay,mergedate=false]{biblatex}```

参见:[issue:参考文献的顺序](https://github.com/sjtug/SJTUThesis/issues/300) , 
[issue90](https://github.com/hushidong/biblatex-gb7714-2015/issues/90)






​	
* <b>请问如果参考文献中存在一些特殊字符比如&或者一些特殊命令比如\LaTex{}等，是不是会出现问题？</b>
	

通常不会出现问题，直接输入即可，当出现问题时可以手动调整比如修改为`\&`和`{\LaTex{}}`



* <b>如果希望在参考文献中直接使用一些unicode字符比如希腊字母等而不想用数学环境中的命令，请问该怎么处理？</b>
	

直接显示希腊字母等unicode字符需要字体的支持，比如CMU Serif等，可以在整个文档全局使用该字体，也可以仅在文献表中使用该字体，比如：

```
{
\newcommand{\ftcmu}{\fontspec{CMU Serif}\selectfont}
\renewcommand{\bibfont}{\ftcmu}%设置英文字体不影响中文字体
\printbibliography
}
```

当然字体设置需要fontspec宏包的支持。



* <b>如何修改参考文献文献表的垂直间距(竖直间距)？</b>

设置如下尺寸即可

```
% 间距的控制
\setlength{\bibitemsep}{0ex}
\setlength{\bibnamesep}{0ex}
\setlength{\bibinitsep}{0ex}

```
其中itemsep设置各条文献之间的间隔，一般够用，后面两个常在西文中使用。具体意义参考biblatex-zh-cn



* <b>如何修参考文献表的缩进？</b>

对于著者-出版年制文献表，设置如下尺寸即可:
```
% 文献表中各条文献的缩进控制
\setlength{\bibitemindent}{0em} % bibitemindent表示一条文献中第一行相对后面各行的缩进
\setlength{\bibhang}{0pt} % 著者-出版年制中 bibhang 表示的各行起始位置到页边的距离     
```

对于顺序编码制文献表，可以采用如下方法：

由于顺序编码制存在数字标签，且其宽度与参考文献数量相关的，在biblatex中这个宽度是一个动态变量，不是提前设定的，而是在文献表生成时给出，所以设定缩进需要更复杂的操作。

对于采用list环境的文献表，即设置gbalign=left、right、center时，那么需要修改文献表环境来设定缩进，比如：

```
%调整顺序标签与文献内容的间距
\setlength{\biblabelsep}{2mm}
%修改对齐环境-使不缩进
\defbibenvironment{bibliography}
  {\list
     {\printtext[labelnumberwidth]{%
        \printfield{labelprefix}%
        \printfield{labelnumber}}}
     {%这里是所做的调整，通过设置\bibitemindent，\bibhang调整缩进
     \addtolength{\bibitemindent}{\labelnumberwidth}%
    \addtolength{\bibitemindent}{\biblabelsep}%
    \addtolength{\bibhang}{-\labelnumberwidth} %
    \addtolength{\bibhang}{-\biblabelsep}%
    %以下是默认的设置
     \setlength{\labelwidth}{\labelnumberwidth}%
      \setlength{\labelsep}{\biblabelsep}%
      \setlength{\leftmargin}{\bibhang}%
      \addtolength{\leftmargin}{\labelnumberwidth}%
      \setlength{\itemindent}{\bibitemindent}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}%
      \renewcommand*{\makelabel}[1]{\hss##1}}
  {\endlist}
  {\item}
```

对于不采用list环境的文献表，即设置gbalign=gb7714-2015时，可以采用如下设定：

```
%调整顺序标签与文献内容的间距
\setlength{\biblabelsep}{2mm}
%修改对齐环境-使不缩进
\renewcommand{\itemcmd}{%
\settowidth{\lengthid}{\mkgbnumlabel{\printfield{labelnumber}}}
%%这里是所做的调整，以下两句通过调整\lengthid来调整缩进
\setlength{\lengthid}{0pt}
\addtolength{\lengthid}{-\biblabelsep}
%如下是默认设置
\addtolength{\lengthid}{\biblabelsep}
\setlength{\lengthlw}{\textwidth}
\addtolength{\lengthlw}{-\lengthid}
\addvspace{\bibitemsep}%恢复\bibitemsep的作用
%\parshape 2 0em \textwidth \lengthid \lengthlw
\hangindent\lengthid
\mkgbnumlabel{\printfield{labelnumber}}%
\hspace{\biblabelsep}}
```

示例见：[issue](https://github.com/hushidong/biblatex-gb7714-2015/issues/62)




* <b>如何修改参考文献表的字体字号？</b>

通过修改如下命令实现

```
% 字体的控制： \textit， sl， emph-楷体， \textbf， sf-黑体， \texttt-仿宋， \textsc， md， up-宋体
% 全局字体
\renewcommand{\bibfont}{\zihao{-5}}%\fangsong
% 题名字体
\renewcommand{\bibauthorfont}{\bfseries\color{teal}}%
\renewcommand{\bibtitlefont}{\ttfamily\color{blue}}%
\renewcommand{\bibpubfont}{\itshape\color{violet}}%
% url和doi字体
\def\UrlFont{\ttfamily} %\urlstyle{sf} %\def\UrlFont{\bfseries}
```

​	
* <b>我习惯用传统的bst文件来生成参考文献，有没有GB/T 7714-2015标准的实现版本？</b>
	

GB/T 7714-2015标准实现的bst版本，已经由[zeping lee](https://github.com/CTeX-org/gbt7714-bibtex-style)开发完毕，直接使用即可。



* <b>我在使用过程中遇到了一些无法理解和无法解决的问题，怎么办？</b>
	

请邮件联系hzzmail@163.com或在项目内发issue提问即可。


* <b>注意帮助的文档的查询顺序？</b>

一般用户的话查：biblatex-gb7714-2015.pdf，biblatex-solution-to-latex-bibliography.pdf,biblatex-zh-cn.PDF。
宏包作者的话查：gb7714-2015*.C/BBX,biblatex.PDF,numeric/authoryear.c/BBX,standard.bbx,biblatex.def,biblatex.sty,english.lbx
注意别忘了lbx文件。


#### 4.2 Bibliography format/文献表著录格式

* <b>请问可以在参考文献表中实现类似于word那样的与文献内容等间距标签对齐格式么？</b>
	

可以，latex的列表通常用list来实现，因此一般列表的内容都是对齐的，
此时如果标签右对齐的，那么标签和内容等间距，但标签左侧是不对齐的。
如果标签是左对齐的，那么标签和内容的间距不相等。
如果要求标签左侧对齐，且标签与内容等间距必须放弃使用list。
biblatex-7714-2015的顺序编码制样式特别设计了这样的环境，以保持和word一致。通过设置选项gbalign来实现:

```\usepackage[backend=biber,bibstyle=gb7714-2015,gbalign=gb7714-2015]{biblatex}```
		
				

* <b>如果不希望在参考文献表中出现类似“出版地不详”“出版者不详”等信息时，请问该怎么处理？</b>
	

设置选项gbpub可以实现，当gbpub=false时，biblatex-gb7714-2015宏包会放弃国标的要求，不使用“出版地不详”等补充信息:

```\usepackage[backend=biber,bibstyle=gb7714-2015,gbpub=false]{biblatex}```


​	
* <b>我觉得文献表中英文作者全部用大写不好看，请问能换一种大小写方式么？</b>
	

能，通过设置gbnamefmt可以实现，默认情况下gbnamefmt=uppercase，作者姓名字母全部大写。
当设置gbnamefmt=lowercase时，biblatex-gb7714-2015宏包对于bib文件中的作者姓名的大小写不做改变，
这时可以在bib文件中手动设置想要的大小写方式。
当要实现类似ZHAO Yu-xin这样的拼音方式，则可以设置gbnamefmt=pinyin:

```\usepackage[backend=biber,bibstyle=gb7714-2015,gbnamefmt=lowercase]{biblatex}```
		
		
		
* <b>如果不希望在参考文献表中出现类似“[M]”“[J]”等文献类型标识符时，请问该怎么处理？</b>
	

可通过设置选项gbtype=false实现:

```\usepackage[backend=biber,bibstyle=gb7714-2015,gbtype=false]{biblatex}```
		
		
		
* <b>如果不希望在参考文献表中出现网址信息时，请问该怎么处理？</b>
	

可通过设置选项url=false实现:

```\usepackage[backend=biber,bibstyle=gb7714-2015,url=false]{biblatex}```
	
	
	
* <b>如果不希望在参考文献表中出现DOI信息时，请问该怎么处理？</b>
	

可通过设置选项doi=false实现:

```\usepackage[backend=biber,bibstyle=gb7714-2015,doi=false]{biblatex}```
		


* <b>如果对当前文献中的url或doi显示效果(包括间距和断行)不满意，能否进行调整？</b>
	

能，可以通过设置三个计数器的值来调整，取值范围0到9999，计数器的值越大则越容易在相应的内容后断行:

```
\setcounter{biburlnumpenalty}{100}%大于0允许在数字后面断行
\setcounter{biburlucpenalty}{100}%大于0允许在大写字母后面断行
\setcounter{biburllcpenalty}{100}%大于0允许在小写字母后面断行
```

* <b>中英文混排，有些英文断行不佳，导致行溢出，怎么解决？</b>
	

biblatex的参考文献表的换行是由tex的断行机制决定的，处理行（盒子）溢出就要用tex的方式处理：

直接使用`\sloppy`命令

```
{
\sloppy
\printbibliography[heading=subbibintoc,title=【参考文献】]
}
```
或者自己设置具体断行相关的参数
```
 {
 %\hyphenation{Proce-edings}
 \hyphenpenalty=5000 %断词阈值， 值越大越不容易出现断词
 \tolerance=500      %丑度， 10000为最大无溢出盒子， 参考the texbook 第6章
 \hbadness=100       %如果丑度超过hbadness这一阀值， 那么就会发出警告
 \printbibliography[heading=subbibintoc,title=【参考文献】]
}
```

当然如果不想这么设置，可以手动的修改参考文献条目的内容，在需要换行的内容前加上-符号。
见：https://github.com/hushidong/biblatex-gb7714-2015/issues/89


* <b>参考文献表的每一页的页面底部不对齐，怎么处理？</b>

通常是由一条参考文献内部不分页导致的，默认情况下希望一条参考文献条件放在一个页面内，所以在页面底部的文献可能由于放不下跑到下一页。
这种情况可以通过调整段内的分页阈值改变，即使得一条参考文献(即一个段内)更容易分页即可：

```
{
  \interlinepenalty=5000  %分页阈值，越小越容易分页
 \printbibliography[heading=subbibintoc,title=【参考文献】]
}  
```



​	
* <b>当参考文献没有作者时，希望用佚名或Anon代替作者时，请问该怎么处理？</b>
	

可通过设置选项gbnoauthor=true实现，注意该处理主要用在作者年制中:

```\usepackage[backend=biber,bibstyle=gb7714-2015,gbnoauthor=true]{biblatex}```
		
		
		
* <b>如果希望参考文献表中文献作者数量超过国标规定的3个时，请问该怎么处理？</b>
	

可通过设置选项maxbibnames，minbibnames实现，比如下面的设置用于显示5个作者:

```\usepackage[backend=biber,bibstyle=gb7714-2015,maxbibnames=5,minbibnames=5]{biblatex}```


* <b>请问如何将作者之间的分隔符调整为and而不是用逗号？</b>
	

可以通过重设两个分隔符来实现，分别是multinamedelim和finalnamedelim。低版本的biblatex直接重定义命令`\multinamedelim`和`\finalnamedelim`，高版本的biblatex可以使用分隔符环境，这样可以在标注、文献表等不同位置直接使用不同的分隔符，而不像低版本biblatex那样只能在不同的位置修改局部定义。比如:

```
\DeclareDelimFormat[bib]{multinamedelim}{\addspace and \addspace}
\DeclareDelimFormat[bib]{finalnamedelim}{\addspace and \addspace}
\DeclareDelimFormat[cite]{multinamedelim}{\addcomma\addspace}
\DeclareDelimFormat[cite]{finalnamedelim}{\addcomma\addspace}
```


​	
* <b>请问如何使文献表中文献标题的是句首字母大写而其它所有字母均小写？</b>
	

默认情况下，biblatex-gb7714-2015仅对标题首字母做调整，使其变成为大写，而其他字母大小写不做处理，因此要得到想要的字母大小写格式，需要在bib文件输入参考文献信息时给出需要的除首字母外的其它字母的大小写格式。

若有特殊情况，需要首字母为小写，可采用如下两种方法：

（1）根据字符大小写更换命令比如

`{\MakeLowercase i}FogSim title contents`

（2）修改titlecase域格式，即将如下命令放到导言区中，放在biblatex宏包加载命令后面

```
\DeclareFieldFormat{titlecase}{\iftoggle{bbx:titlelink}{%
\iffieldundef{url}{#1}{%
\href{\thefield{url}}{#1}}}{#1}}%重设标题格式，将去除首字母大写
```

注意：v1.1g版本后不再默认修改标题的字母大小写，若需要修改可以手动修改bib文件，若需要批量修改，可以使用[bibmap](https://github.com/hushidong/biblatex-map/)工具。


​		
* <b>请问如何使文献表中的期刊名是单词首字母大写的？</b>
	

默认情况下，biblatex-gb7714-2015不对期刊名的字母大小写做处理，
因此需要在bib文件输入参考文献信息时给出需要的大小写格式。


​		
* <b>我想得到中英文对照的双语参考文献，请问该如何处理？</b>
	

biblatex-gb7714-2015设计了两种多语言对照参考文献的实现方式，
一种是利用条目集的概念，另一种是利用关联条目的概念。
因此有两种方法:

（1）方法一，动态定义条目集:
在导言区或正文中定义:
```\defbibentryset{易仕和，等，2013}{易仕和2013--,Yi2013--}```

在正文中引用:
```双语文献引用\cite{易仕和，等，2013}```

（2）方法二，动态定义关联条目:
在导言区定义:
```\defdoublelangentry{易仕和2013--}{Yi2013--}```

在正文中引用:
```双语文献引用\cite{易仕和2013--}```




* <b>我想修改文献条目的日期项诸如格式，请问该如何处理？</b>

参考文献中日期格式主要有四种修改方式：
（1） 利用biblatex选项全局的修改日期格式
（2） 修改日期输出宏，使根据条目类型输出不同的日期格式
（3） 修改日期输出宏，使根据具体条目输出不同的日期格式
（4） 修改参考文献信息，使当前条目原样输出需要的格式

具体示例见：[biblatex中如何修改参考文献中日期的著录格式](https://blog.csdn.net/xenonhu/article/details/86933525)


* <b>我希望将文献表中期刊文献的卷和期使用加粗格式，请问该如何处理？</b>

调整其域格式输出即可，比如：

```
\DeclareFieldFormat[article,periodical]{volume}{\textbf{#1}}
\DeclareFieldFormat[article,periodical]{number}{\textbf{#1}}
```

见：[issue](https://github.com/sjtug/SJTUThesis/issues/580)

​	
#### 4.3 Citation format/正文引用的标注格式

* <b>我希望在正文中同时使用上标和非上标的引用标签，请问该怎么操作？</b>
	

可以使用不同的命令来实现上标和非上标的标签，
上标标签的命令为`\cite{bibtexkey}` ，非上标标签的命令为 `\parencite{bibtexkey}`。
当希望上标的标签也给出国标要求的页码时，则可以使用`\cite[50-55]{bibtexkey}`、`\pagescite[50-55]{bibtexkey}`给出指定页码 或者`\pagescite{bibtexkey}` 直接使用bib文件中的页码。


​	
* <b>我在引用文献时已经给出作者信息，希望引用标签仅包含年份和页码信息或者仅包含年份信息时，该怎么操作？</b>
	

 需要给出年份的标签是作者年制的标签，可以使用命令`\yearpagescite{bibtexkey}`给出包含年份和页码信息的标签，
 使用命令`\yearcite{bibtexkey}`给出仅包含年份的标签。


* <b>中文文档中，引用标注标签在一个句子中时，标签的`]`后面与中文字符之间存在一个空格，怎么消除？</b>
	

在引用命令后面加一个没有长度的空白即可，比如：
```
中文字符\cite{sally_history_1985}\mbox{}中文字符

中文字符\cite{sally_history_1985}\hbox{}中文字符

中文字符\cite{sally_history_1985}\makebox{}中文字符

中文字符\cite{sally_history_1985}\hspace{0pt}中文字符
```


* <b>在使用作者年制时，我希望文献表是按作者年份标题排序，而正文某处一个cite命令引用多个参考文献，且这些文献的标签是按年份作者标题排序，该怎么操作？</b>

 有两种方法:

（1） 一是自动排序

 宏包加载时使用:

```\usepackage[backend=biber,style=gb7714-2015ay,sortcites,sorting=ynt]{biblatex}```

 正文中引用:

```\cite{refa2010,refb2008,refc2009}```

 然后在文献打印前加

```\newrefcontext[sorting=gb7714-2015]```

（2） 二是手动给出排序

 宏包加载时使用

```\usepackage[backend=biber,style=gb7714-2015ay,sortcites=false]{biblatex}```

 引用多个文献时按照年份顺序给出引用关键字，即正文中引用:

```\cite{refb2008,refc2009,refa2010}```

 参考:[issue:citation的顺序和bibliography的顺序如何不关联](https://github.com/hushidong/biblatex-gb7714-2015/issues/30)



* <b>在使用作者年制时，我希望文献表同一位置引用同一作者的不同的文献实现作者姓名的压缩，该怎么操作？</b>

可以通过将gb7714-2015ay.cbx 中的引用的基础样式authoryear更换成authoryear-comp。


​		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量超过国标规定的1个时，该怎么处理？</b>
	

可通过设置选项maxcitenames，mincitenames实现，比如下面的设置用于显示5个作者:

```\usepackage[backend=biber,style=gb7714-2015ay,maxcitenames=5,mincitenames=5]{biblatex}```
		
		
		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量只能是1个，而不管是否存在歧义时，该怎么处理？</b>
	

可通过设置选项uniquelist=false实现，该设置标签中的作者只会是指定的1个:

```\usepackage[backend=biber,style=gb7714-2015ay,uniquelist=false]{biblatex}```


* <b>请问希望正文中作者年制的标注(引用)标签希望作者给出3个，而且最后一个作者的前面用和及&符号链接，该怎么处理？</b>
	

首先设置标注标签中的作者的最大数量为3个:

```\usepackage[backend=biber,style=gb7714-2015ay,maxcitenames=3]{biblatex}```

然后修改标注中的本地化字符串：

```
\DefineBibliographyStrings{english}{
        andincitecn = {\str@andcn},%将标注中的分开，便于与文献表中的区分
        andincite   = {\&}}
```

最后重新定义finalandcomma标点，注意这里与语言相关的标点，需要用DefineBibliographyExtras命令定义。

```
\DefineBibliographyExtras{english}{\def\finalandcomma{}}%
```


​		
​		
* <b>请问希望正文中作者年制的标注(引用)标签中作者数量只能是1个，且只用其作者的姓而不管是否存在歧义时，该怎么处理？</b>
	

可通过设置选项uniquelist=false, uniquename=false实现，该设置标签中的作者只会是指定的1个且只用该作者的姓:

```\usepackage[backend=biber,style=gb7714-2015ay,uniquelist=false,uniquename=false]{biblatex}```




* <b>请问上标的标注(引用)标签过长导致行溢出，该怎么处理？</b>
	

上标的标注与行内的标注不一样，因此采用了上标的处理，所以上标的标注无法自动断行，因此在页边附近的长标注很有可能会溢出。由于上标标注的断行国标中并没有什么明确要求和说明，因此只能按照自己的方式进行处理，通常是将一个长标注手动分成两个短的标注，比如将:

```\cite{key1,key2,key3,key4,key5,key6,key7}```

变换成:

```\cite{key1,key2,key3}\linebreak\cite{key4,key5,key6,key7}```

如果两个cite之间还需要增加一个上标的逗号，那么可以手动处理比如增加`\textsuperscript{,}`



* <b>在顺序编码制标签中，希望数字编码从两个连续编码就开始压缩，比如[1,2]压缩成[1-2]，该怎么处理？</b>
	

biblatex中处理顺序数字编码压缩的代码默认从3个连续编码开始压缩，比如[1,2,3]压缩成[1-3]。如果要修改为从2个连续编码开始压缩，只需要做一个很简单的修改即可:

```
%该宏的目的是抛弃压缩内部的编号，而仅输出最后一个编号，主要通过cbx@tempcnta来控制
%一般情况下cbx@tempcnta为0，所以该宏不输出任何内容。当cbx@tempcnta在cite:comp:comp宏中更改变大后
%说明开始进入需要压缩的范围，当到压缩终点时，cbx@tempcnta必然大于1，则输出内容。
%修改第二行的数字1为0即可将默认的3个开始压缩变为2个开始压缩。
\renewbibmacro*{cite:dump}{
  \ifnumgreater{\value{cbx@tempcnta}}{0}
    {\ifnumgreater{\value{cbx@tempcnta}}{1}%1改为0，可以将压缩起始3个编号改为2个编号
       {\bibrangedash}
       {\multicitedelim}%
     \bibhyperref[\cbx@lastkey]{%
       \ifdef\cbx@lastprefix
         {\printtext[labelprefix]{\cbx@lastprefix}}
         {}%
       \printtext[labelnumber]{\cbx@lastnumber}}}
    {}%
  \setcounter{cbx@tempcnta}{0}%
  \global\undef\cbx@lastprefix}
```

反之，从两个开始压缩改成3个连续压缩，方法是类似的，就是将中的0改回1。


* <b>在顺序编码制标签中，希望修改编码压缩之间的符号，比如[1-2]变为[1~2]，该怎么处理？</b>

使用最新版本的biblatex (v3.15以后)可以直接定义如下标点：
```
\renewcommand{\multiciterangedelim}{$\sim$}
```

对于老版本可以修改宏，注意其中的注释
```
\renewbibmacro*{cite:dump}{
  \ifnumgreater{\value{cbx@tempcnta}}{0}
    {\ifnumgreater{\value{cbx@tempcnta}}{1}%1改为0，可以将压缩起始3个编号改为2个编号
       {$\sim$}%压缩的链接标点修改\bibrangedash
       {\multicitedelim}%
     \bibhyperref[\cbx@lastkey]{%
       \ifdef\cbx@lastprefix
         {\printtext[labelprefix]{\cbx@lastprefix}}
         {}%
       \printtext[labelnumber]{\cbx@lastnumber}}}
    {}%
  \setcounter{cbx@tempcnta}{0}%
  \global\undef\cbx@lastprefix}
```



* <b>在正文中的某一部分，希望取消顺序编码标签中的压缩，而其他部分保持这种压缩，该怎么处理？</b>
	

顺序数字编码压缩的代码，主要有cite:comp:comp宏控制，因此需要局部取消压缩，可以局部的修改该宏。修改很简单，只需要注释掉其中的一行，在需要取消压缩的环境中，重定义该宏，比如:

```
\renewbibmacro*{cite:comp:comp}{%
  \ifboolexpr{
    ( test {\iffieldundef{labelprefix}} and test {\ifundef\cbx@lastprefix} )
    or
    test {\iffieldequals{labelprefix}{\cbx@lastprefix}}
  }
    {\ifnumequal{\thefield{labelnumber}}{\value{cbx@tempcntb}}
       {\savefield{entrykey}{\cbx@lastkey}%
        \savefield{labelnumber}{\cbx@lastnumber}%
        \addtocounter{cbx@tempcnta}{1}}
       {\ifnumequal{\thefield{labelnumber}}{\value{cbx@tempcntb}-1}
          {}
          {\usebibmacro{cite:dump}%
           \ifnumgreater{\value{cbx@tempcntb}}{-1}
             {\multicitedelim}
             {}%
           \printtext[bibhyperref]{%
             \printfield{labelprefix}%
             \printfield{labelnumber}}}}}
    {\usebibmacro{cite:comp:end}}%
  %\setcounter{cbx@tempcntb}{\thefield{labelnumber}}%%注释该行，以取消压缩
  \savefield{labelprefix}{\cbx@lastprefix}}
```


​	
### 5. Examples/著录和标注结果示例

+ 标注样式示例

	* 顺序编码制

	![示例a](example/fig-style-numeric.png)
	
	代码见：![egcitetab.tex](egfigure/egcitetab.tex)，![egcitenumtp.tex](egfigure/egcitenumtp.tex)
		
	* 作者年制

	![示例b](example/fig-style-authoryear.png)
	
	代码见：![egciteaytab.tex](egfigure/egciteaytab.tex)，![egciteaytp.tex](egfigure/egciteaytp.tex)
	，![egciteay.tex](egfigure/egciteay.tex)

	具体代码见：egfigure 文件夹下的各个文件。
	
	命令说明见：biblatex-gb7714-2015.pdf文档。

+ 著录样式示例

	国标文档的完整复现：
	
	* 顺序编码制
	
	代码见：![tgbcitation.tex](egfigure/tgbcitation.tex)
	
	* 作者年制
	
	代码见：![tngbcitationay.tex](egfigure/tngbcitationay.tex)
	
	* 国标附录
	
	代码见：![tgbbiblio.tex](egfigure/tgbbiblio.tex)
	
+ 姓名的格式更改示例

代码见：![opt-gbnamefmt.tex](example/opt-gbnamefmt.tex) ，![opt-gbnamefmt-default.tex](example/opt-gbnamefmt-default.tex) 

对于bib文件中的如下条目，有:

```
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
```
![示例c](example/fig-nameformat.png)



### 6. 测试文件说明

+ egfigure
	- ![egciteay.tex](egfigure/egciteay.tex)	 		测试gb7714-2015ay的标注样式，是否满足GB要求
	- ![egciteaytab.tex](egfigure/egciteaytab.tex)		测试gb7714-2015ay的标注样式，绘制成表用于biblatex-gb7714-2015.pdf
	- ![egciteaytp.tex](egfigure/egciteaytp.tex)		测试gb7714-2015ay使用natbib的常用标注命令
	- ![egcitenum.tex](egfigure/egcitenum.tex)			测试gb7714-2015的标注样式，是否满足GB要求
	- ![egcitenumtp.tex](egfigure/egcitenumtp.tex)		测试gb7714-2015使用natbib的常用标注命令
	- ![egcitetab.tex](egfigure/egcitetab.tex)			测试gb7714-2015的标注样式，绘制成表用于biblatex-gb7714-2015.pdf
	- ![egcitesay.tex](egfigure/egcitesay.tex)			测试gb7714-2015ay使用复数形式的命令
	- ![egcitesnum.tex](egfigure/egcitesnum.tex)		测试gb7714-2015使用复数形式的命令
	- ![egcontentfmt.tex](egfigure/egcontentfmt.tex)		测试gb7714-2015样式选项gbnamefmt=givenahead,gbbiblabel=dot,gbtitlelink=true
	- ![egcontentfmtb.tex](egfigure/egcontentfmtb.tex)		测试gb7714-2015ms样式选项gbnamefmt=lowercase,gbstyle=false,sorting=nyt
	- ![egcontentfmtc.tex](egfigure/egcontentfmtc.tex)		测试gb7714-2015ay样式选项maxcitenames=2,mincitenames=1,sorting=gbynta（UCAS-资环类）
	- ![egdoublelan.tex](egfigure/egdoublelan.tex)		测试gb7714-2015样式实现的双语对照文献表，关联条目方法
	- ![egdoublelanb.tex](egfigure/egdoublelanb.tex)		测试gb7714-2015样式实现的双语对照文献表，关联条目方法，（gbnamefmt=pinyin 国内某期刊）
	- ![eggbfootstyle.tex](egfigure/eggbfootstyle.tex)		测试gb7714-2015样式实现国标要求的脚注文献表
	- ![egfootstyle.tex](egfigure/egfootstyle.tex)		测试gb7714-2015样式一般的脚注文献表
	- ![egmsinabiblio.tex](egfigure/egmsinabiblio.tex)		测试gb7714-2015ms样式在一篇文档中使用两种格式设置，中文：GB，英文：biblatex标准样式
	- ![egmxindfrefsec.tex](egfigure/egmxindfrefsec.tex)	测试gb7714-2015mx样式在不同的参考文献分节中使用顺序编码和作者年制两种不同样式
	- ![egmultilan.tex](egfigure/egmultilan.tex)		测试gb7714-2015样式实现的多语言混合的文献表
	- ![egmwe.tex](egfigure/egmwe.tex)				测试gb7714-2015样式最小示例，用于biblatex-gb7714-2015.PDF
	- ![egparfmt.tex](egfigure/egparfmt.tex)			测试gb7714-2015样式文献表段落格式设置，包括缩进，颜色，字体，间距等
	- ![tgbbiblio.tex](egfigure/tgbbiblio.tex)			实现GB/T 7714-2015 标准的附录的文献表示例（gb7714-2015样式）
	- ![tgbbiblioms.tex](egfigure/tgbbiblioms.tex)		实现GB/T 7714-2015 标准的附录的文献表示例（gb7714-2015ms样式）
	- ![tgbcitation.tex](egfigure/tgbcitation.tex)		实现GB/T 7714-2015 标准2-10节给出的顺序编码制示例（gb7714-2015样式）
	- ![tgbcitationms.tex](egfigure/tgbcitationms.tex)		实现GB/T 7714-2015 标准2-10节给出的顺序编码制示例（gb7714-2015ms样式）
	- ![tngbcitationay.tex](egfigure/tngbcitationay.tex)	实现GB/T 7714-2015 标准2-10节给出的著者年份制示例（gb7714-2015ay样式）
	- ![tngbcitationaynew.tex](egfigure/tngbcitationaynew.tex)	实现GB/T 7714-2015 标准2-10节给出的著者年份制示例（gb7714-2015ay样式，nohashothers=true）
+ egphoto
	- ![opt-citexref-false.tex](egphoto/opt-citexref-false.tex)	测试citexref=false选项
	- ![opt-citexref-true.tex](egphoto/opt-citexref-true.tex)		测试citexref=true选项
	- ![opt-gbalign-center.tex](egphoto/opt-gbalign-center.tex)	测试gbalign=center选项
	- ![opt-gbalign-gb.tex](egphoto/opt-gbalign-gb.tex)		测试gbalign=gb7714-2015选项
	- ![opt-gbalign-left.tex](egphoto/opt-gbalign-left.tex)		测试gbalign=left选项
	- ![opt-gbalign-right.tex](egphoto/opt-gbalign-right.tex)		测试gbalign=right选项
	- ![opt-gbannote-false.tex](egphoto/opt-gbannote-false.tex)	测试gbannote=false选项
	- ![opt-gbannote-true.tex](egphoto/opt-gbannote-true.tex)		测试gbannote=true选项
	- ![opt-gbannote-true.tex](egphoto/opt-gbannote-true.tex)		测试gbannote=true选项
	- ![opt-gbbiblabela.tex](egphoto/opt-gbbiblabela.tex)		测试gbbiblabel=box选项
	- ![opt-gbbiblabelb.tex](egphoto/opt-gbbiblabelb.tex)		测试gbbiblabel=bracket选项
	- ![opt-gbbiblabelc.tex](egphoto/opt-gbbiblabelc.tex)		测试gbbiblabel=parens选项
	- ![opt-gbbiblabeld.tex](egphoto/opt-gbbiblabeld.tex)		测试gbbiblabel=dot选项
	- ![opt-gbbiblabele.tex](egphoto/opt-gbbiblabele.tex)		测试gbbiblabel=plain选项
	- ![opt-gbbiblabelf.tex](egphoto/opt-gbbiblabelf.tex)		测试gbbiblabel=circle选项
	- ![opt-gbnoauthor-false.tex](egphoto/opt-gbnoauthor-false.tex)	测试gbnoauthor=false选项
	- ![opt-gbnoauthor-true.tex](egphoto/opt-gbnoauthor-true.tex)	测试gbnoauthor=true选项
	- ![opt-gbpub-false.tex](egphoto/opt-gbpub-false.tex)		测试gbpub=false选项
	- ![opt-gbpub-true.tex](egphoto/opt-gbpub-true.tex)		测试gbpub=true选项
	- ![opt-gbpunctin-false.tex](egphoto/opt-gbpunctin-false.tex)	测试gbpunctin=false选项
	- ![opt-gbpunctin-true.tex](egphoto/opt-gbpunctin-true.tex)	测试gbpunctin=true选项
	- ![opt-gbtitlelink-false.tex](egphoto/opt-gbtitlelink-false.tex)	测试gbtitlelink=false选项
	- ![opt-gbtitlelink-true.tex](egphoto/opt-gbtitlelink-true.tex)	测试gbtitlelink=true选项
	- ![opt-gbtype-false.tex](egphoto/opt-gbtype-false.tex)		测试gbtype=false选项
	- ![opt-gbtype-true.tex](egphoto/opt-gbtype-true.tex)		测试gbtype=true选项
	- ![opt-mergedate-a.tex](egphoto/opt-mergedate-a.tex)		测试mergedate默认选项（gb7714-2015ay）
	- ![opt-mergedate-b.tex](egphoto/opt-mergedate-b.tex)		测试mergedate=true选项（gb7714-2015ay）
	- ![opt-mergedate-c.tex](egphoto/opt-mergedate-c.tex)		测试mergedate=false选项（gb7714-2015ay）
	- ![opt-mergedate-d.tex](egphoto/opt-mergedate-d.tex)		测试mergedate=none选项（gb7714-2015ay）
+ egthesis	
	- ![thesis-bupt-numeric.tex](egthesis/thesis-bupt-numeric.tex)	
	- ![thesis-cau-numeric.tex](egthesis/thesis-cau-numeric.tex)	
	- ![thesis-ecnu-numeric.tex](egthesis/thesis-ecnu-numeric.tex)	
	- ![thesis-fdu-numeric.tex](egthesis/thesis-fdu-numeric.tex)	
	- ![thesis-nwafu-ay.tex](egthesis/thesis-nwafu-ay.tex)			测试西北农林科技大学（可以参考：特殊的ay样式调整）
	- ![thesis-seu-numeric.tex](egthesis/thesis-seu-numeric.tex)		测试东南大学（可以参考：gb7714-2015样式调整）
	- ![thesis-sjtu-numeric.tex](egthesis/thesis-sjtu-numeric.tex)	
	- ![thesis-thu-author-year.tex](egthesis/thesis-thu-author-year.tex)	
	- ![thesis-thu-numeric.tex](egthesis/thesis-thu-numeric.tex)	
	- ![thesis-tongji.tex](egthesis/thesis-tongji.tex)	
	- ![thesis-ucas-m.tex](egthesis/thesis-ucas-m.tex)				测试中科院大学（可以参考：ay样式调整）
	- ![thesis-ucas-x.tex](egthesis/thesis-ucas-x.tex)	
	- ![thesis-uibe-numeric.tex](egthesis/thesis-uibe-numeric.tex)		测试对外经贸大学（可以参考：中文标点、卷期格式；中英文不同）
	- ![thesis-ustc-all.tex](egthesis/thesis-ustc-all.tex)			测试中科大（可以参考：一文中使用两种样式）
	- ![thesis-ustc-authoryear.tex](egthesis/thesis-ustc-authoryear.tex)	
	- ![thesis-ustc-numeric.tex](egthesis/thesis-ustc-numeric.tex)	
	- ![thesis-xjtu-numeric.tex](egthesis/thesis-xjtu-numeric.tex)	
	- ![thesis-zju-numeric.tex](egthesis/thesis-zju-numeric.tex)	
	- ![thesistest.tex](egthesis/thesistest.tex)	
+ example
	- ![cls-beamer.tex](example/cls-beamer.tex)			测试beamer中的使用（gb7714-2015样式）
	- ![cls-beameray.tex](example/cls-beameray.tex)			测试beamer中的使用（gb7714-2015ay样式）
	- ![codeopt-gbcodegbk.tex](example/codeopt-gbcodegbk.tex)	测试gb7714-2015、ay样式，对于GBK编码文档的兼容性
	- ![teststyleerj.tex](example/teststyleerj.tex)			测试chinese-erj样式
	- ![teststylecss.tex](example/teststylecss.tex)			测试chinese-css样式
	- ![teststylecss.tex](example/teststylecssorg.tex)			测试chinese-css样式
	- ![teststylecss.tex](example/teststylejmw.tex)			测试chinese-jmw样式
	- ![eg-opt-gbstyle.tex](example/eg-opt-gbstyle.tex)		测试gb7714-2015ms样式一篇文档中中英文两种格式设置，多语言对照，多语言混合文献表
	- ![testallformat.tex](example/testallformat.tex)			测试全面的类型、格式
	- ![egtest.tex](example/egtest.tex)				测试示例
	- ![opt-autolang-multilan.tex](example/opt-autolang-multilan.tex)	测试多语言混合的文献表，各语言不同的本地化字符串
	- ![opt-eg-multilan.tex](example/opt-eg-multilan.tex)		测试多语言混合的文献表
	- ![opt-eg-authoryear.tex](example/opt-eg-authoryear.tex)		测试ay样式
	- ![opt-eg-dblang.tex](example/opt-eg-dblang.tex)			测试双语对照文献-两种方法（条目集、关联条目）
	- ![opt-gbalign-center.tex](example/opt-gbalign-center.tex)	测试gbalign选项
	- ![opt-gbalign-gb.tex](example/opt-gbalign-gb.tex)		测试gbalign选项
	- ![opt-gbalign-left.tex](example/opt-gbalign-left.tex)		测试gbalign选项
	- ![opt-gbannote.tex](example/opt-gbannote.tex)			测试gbannote选项，在文献表中加上附加信息用以说明三大索引情况
	- ![opt-gbbiblabel.tex](example/opt-gbbiblabel.tex)		测试gbbiblabel选项
	- ![opt-gbctexset.tex](example/opt-gbctexset.tex)			测试gbctexset选项，使可以利用ctex的设置对文献表的标题进行修改
	- ![opt-gbfieldstd.tex](example/opt-gbfieldstd.tex)		测试gbfiledstd选项，著录格式还原为biblatex标准样式的格式
	- ![opt-gbfootbib.tex](example/opt-gbfootbib.tex)			测试实现国标要求的脚注文献表
	- ![opt-gblanorder-chineseahead.tex](example/opt-gblanorder-chineseahead.tex)	测试文献表排序，中文在前
	- ![opt-gblanorder-englishahead.tex](example/opt-gblanorder-englishahead.tex)	测试文献表排序，英文在前
	- ![opt-gblanorder-udforder.tex](example/opt-gblanorder-udforder.tex)		测试文献表排序，自定义顺序
	- ![opt-sorting-multilan.tex](example/opt-sorting-multilan.tex)			测试多语言混合文献表排序
	- ![opt-gblocal.tex](example/opt-gblocal.tex)				测试本地化字符串设置（引用标注标签、文献表）
	- ![test-setlocal.tex](example/test-setlocal.tex)				测试本地化字符串设置（多种方法局部调整）
	- ![test-setlocal-multilan.tex](example/test-setlocal-multilan.tex)	测试本地化字符串设置（多种语言的局部调整）
	- ![test-resume.tex](example/test-resume.tex)	测试研究成果、学术成果(文献表)的局部化格式调整
	- ![opt-gbnamefmt.tex](example/opt-gbnamefmt.tex)			测试gbnamefmt对于作者姓名格式的控制
	- ![opt-gbnamefmt-default.tex](example/opt-gbnamefmt-default.tex)	测试gbnamefmt对于作者姓名格式的控制
	- ![opt-gbnamefmt-quanpin.tex](example/opt-gbnamefmt-quanpin.tex)	测试gbnamefmt对于作者姓名格式的控制
	- ![test-addfieldnameformat.tex](example/test-addfieldnameformat.tex) 测试给指定的文献设定nameformat域
	- ![opt-gbnoauthor-false.tex](example/opt-gbnoauthor-false.tex)		测试gbnoauthor选项
	- ![opt-gbnoauthor-true.tex](example/opt-gbnoauthor-true.tex)		测试gbnoauthor选项
	- ![opt-gbpub-true.tex](example/opt-gbpub-true.tex)		测试gbpub选项
	- ![opt-gbpunctin.tex](example/opt-gbpunctin.tex)			测试gbpunctin选项
	- ![opt-gbtitlelink.tex](example/opt-gbtitlelink.tex)		测试gbtitlelink选项
	- ![opt-gbtype.tex](example/opt-gbtype.tex)			测试gbtype选项
	- ![opt-hyperref-backref.tex](example/opt-hyperref-backref.tex)	测试backrref选项，反向超链接
	- ![test-translator-in-other-lan.tex](example/test-translator-in-other-lan.tex)	测试译著的其它语言的译者格式
	- ![test-space-after-citelabel-inCJKline.tex](example/test-space-after-citelabel-inCJKline.tex)		测试删除标注后因为xeCJK加入的空格
	- ![test-special-chars-in-fields.tex](example/test-special-chars-in-fields.tex) 测试不同域中存在的特殊字符处理
	- ![test-gbt-7714-1987.tex](example/test-gbt-7714-1987.tex) 测试GB/T7714-1987标准的样式
	- ![test-gbt-7714-2005.tex](example/test-gbt-7714-2005.tex) 测试GB/T7714-2005标准的样式
	测试标注中本地化字符串、标点的中英文切换
	- ![test-punct-quanjiao.tex](example/test-punct-quanjiao.tex) 测试标点中英文切换
	
	

---------------------------------------------------------


## Usage
* for numerical sequence style: gb7714-2015

    `\usepackage[backend=biber,style=gb7714-2015]{biblatex}`

    - add an option `gbalign` to control the align style of the numerical label：
	
		`gbalign=right`  for the label ragged left in a list environment, this is the default setting.
		
		`gbalign=center` for the same width label in a list environment with the number centered in a wrapper like bracket []
		
		`gbalign=left`   for the label ragged right in list environment
		
		`gbalign=gb7714-2015` for the label in paragraph with same separation space between label and content of the reference entry 

        `\usepackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015]{biblatex}`

    - add an option `gbpub` for dealing publishing items (This option is also for author-year style):
	
		`gbpub = true` for gb7714 style, to print `[出版者不详]` and the like when publisher or address is absent, this is the default setting.
		
		`gbpub = false` for standard style, not to print the additional infomation. 
		
        `\usepackage[backend=biber,style=gb7714-2015,gbpub=true]{biblatex}`
      
    - add an option `gbnamefmt` for dealing author name's letter case (This option is also for author-year style):

        `gbnamefmt = uppercase` for gb7714 style, to capitalize all the letters of the name, like: ZHANG M L, this is the default setting.
		
        `gbnamefmt = lowercase` for gb7714 style, do no case switch of the name, like: Zhang M L
		
        `gbnamefmt = givenahead` for standard style, given-family style, like: M. L. Zhang  as the ieee style
		
		`gbnamefmt = familyahead` for standard style, family-given style, like: Zhang, M. L. as the apa style. 
		
        `gbnamefmt = pinyin` for a common Chinese style, like: ZHANG Min-li, YI Shi-he and so on. 
		
		`gbnamefmt = reserveorder` for standard style:family-given/given-family style
		
		the name format can be set per-entry using a field `nameformat`, add this field like `nameformat={pinyin}` to an entry in the bib file to set the entry's name format.

        `\usepackage[backend=biber,style=gb7714-2015,gbnamefmt=uppercase]{biblatex}`
		
	- add an option `gbbiblabel` to control the format of the numerical label：
	
		`gbbiblabel=bracket`  for the numerical number in the label wrapped by bracket, like: [1], this is the default setting.
		
		`gbbiblabel=parens`   for the numerical number in the label wrapped by parenthesis, like: (1)
		
		`gbbiblabel=plain`    for the numerical number in the label wrapped by nothing, like: 1
		
		`gbbiblabel=dot`      for the numerical number in the label followed with dot, like: 1.
		
		`gbbiblabel=box`      for the numerical number in the label wrapped by box which generated by `\framebox`
		
		`gbbiblabel=circle`   for the numerical number in the label wrapped by circle which generated by `\textcircled`

        `\usepackage[backend=biber,style=gb7714-2015,gbbiblabel=bracket]{biblatex}`
		
	- add an option `gbtype` to control the output of the reference type and carrier identifier like [J/OL] (This option is also for author year style): 
	
		`gbtype = true` for gb7714 style, print a title with the identifier, like: `an on-line article [J/OL]`, this is the default setting.
		
		`gbtype = false` for none identifier, print a title without identifier, like: `an on-line article`

        `\usepackage[backend=biber,style=gb7714-2015,gbtype=true]{biblatex}`
		
	- add an option `gbfieldtype` to control the output of field type:
	
		`gbfieldtype = true` to print type field, like the thesis type: `PHD thesis` or `博士学位论文`。please use `\DefineBibliographyStrings{english}{mathesis={str you want}}`,`\DefineBibliographyStrings{english}{phdthesis={str you want}}`,
		`\DefineBibliographyStrings{english}{mathesiscn={str you want}}`,`\DefineBibliographyStrings{english}{phdthesiscn={str you want}}` to 
		define the output string, or set it in bibfile like: `type={str you want},`
		
		`gbfieldtype = false` not to print type field.

        `\usepackage[backend=biber,style=gb7714-2015,gbfieldtype=true]{biblatex}`
		
	- add an option `gbpunctin` to control the output of `//` before bookauthor for entrytypes like inbook/incollection/inproceedings(This option is also for author year style):
	
	`gbpunctin=true` for gb7714 style, to output `//`, this is the default setting
		
		`gbpunctin=false` for standard style, to output a bibstring, for English it is `IN:`, If you want to eliminate it at all, please redefine the bibstring like `\DefineBibliographyStrings{english}{in={}}` and `\DefineBibliographyStrings{english}{incn={}}`in the preamble.
	
    `\usepackage[backend=biber,style=gb7714-2015,gbpunctin=true]{biblatex}`
    	
	- add an option `gbctexset` to control the bibliography heading's setting method (This option is also for author year style):
	
		`gbctexset=true` , the bibliography heading can be set by `\bibname` or `\refname`, this is the default setting.
	
		`gbpunctin=false`, the heading can be set by bibstring like `\DefineBibliographyStrings{english}{bibliography={title you want}}` or `\DefineBibliographyStrings{english}{references={title you want}}` 
	
		or alternatively, it can also be set through the printbibliography option `title`, like `printbibliography[title=title you want]`. 
	
    `\usepackage[backend=biber,style=gb7714-2015,gbctexset=true]{biblatex}`
    	
	- add an option `gbcodegbk` to deal the tex source file encoded with GBK (This option is also for author year style): 
	
		`gbcodegbk=true` , if you want to compile the GBK encoded source file with pdflatex or latex
		
		`gbcodegbk=false`, if you want to compile the utf-8 endcoded source file with xelatex, this is the default setting.
	
    `\usepackage[backend=biber,style=gb7714-2015,gbcodegbk=true]{biblatex}`
    	
	- add an option `gbtitlelink` to control the hyperlink of title field (This option is also for author year style):
	
		`gbtitlelink = false` not to add hyperlink, this is the default setting.
		
		`gbtitlelink = true` to set the title as a hyperlink.
	
	    `\usepackage[backend=biber,style=gb7714-2015,gbtitlelink=true]{biblatex}`
    	
	- add an option `gbfootbib` to control the bibliography in footnote (This option is also for author year style):
	
		`gbfootbib = true` make patches to match the standard, this is the default setting.
		
		`gbfootbib = false` not to patch.
	
	    `\usepackage[backend=biber,style=gb7714-2015,gbtitlelink=true]{biblatex}`
    	
	- add options `gbcitelocal` `gbbiblocal` to control the local strings in citation and bibliography respectively, the `gblocal` set the both options (These options are also for author year style):
	
		`gbcitelocal = gb7714-2015` to output local strings according to the reference's language, this is the default setting.
		
		`gbcitelocal = chinese` to output local strings with chinese language word like "等".
		
		`gbcitelocal = english` to output local strings with western language word like "et al.".
	
	    `\usepackage[backend=biber,style=gb7714-2015,gbcitelocal = chinese]{biblatex}`
    	
	- add an option `gbstrict` to control the output of some unnecessary fields for GB/T7714-2015 (This option is also for author year style). 
	
		`gbstrict=true`,  not to print those fields such as language, eprint, this is the default setting.
	
		`gbstrict=false`, to output them as the standard style
	
	    `\usepackage[backend=biber,style=gb7714-2015,gbstrict=true]{biblatex}`
    	
	- add an option `gbfieldstd` to control the format of some fields such as title, url and pages (This option is also for author year style): 
	
		`gbfieldstd = false` for gb7714 style, format of the fields follows the GB/T7714-2015 standard, this is the default setting.
		
		`gbfieldstd = true` for standard style. 
	
	    `\usepackage[backend=biber,style=gb7714-2015,gbfieldstd=true]{biblatex}`
    	
	
* for multi-style: gb7714-2015ms

  In order to use two styles in a tex file, add a style gb7714-2015ms. option `gbstyle` is added to control the using mode. `gbstyle=true` means all references are printed with GB/T7714-2015 style, and `gbstyle=false` means the chinese references are printed with GB/T7714-2015 style while the other references are printed with standard style shipped by biblatex, and `gbstyle=true` is the default set. all the options for numerical sequence style gb7714-2015 can also be used in gb7714-2015ms. 
  	

  	`\usepackage[backend=biber,style=gb7714-2015ms,gbstyle=false]{biblatex}`

* for author year style: gb7714-2015ay

    `\usepackage[backend=biber,style=gb7714-2015ay,gbpub=true]{biblatex}`

    - add an option `gbnoauthor` for dealing undefined author:
	
		`gbnoauthor = true` for gb7714 style, to print `佚名` or `Anon` when the author of the entry is absent.
		
		`gbnoauthor = false` for standard style, not to pring anything, this is the default setting.

        `\usepackage[backend=biber,style=gb7714-2015ay,gbnoauthor=true]{biblatex}`
	
	- add an option value `mergedate=none` to control the date in bibliography:
	
		`mergedate=true` to output date only after author，like：LAMPORT L, (1986). Document Preparation System[M]. [S.l.]: Addison-Wesley Reading, MA.
		
		`mergedate=false` to output date after author and in publish items，like：LAMPORT L, (1986). Document Preparation System[M]. [S.l.]: Addison-Wesley Reading, MA, 1986.
		
		`mergedate=none` to output date only in publish items，like：LAMPORT L. Document Preparation System[M]. [S.l.]: Addison-Wesley Reading, MA, 1986.
		
		do not set mergedate output like：LAMPORT L, 1986. Document Preparation System[M]. [S.l.]: Addison-Wesley Reading, MA.
		
		`\usepackage[backend=biber,style=gb7714-2015ay,mergedate=none]{biblatex}`
		
	- add an option `gblanorder` to control sequence of reference groups of different languagesin the bibliography:
		
		`gblanorder=chineseahead` to set the sequence as: cn;jp;kr;en;fr;ru
		
		`gblanorder=englishahead` to set the sequence as: en;fr;ru;cn;jp;kr
		
		`gblanorder=user defined string like: cn;en;jp;kr;fr;ru` to set the sequence as: cn;en;jp;kr;fr;ru. 
		
		`\usepackage[backend=biber,style=gb7714-2015ay,gblanorder=cn;en;jp;fr;kr;ru]{biblatex}`
	
* for perl script transformation tool(only for the numerical style)

    `perl gb7714texttobib.pl in=textfilename out=bibfilename`

A demonstration database is provided to show how to format input for the style. The biblatex-gb7714-2015 style works with texlive2014, texlive2015, texlive2016, texlive2017 , texlive2018 and so on.

please see the file 'biblatex-gb7714-2015.pdf' for further information!


## Version history:

* 2016/05/20 v1.0  
* 2016/10/23 v1.0a 
* 2016/11/11 v1.0b
* 2016/11/14 v1.0c 
* 2016/11/24 v1.0d 
* 2016/12/07 v1.0e
* 2017/02/26 v1.0g 
* 2017/04/11 v1.0h 
* 2017/11/21 v1.0i
* 2018/01/20 v1.0j 
* 2018/04/03 v1.0k
* 2018/06/01 v1.0l
* 2018/08/14 v1.0m,CTAN
* 2018/11/04 v1.0n
* 2018/12/22 v1.0o
* 2019/01/19 v1.0p
* 2019/02/11 v1.0q
* 2019/03/28 v1.0r
* 2019/03/29 v1.0rm,rename erj to chinese-erj,ctan
* 2019/08/28 v1.0s
* 2020/03/04 v1.0t,ctan
* 2020/03/30 v1.0u
* 2020/07/21 v1.0v,ctan
* 2021/01/19 v1.0w,ctan
* 2021/04/03 v1.0x,ctan
* 2021/05/06 v1.0y,ctan
* 2021/08/19 v1.0z,ctan
* 2021/09/11 v1.1a,ctan
* 2021/12/11 v1.1b,ctan
* 2022/01/24 v1.1c,ctan
* 2022/02/22 v1.1d,ctan,github
* 2022/03/07 v1.1e,ctan,github
* 2022/03/13 v1.1f,ctan,github
* 2022/04/03 v1.1g,ctan,github
* 2022/04/16 v1.1h,ctan,github
* 2022/05/17 v1.1i,ctan,github
* 2022/08/29 v1.1j,ctan,github
* 2022/11/07 v1.1k,ctan,github
* 2023/03/31 v1.1l,ctan,github
* 2023/04/24 v1.1m,ctan,github
* 2023/05/24 v1.1n,ctan,github
* 2023/09/10 v1.1o,ctan,github


---------------------------------------------------------
## Update history:

[update: tex](example/updatehistory.tex)

[update: tex](example/updatehistoryold.tex)



