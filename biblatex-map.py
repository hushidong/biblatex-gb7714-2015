#!/usr/bin/env python

"""
python script to modify bib data

features：
1. souce map of biblatex
2. generalize date

history：
v1.0 2019/02/09

biblatex source map opts：

已实现的选项：
typesource=⟨entrytype⟩
typetarget=⟨entrytype⟩
fieldsource=⟨entryfield⟩
fieldtarget=⟨entryfield⟩
match=⟨regexp⟩
matchi=⟨regexp⟩
notmatch=⟨regexp⟩
notmatchi=⟨regexp⟩
replace=⟨regexp⟩

未实现的选项
notfield=⟨entryfield⟩
fieldset=⟨entryfield⟩
fieldvalue=⟨string⟩
entryclone=⟨clonekey⟩
entrynew=⟨entrynewkey⟩
entrynewtype=⟨string⟩
entrytarget=⟨string⟩
entrynocite=true, false default: false
entrynull=true, false default: false
append=true, false default: false
final=true, false default: false
null=true, false default: false
origfield=true, false default: false
origfieldval=true, false default: false
origentrytype=true, false default: false
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


#
# 为数据map设置参数
#[]=maps
#[[],[]]=map in maps
#[[[]],[]]=step in map in mpas
#[[[{optionkey: }]],[]]=step in map in mpas
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
		[{"fieldsource":"date","match":r'(\d\d\d\d)\-(\d)\-(\d)',"replace":r'\1-0\2-0\3'}]#step1
	],
	[#map5:将refdate域转换为urldate域
		[{"fieldsource":"refdate","fieldtarget":"urldate"}]#step1
	],
    
]

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
	biboutfile="new"+bibFile
	print("INFO: writing references from '" + biboutfile + "'")
	try:
		fout = open(biboutfile, 'w', encoding="utf8")
		fout.write("%% \n")
		fout.write("%% bib file modified by bibmap.py\n")
		print(datetime.datetime.now().isoformat(timespec='seconds'))
		fout.write("%% "+datetime.datetime.now().isoformat(timespec='seconds')+"\n")
		fout.write("%% \n\n\n")
		for bibentry in bibentries:
			fout.write('@'+bibentry["entrytype"]+'{'+bibentry["entrykey"]+',\n')
			for k,v in bibentry.items():
				if k=="entrytype" or k=="entrykey" or v=='""':
					pass
				else:
					fout.write('\t'+k+' = '+v+',\n')
			fout.write('}\n\n')
		
		fout.close()
	except IOError:
		print("ERROR: Input bib file '" + bibFile +
				"' doesn't exist or is not readable")
		sys.exit(-1)
		
#
#将条目解析放到bibentries列表中
#每个条目是一个dict字典
def bibentryparsing():
	global bibentries
	bibentries=[]
	bibentry={}
	entrysn=0
	for line in bibfilecontents:
		#print(line)
		if line.startswith("@"):#条目开始行
			entrysn=entrysn+1
			entrynow=line.lstrip('@').split(sep='{', maxsplit=1)
			#print(entrynow)
			entrytype=entrynow[0]
			bibentry['entrytype']=entrytype
			entrykey=entrynow[1].split(sep=',', maxsplit=1)[0]
			bibentry['entrykey']=entrykey
		else:
			if '=' in line:#条目域信息行
				entryline=line.lstrip()
				entrynow=entryline.split(sep='=', maxsplit=1)
				#print(entrynow)
				entryfield=entrynow[0].strip().lstrip()
				#print(entrynow[1])
				entryfieldline=entrynow[1].split(sep=',', maxsplit=1)
				entryfieldvalue=entryfieldline[0].lstrip()
				if entryfieldvalue=='':
					pass
				else:
					bibentry[entryfield]=entryfieldvalue.strip()
			elif '}' in line:#条目结束行
				print('entrysn=',entrysn)
				global bibentryglobal
				bibentryglobal=copy.deepcopy(bibentry) 
				bibentries.append(bibentryglobal)
				bibentry={}
			else:
				pass
	bibentrycounter=len(bibentries)
	print('entrytotal=',bibentrycounter)
	for bibentryi in bibentries:
		print(bibentryi)
			
def printbibentries():
	for bibentryi in bibentries:
		print(bibentryi)	
			

		
#
# 执行数据映射操作
# 还有很多选项没有实现，20190209
# 实现的选项中也需要和未实现的选项进行数据传递
def execsourcemap():
	for map in sourcemaps:#every map in maps，每个map逐步开始
		for bibentry in bibentries:#每个映射都需要遍历所有条目，对每个条目做map
	
			mapcontinue=1#大于0表示正常，继续当前条目的map
			fieldsrcinfo={}#用于接收fieldsource相关处理的结果
			print("map info=",map)
			for step in map:#every step in map
				if mapcontinue>0:
					for keyvals in step:#key-vals in step
						for k,v in keyvals.items():#step 是有迹可循的，每个step总是存在一些东西，找到这些做其中的逻辑即可
							#print(k,v)
							if k=="typesource":#条目类型设置
								mapcontinue=maptypesource(keyvals,bibentry)#coef is dict
							elif k=="fieldsource":#域查找或设置
								mapcontinue=mapfieldsource(keyvals,bibentry,fieldsrcinfo)#coef is dict
								pass
							elif k=="fieldset":#域设置
								pass
							elif k=="pertype":#类型限制
								pass
							elif k=="pernottype":#类型限制
								pass
							elif k=="notfield":#域限制
								pass
							else:
								pass

#
#条目类型转换				
def maptypesource(keyvals,bibentry):
	retrunval=1
	for k,v in keyvals.items():
		#print(k,v)
		if k=='typesource':
			typesource=v
		elif k=='typetarget':
			typetarget=v
		elif k=='final':
			retrunval=0
		else:
			pass
			
	if bibentry['entrytype']==typesource:
		bibentry['entrytype']=typetarget
		return 1
	else:
		return retrunval #存在final时，且不匹配则终止map
	
#
#域名转换或判断域是否存在或match
def mapfieldsource(keyvals,bibentry,fieldsrcinfo):
	mapfieldtype=0 #域名map的类型设置
	fieldmatch=''#匹配模式默认为空
	fieldmatchi=''#匹配模式默认为空

	for k,v in keyvals.items():
		#print(k,v)
		if k=='fieldsource':
			fieldsource=v
		elif k=='fieldtarget':
			fieldtarget=v
			mapfieldtype=1 #域map类型1，直接做域名转换
		elif k=='replace':
			fieldreplace=v
			mapfieldtype=2 #域map类型2，直接做域信息转换
		elif k=='final':
			if v=='false':
				fieldfinal=v
			else:
				fieldfinal='true'
			mapfieldtype=3 #域map类型3，做final判断可以终止map
		elif k=='match':#不区分大小写的match
			fieldmatch=v
		elif k=='matchi':#区分大小写的match
			fieldmatchi=v
		elif k=='notmatch':#区分大小写的match
			fieldnotmatch=v
		else:
			pass
	
	
	if mapfieldtype==0:#第0中情况即，不做信息转换，也不终止map，仅返回一些信息
	
		if fieldsource in bibentry:
			if fieldmatch=='':
				m = re.match(fieldmatch, bibentry[fieldsource])
				if m:
					fieldsrcinfo[fieldsource]=[bibentry[fieldsource],fieldmatch]
				else:
					fieldsrcinfo[fieldsource]=[None] #正则不匹配，则返回为None

			elif fieldmatchi=='':
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
	
	elif mapfieldtype==2:#域map类型2，直接做域信息转换
		print('fieldsource=',fieldsource)
		print('fieldmatch=',fieldmatch)
		print('fieldreplace=',fieldreplace)
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
	

	
					
				

		
#运行脚本测试
if __name__=="__main__":
	print('hello')
	print(b'hello')
	readfilecontents("biblatex-map-test.bib")
	
	printfilecontents()

	bibentryparsing()
	
	printbibentries()
	
	execsourcemap()
	
	printbibentries()
	
	writefilenewbib("biblatex-map-test.bib")
    
    
		