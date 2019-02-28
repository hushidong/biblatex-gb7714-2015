# biblatex-map.py

是一个用于处理、修改和规范化bib文件的python脚本。

主要功能包括：
1. 基于biblatex的source map的逻辑修改bib文件中的参考文献信息
2. 输入bib文件的解析，输出修改后的bib文件，以及json格式的参考文献文件
3. 输出定制著录格式比如GB/T 7714-2015标准的参考文献表，输出文本或者thebibliography环境。简化格式定制方式
4. 进一步可以实现一个宏包，实现一个简化功能的低配版biblatex

处理的逻辑遵循biblatex的动态数据修改的规范，修改参数设置基本相同，只是把biblatex用tex命令表示的`\maps`、`\map`和`\step`转换为用json格式表示。

等价于用python重新实现了biber的动态数据修改功能。

-------------------------------

本来想将这一内容放到Pezmc开发的biblatex_check脚本中，但想想还是纯粹点好了。

-------------------------------

Maintainer: huzhenzhen <hzzmail@163.com>

Homepage: <https://github.com/hushidong/biblatex-map>

License：MIT license


--------------------------------------

## 用法：

直接在python命令行中运行

`./biblatex-map.py`

需要修改的bib文件在`biblatex-map.py`修改：

```
if __name__=="__main__":
    
    #设置输入的bib文件
	inputbibfile='biblatex-map-test.bib'
	
	#set the aux file
	#this is not necessary
	#auxfile='tex-source-code.aux'
```

输出的bib/json文件自动生成，当设置了aux文件后，那么输出的bib文件中条目将限制为aux中引用的文献条目。

修改bib文件内容的配置用json格式表示，直接在`biblatex-map.py`修改sourcemaps参数：

```
#maps所有的修改用map构成一个maps
sourcemaps=[
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
```

sourcemaps参数其实是json格式的。
sourcemaps是一个列表，记录所有的修改，一个修改是一个map，也是一个列表。
一个map列表中有任意数量的step(步骤)，一个step内由一个key-val参数构成字典(dict)数据结构。

处理逻辑是这样：
```
	for map in maps #遍历maps中的所有map
		for entry in entries #对所有的条目均执行该map
			for step in map #遍历map中的所有step
				code for the step to modify the bib entry				 
```

需要注意：python中正则和perl中的略有不同，比如python用\xHH,\uHHHH,\UHHHHHHHH表示unicode字符，而perl直接用\x{HHHH}表示。

## need to do：

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






