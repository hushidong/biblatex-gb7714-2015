#!/usr/bin/env python

"""
A python script to modify bib data and 
to display references with specific bibliography standard

features：
1. souce map of biblatex like: generalize date
bib文件数据修改，比如对日期进行规范化等
2. bib file parsing, bib file out, json formatted file out
bib文件解析，输出新的bib文件，或json格式的文件
3. display the bib info with specific standard like GB/T 7714-2015
将bib文件信息格式化显示，比如以GB/T 7714-2015格式显示
4. 当某些项缺失时，后面跟着的项前标点可能会变化的问题，要处理。
5. newspaper,与aritcle的关系
6. standard,与book和inbook的关系
7. 同样是date，newspaper需要写全，而article不需要。

history：
v1.0 2019/02/09

biblatex source map opts：

已实现的选项：
typesource=?entrytype?
typetarget=?entrytype?
fieldsource=?entryfield?
fieldtarget=?entryfield?
match=?regexp?
matchi=?regexp?
notmatch=?regexp?
notmatchi=?regexp?
replace=?regexp?

notfield=?entryfield?
final=true, false default: false
origfieldval=true, false default: false
append=true, false default: false
pertype
pernottype

fieldset=?entryfield?
fieldvalue=?string?
null=true, false default: false
origfield=true, false default: false
origentrytype=true, false default: false
origfieldval=true, false default: false



未实现的选项

entryclone=?clonekey?
entrynew=?entrynewkey?
entrynewtype=?string?
entrytarget=?string?
entrynocite=true, false default: false
entrynull=true, false default: false

1. match 大小写区分的match

"""

__author__ = "Hu zhenzhen"
__version__ = "1.0"
__license__ = "MIT"
__email__ = "hzzmail@163.com"

import string
import re
import sys
import datetime
import copy
import json
import operator



#
# 为数据map设置参数
# 选项的逻辑与biblatex基本一致，
# 差别包括:overwrite选项可以放到step步中表示
#[]=maps
#[[],[]]=map in maps
#[[[]],[]]=step in map in mpas
#[[[{optionkey: }]],[]]=step in map in mpas
#注意python正则表达方式与perl的略有不同，比如unicode表示
#python用\xHH,\uHHHH,\UHHHHHHHH表示，而perl直接用\x{HHHH}表示。
sourcemaps=[#maps
	[#map1:将ELECTRONIC类型转换为online类型
		[{"typesource":"ELECTRONIC","typetarget":"online"}]#step1
	],
	[#map2:将source域转换为url域
		[{"fieldsource":"source","fieldtarget":"url"}]#step1
	],
	[#map3:将urldate域的信息“yyyy-m-d”转换为“yyyy-mm-dd”,注意正则表达式直接写不用在外面套""
		[{"fieldsource":"urldate","match":r'(\d\d\d\d)\-(\d)\-(\d)',"replace":r'\1-0\2-0\3'}]#step1
	],
	[#map4:将urldate域的信息“yyyy-m-d”转换为“yyyy-mm-dd”,注意正则表达式直接写不用在外面套""
		[{"fieldsource":"date","match":r'(\d\d\d\d)\-(\d)\-(\d)',"replace":r'\1-0\2-0\3',"overwrite":True}]#step1
	],
	[#map5:将refdate域转换为urldate域
		[{"fieldsource":"refdate","fieldtarget":"urldate"}]#step1
	],
	[#map6:对于newspaper类型，设置note为news
		[{"pertype":"newspaper"}],#step1
		[{"fieldset":"note","fieldvalue":"news","overwrite":True}]#step2
	],
	[#map7:设置edition域等于version
		[{"fieldsource":"version","final":True}],#step1
		[{"fieldset":"edition","origfieldval":True}]#step2
	],
	[#map8:设置entrykey域设置给keywords
		[{"fieldsource":"entrykey"}],#step1
		[{"fieldset":"keywords","origfieldval":True}]#step2
	],
	[#map9:对于存在note域的情况，将其值添加到keywords
		[{"fieldsource":"note","final":True}],#step1
		[{"fieldset":"keywords","origfieldval":True,"overwrite":True,"append":True}]#step2
	],
	 [#map10:根据标题的字符编码范围确定标题的语言类型
		[{"fieldsource":"title","match":r'[\u2FF0-\u9FA5]',"final":True}],#step1
		[{"fieldset":"userd","fieldvalue":"chinese"}]#step2
	],
]

#重设新的任务处理
sourcemaps=[
	[#map1:设置entrykey域设置给keywords
		[{"fieldsource":"entrykey"}],#step1
		[{"fieldset":"keywords","origfieldval":True,"overwrite":True}]#step2
	],
]


#重设新的任务
sourcemaps=[
	[#map1:取消note域
		[{"fieldsource":"note","final":True}],#step1
		[{"fieldset":"note","null":True,"overwrite":True}]#step2
	],
	[#map2:取消abstract域
		[{"fieldsource":"abstract","final":True}],#step1
		[{"fieldset":"abstract","null":True,"overwrite":True}]#step2
	],
	[#map3:取消keywords域
		[{"fieldsource":"keywords","final":True}],#step1
		[{"fieldset":"keywords","null":True,"overwrite":True}]#step2
	],
	[#map4:取消keywords-plus域
		[{"fieldsource":"keywords-plus","final":True}],#step1
		[{"fieldset":"keywords-plus","null":True,"overwrite":True}]#step2
	],
	[#map5:取消affiliation域
		[{"fieldsource":"affiliation","final":True}],#step1
		[{"fieldset":"affiliation","null":True,"overwrite":True}]#step2
	],
	[#map6:取消funding-acknowledgement域
		[{"fieldsource":"funding-acknowledgement","final":True}],#step1
		[{"fieldset":"funding-acknowledgement","null":True,"overwrite":True}]#step2
	],
	[#map7:取消funding-text域
		[{"fieldsource":"funding-text","final":True}],#step1
		[{"fieldset":"funding-text","null":True,"overwrite":True}]#step2
	],
	]

#重设不处理
sourcemaps=[]


##------------------------------------------
## 参考文献表的制定格式设置，比如GB/T 7714-2015
## 

#选项
formatoptions={
"nameformat":'uppercase',#姓名处理选项：uppercase,lowercase,given-family,family-given,pinyin
"dateformat":'year',#'日期处理选项'：year，iso，等
"urldateformat":'year',#'日期处理选项'：year，iso，等
"maxbibnames":3,#
"minbibnames":3,#
"maxbibitems":1,#
"minbibitems":1,#
}

#本地化字符串
bibstrings={
'andothers':{'english':'et al.','chinese':'等'},
'and':{'english':' and ','chinese':'和'},
'edition':{'english':'th ed.','chinese':'版'},
'in':{'english':'in: ','chinese':'见: '}
}

#类型和载体字符串
typestrings={
'book':'[M]',
'inbook':'[M]',
'standard':'[S]',
'periodical':'[J]',
'article':'[J]',
'newspaper':'[N]',
'patent':'[P]',
'online':'[EB]',
'www':'[EB]',
'electronic':'[EB]',
'proceedings':'[C]',
'inproceedings':'[C]',
'conference':'[C]',
'collection':'[G]',
'incollection':'[G]',
'thesis':'[D]',
'mastersthsis':'[D]',
'phdthsis':'[D]',
'report':'[R]',
'techreport':'[R]',
'manual':'[A]',
'archive/manual':'[A]',
'database':'[DB]',
'dataset':'[DS]',
'software':'[CP]',
'map':'[CM]',
'unpublished':'[Z]',
'misc':'[Z]',
}

#数据类型
datatypeinfo={
'namelist':['author','editor','translator','bookauthor'],
'literallist':['location','address','publisher','institution','organization','school','language','keywords'],
'literalfield':['title','journaltitle','journal','booktitle','subtitle','titleaddon','edition','version','url','volume','number','type','note','labelnumber'],
'datefield':['date','year','urldate','origdate','eventdate'],
'rangefield':['pages']
}

#条目的著录格式
bibliographystyle={
"book":[
{"fieldsource":["labelnumber"],'prestring':"[","posstring":"]","pospunct":"  "},
{"fieldsource":['author','editor','translator'],'nameformat':'uppercase'},
{"fieldsource":['title'],'caseformat':'sentencecase','prepunct':". ",'nolastfieldprepunct':'','posstring':r"\typestring"},
{"fieldsource":['translator'],'nameformat':'uppercase','prepunct':". "},
{"fieldsource":['edition'],'numerformat':'arabic','prepunct':". ","posstring":r'\bibstring{edition}'},#["版","ed."]
{"fieldsource":['location','address'],'prepunct':". ",'replstring':""},#,'replstring':["出版社不详",'[S.l.]']
{"fieldsource":['publisher'],'prepunct':": ",'replstring':"[出版者不详]",'nolastfieldprepunct':'. '},#,'replstring':["出版者不详",'[S.n.]']
{"fieldsource":['date','year'],'prepunct':", "},
{"fieldsource":['pages'],'prepunct':": "},
{"fieldsource":['urldate'],'prestring':"[","posstring":"]"},
{"fieldsource":['url'],'prepunct':". "},
{"fieldsource":['doi'],'prepunct':". "},
{"fieldsource":['endpunct'],'replstring':"."}
],
"article":[
{"fieldsource":["labelnumber"],'prestring':"[","posstring":"]","pospunct":"  "},
{"fieldsource":['author','editor','translator'],'nameformat':'uppercase'},
{"fieldsource":['title'],'caseformat':'sentencecase','prepunct':". ",'nolastfieldprepunct':'','posstring':r"\typestring"},
{"fieldsource":['journaltitle','journal'],'prepunct':". "},
{"fieldsource":['date','year'],'prepunct':", "},
{"fieldsource":['volume'],'prepunct':", "},
{"fieldsource":['number'],'prestring':"(",'posstring':")"},
{"fieldsource":['pages'],'prepunct':": "},
{"fieldsource":['urldate'],'prestring':"[","posstring":"]"},
{"fieldsource":['url'],'prepunct':". "},
{"fieldsource":['doi'],'prepunct':". "},
{"fieldsource":['endpunct'],'replstring':"."}
],
"newspaper":"article"
#article:author.title[usera].journaltitle或journal,year,volume(number):pages[urldate].url.doi
#standard:author.title[usera](//bookauthor.booktitle).edition.location:publisher,date或year:pages[urldate].url.doi
#inbook:author.title[usera]//bookauthor.booktitle.edition.location:publisher,date或year:pages[urldate].url.doi
#periodical:author/editor.title[usera].year或date,volume(number)-endyear, endvolume(endnumber).location:institution,date或year[urldate].url.doi
#newspaper:author.title[usera].journaltitle或journal,date(number)[urldate].url.doi
#patent:author.title:number[usera].date或year[urldate].url.doi
#online:author.title[usera].organization/instiution,date或year:pages(date/enddate/eventdate)[urldate].url.doi
#report:author.title[usera].translator.type number.version.location:institution,date 或year:pages[urldate].url.doi
#thesis:author.title[usera].translator.location:institution,date或year:pages[urldate].url.doi
}


#
#
#格式化一个文献条目文本
def formatallbibliography():
	labelnumber=0
	bibliographytext=''
	for bibentry in bibentries:
		labelnumber=labelnumber+1
		bibentry['labelnumber']=labelnumber
		bibentrytext=''
		bibentrytext=formatbibentry(bibentry)
		bibliographytext=bibliographytext+bibentrytext+'\n'
		
	print('\nreferecences')
	print(bibliographytext)

#
#
#格式化一个文献条目文本
def formatbibentry(bibentry):
	
	print('--------------new entry---------')
	print('\nbibentry:',bibentry)
	#bibentrytext='entry:'
	
	bibentrytext=''
	
	if bibentry['entrytype'] in bibliographystyle:
		print('INFO: format style of entrytype',bibentry['entrytype'],'is defined.')
		if isinstance(bibliographystyle[bibentry['entrytype']],str):
			formattype=bibliographystyle[bibentry['entrytype']]
		else:
			formattype=bibentry['entrytype']
		
		lastfield=True #前一域存在
		
		for fieldinfo in bibliographystyle[formattype]:
			
			rtnfield=formatfield(bibentry,fieldinfo,lastfield)
			fieldtext=rtnfield[0]
			lastfield=rtnfield[1]
			
			bibentrytext=bibentrytext+fieldtext
	
		
	print(bibentrytext)
	return bibentrytext

#
#
#格式化文献条目的域
#不同类型的域不同处理
#分5类：姓名列表，文本列表，文本域，日期域，范围域
#其中姓名列表，文本列表，日期域，日期域，范围域，都需要进行特殊的解析
#而volume，number如果需要特殊解析则在文件域的格式处理时增加新的处理逻辑。
def formatfield(bibentry,fieldinfo,lastfield):

	print('fieldinfo:',fieldinfo)
	#首先把域的内容先解析处理
	fieldcontents=''
	
	fieldsource=None
	if fieldinfo['fieldsource'][0] in  datatypeinfo['namelist']:
		
		for field in fieldinfo['fieldsource']:#
			if field in bibentry:#当域存在域条目中时，确定要处理的域
				fieldsource=field
				exit
		if fieldsource:
			fieldcontents=namelistparser(bibentry,fieldsource)
		

	elif fieldinfo['fieldsource'][0] in  datatypeinfo['literallist']:

		for field in fieldinfo['fieldsource']:#
			if field in bibentry:#当域存在域条目中时，确定要处理的域
				fieldsource=field
				exit
		if fieldsource:
			fieldcontents=literallistparser(bibentry,fieldsource)
			
			
	elif fieldinfo['fieldsource'][0] in  datatypeinfo['literalfield']:

		for field in fieldinfo['fieldsource']:#
			if field in bibentry:#当域存在域条目中时，确定要处理的域
				fieldsource=field
				exit
		if fieldsource:
			fieldcontents=literalfieldparser(bibentry,fieldsource)
			
			
	elif fieldinfo['fieldsource'][0] in  datatypeinfo['datefield']:

		for field in fieldinfo['fieldsource']:#
			if field in bibentry:#当域存在域条目中时，确定要处理的域
				fieldsource=field
				exit
		if fieldsource:
			fieldcontents=datefieldparser(bibentry,fieldsource)
			
			
	elif fieldinfo['fieldsource'][0] in  datatypeinfo['rangefield']:

		for field in fieldinfo['fieldsource']:#
			if field in bibentry:#当域存在域条目中时，确定要处理的域
				fieldsource=field
				exit
		if fieldsource:
			fieldcontents=rangefieldparser(bibentry,fieldsource)
	
	if not fieldsource:
		if 'replstring' in fieldinfo and fieldinfo['replstring']:
			print('replstring')
			fieldsource=True
			fieldcontents=fieldinfo['replstring']
			
	
	#接着做进一步的格式化，包括标点，格式，字体等
	fieldtext=''
	
	print(fieldsource)
	if fieldsource:
		if lastfield:#当前一个著录项存在，则正常输出
			if 'prepunct' in fieldinfo:
				fieldtext=fieldtext+fieldinfo['prepunct']
		else:#当前一个著录项不存在，则首先输出'nolastfieldprepunct'
			if 'nolastfieldprepunct' in fieldinfo:
				fieldtext=fieldtext+fieldinfo['nolastfieldprepunct']
			elif 'prepunct' in fieldinfo:
				fieldtext=fieldtext+fieldinfo['prepunct']
		
		if 'prestring' in fieldinfo:
			fieldtext=fieldtext+fieldinfo['prestring']
		
		if 'fieldformat' in fieldinfo:
			fieldtext=fieldtext+'{'+fieldinfo['fieldformat']+'{'+fieldcontents+'}}'
		else:
			fieldtext=fieldtext+str(fieldcontents)
		
		if 'posstring' in fieldinfo:
			fieldtext=fieldtext+fieldinfo['posstring']
		
		if 'pospunct' in fieldinfo:
			fieldtext=fieldtext+fieldinfo['pospunct']
			
		#更新lastfiled
		lastfield=True
	else:
		lastfield=False
	
	
	#本地化字符串的处理
	print('fieldtext:',fieldtext)
	while r'\bibstring' in fieldtext:
		
		language=languagejudgement(bibentry,fieldinfo,fieldsource)
		m = re.search(r'\\bibstring{(.*)}',fieldtext)#注意\字符的匹配，即便是在r''中也需要用\\表示
		fieldtext=re.sub(r'\\bibstring{.*}',bibstrings[m.group(1)][language],fieldtext,count=1)
		print('fieldtext:',fieldtext)
		#下面这句不行因为，在字典取值是，不支持\1这样的正则表达式
		#fieldtext=re.sub(r'\\bibstring{(.*)}',bibstrings[r'\1'][language],fieldtext,count=1)
	
	#标题的类型和载体标识符的处理
	if r'\typestring' in fieldtext:
		print(r'\typestring in',fieldtext)
		if 'url' in bibentry:
			typestring=typestrings[bibentry['entrytype']]
			typestring=typestring.replace(']','/OL]')
		else:
			typestring=typestrings[bibentry['entrytype']]
		print(typestring)
		fieldtext=fieldtext.replace(r'\typestring',typestring)
		
	return [fieldtext,lastfield]





#
#根据作者域或者标题域确定条目的语言
#
def languagejudgement(bibentry,fieldinfo,fieldsource):

	if fieldsource in datatypeinfo['namelist']:#当域是作者类时，利用作者域本身信息做判断
	
		language=fieldlanguage(bibentry[fieldsource])
		
	else:#其它情况，利用title域做判断
		if 'title' in bibentry:
			language=fieldlanguage(bibentry['title'])
		elif 'author' in bibentry:
			language=fieldlanguage(bibentry['author'])
		else:
			language='english'
		
	return language
	

#
#根据域值所在的字符范围确定域的语言
#
def fieldlanguage(fieldvalueinfo):

	if re.match(r'[\u2FF0-\u9FA5]', fieldvalueinfo):
		language='chinese'
	elif re.match(r'[\u3040-\u30FF\u31F0}-\u31FF]', fieldvalueinfo):
		language='japanese'
	elif re.match(r'[\u1100-\u11FF\u3130-\u318F\uAC00-\uD7AF]', fieldvalueinfo):
		language='korean'
	elif re.match(r'[\u0400-\u052F]', fieldvalueinfo):
		language='russian'
	elif re.match(r'[\u0100-\u017F]', fieldvalueinfo):
		language='french'
	else:
		language='english'
	
	return language


#
#
#姓名列表解析
def namelistparser(bibentry,fieldsource):
	fieldcontents=bibentry[fieldsource]
	
	return fieldcontents

	

#
#
#文本列表解析
def literallistparser(bibentry,fieldsource):
	fieldcontents=bibentry[fieldsource]
	
	return fieldcontents

#
#
#文本域解析
def literalfieldparser(bibentry,fieldsource):
	fieldcontents=bibentry[fieldsource]
	
	return fieldcontents

#
#
#文本域解析
def datefieldparser(bibentry,fieldsource):
	fieldcontents=bibentry[fieldsource]
	
	return fieldcontents


#
#
#文本域解析
def rangefieldparser(bibentry,fieldsource):
	fieldcontents=bibentry[fieldsource]
	
	return fieldcontents


#
#
#打开bib文件
def readfilecontents(bibFile):
	print("INFO: Reading references from '" + bibFile + "'")
	try:
		fIn = open(bibFile, 'r', encoding="utf8")
		global bibfilecontents
		bibfilecontents=fIn.readlines()
		fIn.close()
		
		global usedIds
		usedIds = set()
		if auxfile:
			fInAux = open(auxfile, 'r', encoding="utf8")
			for line in fInAux:
				if line.startswith("\\citation") or line.startswith("\\abx@aux@cite"):
					ids = line.split("{")[1].rstrip("} \n").split(", ")
					for id in ids:
						if (id != ""):
							usedIds.add(id)
			fInAux.close()
			print('references:',usedIds)
		
	except IOError:
		print("ERROR: Input bib file '" + bibFile +
				"' doesn't exist or is not readable")
		sys.exit(-1)

#
#打印bib文件内容
def printfilecontents():
	for line in bibfilecontents:
		print(line)
		
#
#输出修改后的bib文件
def writefilenewbib(bibFile):

	print(datetime.datetime.now().isoformat(timespec='seconds'))
	
	#json文件输出
	jsonoutfile="new"+bibFile.replace('.bib','.json')
	print("INFO: writing all references to '" + jsonoutfile + "'")
	fout = open(jsonoutfile, 'w', encoding="utf8")
	json.dump(bibentries, fout)
	fout.close()

	#bib文件输出
	biboutfile="new"+bibFile
	
	try:
		fout = open(biboutfile, 'w', encoding="utf8")
		fout.write("%% \n")
		fout.write("%% bib file modified by biblatex-map.py\n")
		
		fout.write("%% "+datetime.datetime.now().isoformat(timespec='seconds')+"\n")
		fout.write("%% \n\n\n")
		writebibentrycounter=0
		if auxfile:
			print("INFO: writing cited references in aux to '" + biboutfile + "'")
			
			for bibentry in bibentries:
				if bibentry["entrykey"] in usedIds:
					writebibentrycounter=writebibentrycounter+1
					fout.write('@'+bibentry["entrytype"]+'{'+bibentry["entrykey"]+',\n')
					for k,v in bibentry.items():
						if k=="entrytype" or k=="entrykey" or v=='""' or v==None or k=='entrysn':
							pass
						else:
							fout.write('\t'+str(k)+' = {'+str(v)+'},\n')
					fout.write('}\n\n')
		else:
			print("INFO: writing all references to '" + biboutfile + "'")
			for bibentry in bibentries:
				writebibentrycounter=writebibentrycounter+1
				fout.write('@'+bibentry["entrytype"]+'{'+bibentry["entrykey"]+',\n')
				for k,v in bibentry.items():
					if k=="entrytype" or k=="entrykey" or v=='""' or k=='entrysn' or v==None:
						pass
					else:
						fout.write('\t'+k+' = {'+v+'},\n')
				fout.write('}\n\n')
		
		fout.close()
		print("INFO: " + str(writebibentrycounter) + " references writed")
	except IOError:
		print("ERROR: Input bib file '" + bibFile +
				"' doesn't exist or is not readable")
		sys.exit(-1)
		
#
#将条目解析放到bibentries列表中
#每个条目是一个dict字典
def bibentryparsing():
	global bibentries
	bibentries=[]#用于记录所有条目
	bibentry={}#用于记录当前条目
	entrysn=0 #用于标记条目序号
	entrystated=False #用于标记条目开始
	fieldvalended=True #用于标记域的值当前行是否已经结束
	fieldvalue="" #用于记录当前域的值
	counterbracket=0 #用于追踪{}符号
	counterquotes=0  #用于追踪“”符号
	enclosebracket=True #用于记录是用{}还是用“”做为域的值的包围符号
	enclosenone=False #用于记录域的值无包围符号的情况
	
	for line in bibfilecontents:#遍历所有行
		#print(line)
		
		if line.startswith("@") and not "@comment" in line.lower():#判断条目开始行
			entrysn=entrysn+1
			entrystated=True #新条目开始
			print('entrysn=',entrysn)
			entrynow=line.lstrip('@').split(sep='{', maxsplit=1)
			#print(entrynow)
			entrytype=entrynow[0]
			bibentry['entrytype']=entrytype.lower()#条目类型小写，方便比较
			entrykey=entrynow[1].split(sep=',', maxsplit=1)[0]
			bibentry['entrykey']=entrykey
			bibentry['entrysn']=entrysn
		elif entrystated: #只有新条目开始了才有意义

			if fieldvalended: #当前行不是前面的未结束域的值
				if '=' in line and not line.lstrip().startswith("}"):
					#排除以'}'开头的行后根据=号判断条目域信息行，不可能出现=号无法判断信息行的问题，
					#因为是域值中存在=的特殊情况已经在未结束逻辑处理
					entryline=line.lstrip()
					entrynow=entryline.split(sep='=', maxsplit=1)
					#print(entrynow)
					entryfield=entrynow[0].strip().lstrip().lower()#域名小写，方便比较
					entryfieldline=entrynow[1].lstrip()
					
					if entryfieldline.startswith("{"):
						enclosebracket=True
					elif entryfieldline.startswith('"'):
						enclosebracket=False
					else:#当没有符号包围是设置enclosenone以便特殊处理
						enclosenone=True
					
					fieldvalcontinued=True #临时标记，用于记录域值是否还未结束，先假设未结束
					for chari in entryfieldline.strip():#遍历域值中的每个字符
						fieldvalue=fieldvalue+chari
						if chari =='{':#对{符号进行追踪
							counterbracket=counterbracket+1
						elif chari =='}':#对}符号进行追踪
							counterbracket=counterbracket-1
							if enclosebracket:
								if counterbracket==0:#当}与域开始的{配对，那么说明域值已经结束
									bibentry[entryfield]=fieldvalue[1:-1]#利用strip可能会消多次，因此用list的方式处理
									fieldvalue=""
									counterbracket=0
									counterquotes=0
									fieldvalended=True
									fieldvalcontinued=False
									break #直接跳出循环
						elif chari =='"':
							counterquotes=counterquotes+1
							if not enclosebracket:
								if operator.mod(counterquotes,2)==0:
									bibentry[entryfield]=fieldvalue[1:-1]
									fieldvalue=""
									counterbracket=0
									counterquotes=0
									fieldvalended=True
									fieldvalcontinued=False
									break
						elif chari ==',':#若域值没有包围符号那么遇到,号即为域值结束
							if enclosenone:
								bibentry[entryfield]=fieldvalue[:-1]
								fieldvalue=""
								counterbracket=0
								counterquotes=0
								fieldvalended=True
								fieldvalcontinued=False
								enclosenone=False
						
						#测试：输出看是否正确
						#if entryfield=='abstract':
						#	print('val=',fieldvalue)
						#	print('counterbracket=',counterbracket)
						
					if fieldvalcontinued:
						fieldvalended=False
				
				elif '}' in line:#条目结束行

					global bibentryglobal
					bibentryglobal=copy.deepcopy(bibentry) 
					print('entry:',bibentryglobal)
					bibentries.append(bibentryglobal)
					bibentry={}
					entrystated=False
					
			else: #当前行是前面的未结束域的值，因此直接往前面的域值添加即可
				fieldvalcontinued=True
				entryfieldline=" "+line
				for chari in entryfieldline.strip():
					fieldvalue=fieldvalue+chari
					if chari =='{':
						counterbracket=counterbracket+1
					elif chari =='}':
						counterbracket=counterbracket-1
						if enclosebracket:
							if counterbracket==0:
								bibentry[entryfield]=fieldvalue[1:-1]
								fieldvalue=""
								counterbracket=0
								counterquotes=0
								fieldvalended=True
								fieldvalcontinued=False
								break
					elif chari =='"':
						counterquotes=counterquotes+1
						if not enclosebracket:
							if mod(counterquotes,2)==0:
								bibentry[entryfield]=fieldvalue[1:-1]
								fieldvalue=""
								counterbracket=0
								counterquotes=0
								fieldvalended=True
								fieldvalcontinued=False
								break
					elif chari ==',':
							if enclosenone:
								bibentry[entryfield]=fieldvalue[:-1]
								fieldvalue=""
								counterbracket=0
								counterquotes=0
								fieldvalended=True
								fieldvalcontinued=False
								enclosenone=False
				if fieldvalcontinued:
					fieldvalended=False

	print('entrysn=',entrysn)
	bibentrycounter=len(bibentries)
	print('entrycounter=',bibentrycounter)
	if not bibentrycounter==entrysn:
		try:
			raise BibParsingError('bib file parsing went wrong!')
		except BibParsingError as e:
			raise BibParsingError(e.message)
	print('entrytotal=',bibentrycounter)
	
	#输出解析后的bib文件信息
	#for bibentryi in bibentries:
		#print(bibentryi)


#
#打印bibentries列表中的所有条目
def printbibentries():
	for bibentryi in bibentries:
		print(bibentryi)	
			

#
#自定义异常类
class BibParsingError(Exception):
	def __init__(self,message):
		Exception.__init__(self)
		self.message=message 
		
#
# 执行数据映射操作
# 还有很多选项没有实现，20190209
# 实现的选项中也需要和未实现的选项进行数据传递
def execsourcemap():
	for map in sourcemaps:#every map in maps，每个map逐步开始
		for bibentry in bibentries:#每个映射都需要遍历所有条目，对每个条目做map
	
			mapcontinue=1#大于0表示正常，继续当前条目的map
			typesrcinfo={}#用于记录typesource相关处理结果
			fieldsrcinfo={}#用于记录fieldsource相关处理的结果
			constraintinfo={}#用于记录类型等限制信息记录
			constraintinfo['pertype']=[]
			constraintinfo['pernottype']=[]
			
			#print("map info=",map)
			for step in map:#every step in map
				if mapcontinue>0:#对前面已经final完成的情况做限制
					for keyvals in step:#key-vals in step
						for k,v in keyvals.items():#step 是有迹可循的，每个step总是存在一些东西，找到这些做其中的逻辑即可
							#print(k,v)
							
							if k=="typesource":#条目类型设置
								mapcontinue=maptypesource(keyvals,bibentry,typesrcinfo)#coef is dict
								
							elif k=="fieldsource":#域查找或设置
								mapcontinue=mapfieldsource(keyvals,bibentry,fieldsrcinfo,constraintinfo)#
								#print("fieldsource step:",fieldsrcinfo)
								
							elif k=="fieldset":#域设置
								mapcontinue=mapfieldset(keyvals,bibentry,typesrcinfo,fieldsrcinfo,constraintinfo)#
								
							elif k=="pertype": #类型限制
								mapcontinue=mappertype(keyvals,constraintinfo)
								
							elif k=="pernottype":#类型限制
								mapcontinue=mappernottype(keyvals,constraintinfo)
								
							elif k=="notfield":#域限制
								mapcontinue=mapnotfield(keyvals,bibentry,fieldsrcinfo,constraintinfo)#
							else:
								pass

								
#
#域限制,若域确定不存在则终止map				
def mapnotfield(keyvals,bibentry,fieldsrcinfo,constraintinfo):

	setcontinue=True
	print(setcontinue)
	if len(constraintinfo['pertype'])>0:
		if bibentry['entrytype'] not in constraintinfo['pertype']:#
			setcontinue=False
	if len(constraintinfo['pernottype'])>0:
		if bibentry['entrytype'] in constraintinfo['pernottype']:#
			setcontinue=False
	print(setcontinue)

	
	print("constraints:notfield")
	if setcontinue:
		for k,v in keyvals.items():
			#print(k,v)
			if k=='notfield':
				notfield=v.lower()
			elif k=='final':
				fieldfinal=v
			else:
				pass
				
		if notfield not in bibentry:#当notfield不存在，则判断为true，若存在final则终止，否则继续
			if fieldfinal:
				return 0
			else:
				return 1
		else:
			return 1
			
	else:
		return 0
	

								
								#
#条目类型限制,将类型限制信息放入字典				
def mappertype(keyvals,constraintinfo):
	
	print("constraints:pertype")
	for k,v in keyvals.items():
		#print(k,v)
		if k=='pertype':
			pertype=v.lower()#因为大小写区分，所以全部小写方便比较
		else:
			pass
	print('pertype=',pertype)
	
	constraintinfo['pertype'].append(pertype)
	return 1
	
#
#条目类型限制,将类型限制信息放入字典				
def mappernottype(keyvals,constraintinfo):
	
	print("constraints:pernottype")
	for k,v in keyvals.items():
		#print(k,v)
		if k=='pernottype':
			pernottype=v.lower()#因为大小写区分，所以全部小写方便比较
		else:
			pass
	print('pertype=',pertype)
	
	constraintinfo['pernottype'].append(pernottype)
	return 1
 
								
#
#条目类型转换				
def maptypesource(keyvals,bibentry,typesrcinfo):
	retrunval=1
	for k,v in keyvals.items():
		#print(k,v)
		if k=='typesource':
			typesource=v.lower()
		elif k=='typetarget':
			typetarget=v.lower()
		elif k=='final':
			retrunval=0
		else:
			pass
		
	typesrcinfo
	if typetarget:
		if bibentry['entrytype']==typesource:
			bibentry['entrytype']=typetarget
			typesrcinfo['typesource']=typesource
			return 1
		else:
			return retrunval #存在final时，且不匹配则终止map
	else:
		if bibentry['entrytype']==typesource:
			typesrcinfo['typesource']=typesource
		else:
			typesrcinfo['typesource']=None
		return retrunval
#
#
# 域信息设置
def mapfieldset(keyvals,bibentry,typesrcinfo,fieldsrcinfo,constraintinfo):
	overwrite=False
	append=False
	
	setcontinue=True
	print(setcontinue)
	if len(constraintinfo['pertype'])>0:
		if bibentry['entrytype'] not in constraintinfo['pertype']:#
			setcontinue=False
	if len(constraintinfo['pernottype'])>0:
		if bibentry['entrytype'] in constraintinfo['pernottype']:#
			setcontinue=False
	print(setcontinue)
	
	if setcontinue:
	
		for k,v in keyvals.items():
			#print(k,v)
			if k=='fieldset':
				fieldset=v.lower()
			elif k=='fieldvalue':
				fieldvalue=v
			elif k=='origfieldval':
				fieldvalue=fieldsrcinfo[fieldsrcinfo['fieldsource']]
				print(fieldvalue)
			elif k=='origentrytype':
				fieldvalue=typesrcinfo['typesource']
				print(fieldvalue)
			elif k=='origfield':
				fieldvalue=fieldsrcinfo['fieldsource']
				print(fieldvalue)
			elif k=='null':
				fieldvalue=None
				print(fieldvalue)
			elif k=='append':
				append=v
			elif k=='overwrite':
				overwrite=v
			else:
				pass
				
		
		print("fieldset=",fieldset)
		if overwrite:
			if append:
				oldvalue=bibentry[fieldset]
				newvalue=oldvalue+","+fieldvalue
				bibentry[fieldset]=newvalue
			else:
				bibentry[fieldset]=fieldvalue
		else:
			if fieldset in bibentry:
				pass
			else:
				bibentry[fieldset]=fieldvalue
		return 1
		
	else:
		return 1
	
#
#域名转换或判断域是否存在或match
def mapfieldsource(keyvals,bibentry,fieldsrcinfo,constraintinfo):
	mapfieldtype=0 #域名map的类型设置
	fieldmatch=''#匹配模式默认为空
	fieldmatchi=''#匹配模式默认为空
	
	
	setcontinue=True
	print(setcontinue)
	if len(constraintinfo['pertype'])>0:
		if bibentry['entrytype'] not in constraintinfo['pertype']:#
			setcontinue=False
	if len(constraintinfo['pernottype'])>0:
		if bibentry['entrytype'] in constraintinfo['pernottype']:#
			setcontinue=False
	print(setcontinue)
	
	
	overwrite=False
	for k,v in keyvals.items():
		#print(k,v)
		if k=='fieldsource':
			fieldsource=v.lower()
		elif k=='fieldtarget':
			fieldtarget=v.lower()
			mapfieldtype=1 #域map类型1，直接做域名转换
		elif k=='replace':
			fieldreplace=v
			mapfieldtype=2 #域map类型2，直接做域信息转换
		elif k=='final':
			fieldfinal=v #final要么选项不给出，要么选项给出为true
			if fieldfinal:#当为true时则做终止判断
				mapfieldtype=3 #域map类型3，做final判断可以终止map
		elif k=='overwrite':#
			overwrite=v
		elif k=='match':#不区分大小写的match
			fieldmatch=v
		elif k=='matchi':#区分大小写的match
			fieldmatchi=v
		elif k=='notmatch':#不区分大小写的notmatch，下面这两个选项的逻辑没有实现
			fieldnotmatch=v
		elif k=='notmatchi':#区分大小写的notmatch
			fieldnotmatch=v
		else:
			pass
	
	
	if setcontinue:

		#返回字典的第一项是fieldsource信息
		fieldsrcinfo['fieldsource']=fieldsource
		
		if mapfieldtype==0:#第0中情况即，不做信息转换，也不终止map，仅返回一些信息
		
			if fieldsource in bibentry:
				if fieldmatch:
					m = re.match(fieldmatch, bibentry[fieldsource])
					if m:
						fieldsrcinfo[fieldsource]=[bibentry[fieldsource],fieldmatch]
					else:
						fieldsrcinfo[fieldsource]=[None] #正则不匹配，则返回为None

				elif fieldmatchi:
					m = re.match(fieldmatchi, bibentry[fieldsource])
					if m:
						fieldsrcinfo[fieldsource]=[bibentry[fieldsource],fieldmatchi]
					else:
						fieldsrcinfo[fieldsource]=[None] #正则不匹配，则返回为None
					
				else:
					fieldsrcinfo[fieldsource]=bibentry[fieldsource]#将域的值记录下来，用于下一step
			
			else:
				fieldsrcinfo[fieldsource]=[None] #域不存在则返回为None
			return 1
			
		
		elif mapfieldtype==1:#第1中情况即，做域名转换
			print('fieldsource=',fieldsource,'fieldtarget=',fieldtarget)
			if fieldsource in bibentry:
				bibentry[fieldtarget]=bibentry[fieldsource]
				del bibentry[fieldsource]
				fieldsrcinfo[fieldsource]=bibentry[fieldtarget]
			else:
				fieldsrcinfo[fieldsource]=[None]
			return 1
		
		
		elif mapfieldtype==2:#域map类型2，直接做域信息转换，真正操作需要overwrite选项支持
			print('fieldsource=',fieldsource)
			print('fieldmatch=',fieldmatch)
			print('fieldreplace=',fieldreplace)
			if overwrite:
				if fieldsource in bibentry:
					if fieldmatch:
						#strafrpl=re.sub(r'(\d\d\d\d)\-(\d)\-(\d)',r'\1-0\2-0\3','2015-1-3')
						#strafrpl=re.sub(r'(\d\d\d\d)\-(\d)\-(\d)',r'\1-0\2-0\3',bibentry[fieldsource])
						strafrpl=re.sub(fieldmatch,fieldreplace,bibentry[fieldsource]) #执行替换
						print('strafterreplace=',strafrpl)
						bibentry[fieldsource]=strafrpl
					elif fieldmatchi:
						strafrpl=re.sub(fieldmatchi, fieldreplace,bibentry[fieldsource]) 
						bibentry[fieldsource]=strafrpl
					else:
						fieldsrcinfo[fieldsource]=[None]
				else:
					fieldsrcinfo[fieldsource]=[None]
			else:
				fieldsrcinfo[fieldsource]=[None]
			return 1

		
		elif mapfieldtype==3:#域map类型3，当没有匹配则终止map
			if fieldsource in bibentry:
				if fieldmatch:
					m = re.match(fieldmatch, bibentry[fieldsource])
					if m:
						fieldsrcinfo[fieldsource]=[bibentry[fieldsource],fieldmatch]
						return 1
					else:
						return 0

				elif fieldmatchi:
					if m:
						fieldsrcinfo[fieldsource]=[bibentry[fieldsource],fieldmatchi]
						return 1
					else:
						return 0
					
				else:
					fieldsrcinfo[fieldsource]=bibentry[fieldsource]#将域的值记录下来，用于下一step
					return 1
			
			else:
				return 0
	
	else:
		fieldsrcinfo[fieldsource]=[None]
		return 1
	
					
				

		
#运行脚本测试
if __name__=="__main__":
	
	#设置需要修改的bib文件
	#inputbibfile='example.bib'
	inputbibfile='biblatex-map-test.bib'
	
	#auxfile="opt-gbpub-true.aux"
	#set the aux file
	#this is not necessary
	auxfile=''
	#auxfile="opt-gbpub-true.aux"
	
	readfilecontents(inputbibfile)
	
	#printfilecontents()

	bibentryparsing()
	
	#printbibentries()
	
	execsourcemap()
	
	#printbibentries()
	
	writefilenewbib(inputbibfile)
	
	print(bibentries[0])

	print(formatbibentry(bibentries[0]))
	
	formatallbibliography()
		