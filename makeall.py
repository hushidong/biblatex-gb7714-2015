#!/usr/bin/env python3
#_∗_coding: utf-8 _∗_

import os
import shutil
import pathlib
import re
import subprocess


def compileall():
	print(os.linesep)#这些都是字符串
	print(os.sep)
	print(os.pathsep)
	print(os.curdir)
	print(os.pardir)
	print(os.getcwd())
	print(os.listdir(path='.'))

	
	pwd=os.getcwd()
	filesneedcopy=['gb7714-CCNU.bbx','gb7714-CCNU.cbx','gb7714-NWAFU.bbx','gb7714-NWAFU.cbx','gb7714-SEU.bbx','gb7714-SEU.cbx',
	'chinese-erj.bbx','chinese-erj.cbx','chinese-css.bbx','chinese-css.cbx',
	'chinese-jmw.bbx','chinese-jmw.cbx',
	'example.bib', 'gb7714-1987.bbx', 'gb7714-1987.cbx', 
	'gb7714-1987ay.bbx', 'gb7714-1987ay.cbx', 'gb7714-2005.bbx', 'gb7714-2005.cbx', 'gb7714-2005ay.bbx',
	'gb7714-2005ay.cbx', 'gb7714-2015-gbk.def', 'gb7714-2015.bbx', 'gb7714-2015.cbx', 'gb7714-2015ay.bbx',
	'gb7714-2015ay.cbx', 'gb7714-2015ms.bbx', 'gb7714-2015ms.cbx', 'gb7714-2015mx.bbx', 'gb7714-2015mx.cbx']


	filelatexext=[".aux", ".bbl", ".blg", ".log", ".out", ".toc", ".bcf", 
	".xml", ".synctex", ".nlo", ".nls", ".bak", ".ind", ".idx", 
	".ilg", ".lof", ".lot", ".ent-x", ".tmp", ".ltx", ".los", 
	".lol", ".loc", ".listing", ".gz", ".userbak", ".nav", ".snm", ".vrb",
	".fls", ".xdv", ".fdb_latexmk"]

	
	#复制相关文件
	dirlst=os.listdir()
	subdirlst=[]
	for elem in dirlst:
		#print('elem=',elem)
		if os.path.isdir(elem) and elem != ".git" and elem != "tool":
			subdir=pwd+os.sep+elem
			subdirlst.append(subdir)
			for file in filesneedcopy:
				shutil.copyfile(pwd+os.sep+file,subdir+os.sep+file)
				print(subdir+os.sep+file+' ... copied')
	

	#进入相关文件夹进行编译
	for dirname in ["example","egthesis","egphoto","egfigure","tool"]: #
		subdir=pwd+os.sep+dirname
		os.chdir(subdir)
		pwd=os.getcwd()
		print('pwd=',pwd)
		print(os.listdir())

		#利用pathlib以及通配符搜索来备份文件
		if dirname=="tool":
			pf1=pathlib.Path('.').glob("*.userbak")
			pf=[str(x) for x in pf1]
			print('pf=',pf)
			if pf:
				for file in pf:
					os.remove(pwd+os.sep+file)
			pf1=pathlib.Path('.').glob("gb*.pdf")
			pf=[str(x) for x in pf1]
			print('pf=',pf)
			if pf:
				for file in pf:
					shutil.copyfile(pwd+os.sep+file,pwd+os.sep+file+".userbak")
					os.remove(pwd+os.sep+file)

		#--------编译latex---------
		
		if dirname=="example":
			texlivestr=str(subprocess.check_output(["tex","--version"]))
			print(texlivestr)
			s=re.search(".*Copyright\s(\d*)\sD.E. Knuth.*",texlivestr)
			print(s)
			texlivever=int(s.group(1))
			print(texlivever)

		if dirname=="example" and texlivever>2020:
			fileuniset=["test*.tex","cls*.tex","opt*.tex","eg*.tex","tgb*.tex","thesis*.tex","gbt*.tex"]
		else:
			fileuniset=["test*.tex","cls*.tex","opt*.tex","code*.tex","eg*.tex","tgb*.tex","thesis*.tex","gbt*.tex"]

		for fileuni in fileuniset:
			pf1=pathlib.Path('.').glob(fileuni)
			pf=[str(x) for x in pf1]
			print('pf=',pf)
			if pf:
				for file in pf:
					print('---------compile new file:---------')
					print('file=',file)
					print('file=',os.path.splitext(file))
					jobname=os.path.splitext(file)[0]
					#删除辅助文件
					for fileext in filelatexext:
						fileaux=pwd+os.sep+jobname+fileext
						if os.path.exists(fileaux):
							os.remove(fileaux)
					#latex编译
					latexcmd="xelatex"
					if dirname =="example" and re.match("code",file):
						latexcmd="pdflatex"
					if dirname !="tool":
						subprocess.run([latexcmd,"-no-pdf",file])
						subprocess.run(["biber",jobname])
						subprocess.run([latexcmd,file])
					else:
						subprocess.run([latexcmd,file]) # 插入pdf的pdfpages宏包要使用目录，需要两次编译
						subprocess.run([latexcmd,file])

		#根据biber的版本区别编译文档
		if dirname=="egfigure":
			biberversion=str(subprocess.check_output(["biber", "--version"]))
			print(biberversion)
			vernumstr=biberversion.split(".")[1]
			s=re.search('(\d*).*',vernumstr)
			vernum=int(s.group(1))
			if vernum>=13:
				jobname="tngbcitationaynew"
			else:
				jobname="tngbcitationay"
			print('---------compile new file:---------')
			print('file=',jobname)
			subprocess.run(["xelatex", "-no-pdf",jobname])
			subprocess.run(["biber",jobname])
			subprocess.run(["xelatex",jobname])

		if dirname=="tool":
			try:
				import diff_pdf_visually
			except ImportError:
				print("there is no module: diff_pdf_visually")
			else:
				pf1=pathlib.Path('.').glob("gbT*.pdf")
				pf=[str(x) for x in pf1]
				print('pf=',pf)
				if pf:
					for file in pf:
						if file != "gbT7714-2015ms.pdf":
							print("------------compare pdf------")
							print("file:",file,"std"+file)
							diff_pdf_visually.pdfdiff(file,"std"+file)

		#--------编译latex结束---------
		os.chdir(os.pardir)
		pwd=os.getcwd()
		print('pwd=',pwd)

	#主目录文档编译
	jobname="biblatex-gb7714-2015"
	subprocess.run(["xelatex","-no-pdf",jobname])
	subprocess.run(["biber",jobname])
	subprocess.run(["xelatex","--synctex=-1",jobname])
	

	#删除相关文件
	dirlst=os.listdir()
	subdirlst=[]
	for elem in dirlst:
		#print('elem=',elem)
		if os.path.isdir(elem):
			subdir=pwd+os.sep+elem
			os.chdir(subdir)
			pwd=os.getcwd()
			print('pwd=',pwd)

			if elem=="tool":
				fileextadd=[".bbx",".cbx",".def"]
			else:
				fileextadd=[".bbx",".cbx",".def",".bib"]

			for fileext in filelatexext+fileextadd:
				pf1=pathlib.Path('.').glob("*"+fileext)
				pf=[str(x) for x in pf1]
				print('pf=',pf)
				if pf:
					for file in pf:
						fileaux=pwd+os.sep+file
						os.remove(fileaux)
						print(fileaux+" ... removed")
			
			os.chdir(os.pardir)
			pwd=os.getcwd()
			print('pwd=',pwd)
	
	print("compile all ended!")


if __name__ == '__main__':
	compileall()