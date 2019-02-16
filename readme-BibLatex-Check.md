BibLatex-Check 

是Pezmc开发检查bib文件中参考文献条目和域是否符合biblatex设定的python脚本。
输入为bib文件，输出为bib文件正确与否的信息，会包括域的欠缺信息等，为一个html文件，该用firefox打开会比较快。

仓库见：https://github.com/Pezmc/BibLatex-Check

用法：

`./biblatex_check.py <-b input.bib> [-a input.aux] [-o output.html]`

注意：aux和html文件是可选的。

帮助命令：

`./biblatex_check.py -h` 

选项：

- -b (--bib=file.bib) Set the input Bib File
- -a (--aux=file.aux) Set the input Aux File
- -o (--output=file.html) Write results to the HTML Output File.
- -v (--view) Open in Browser. Use together with -o.
- -N (--no-console) Do not print problems to console. An exit code is always returned.



