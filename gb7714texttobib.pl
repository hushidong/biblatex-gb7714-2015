##%
##% ---------------------------------------------------------------
##% gb7714texttobib--- A transformation tool for GB/T 7714-2015 style 
##% bibliography text to bib source file
##% 
##% Maintained by huzhenzhen
##% Homepage: <https://github.com/hushidong/biblatex-gb7714-2015>
##% history:
##% 	2017/02/26 v1.0g
##% E-mail: 
##% 	hzzmail@163.com
##% Released under the LaTeX Project Public License v1.3c or later
##% usage:
##% 	perl gb7714texttobib.pl in=textfilename out=bibfilename
##% options(need to do):
##% 	style=ay or default
##% 	key=ay or default
##%
##% ---------------------------------------------------------------
#%Target:: 将pdf文档中拷出的参考文献文本转换成bib文件，文本文件中的一条参考文献为一行
#%Method:: 利用perl进行文本处理，处理和判断的两个重要方面是:
#          分析分割后的文本的位置和内容，使用的是正则表达式匹配，主要两种方式
#		   1.根据标点和本文特征一部分一部分的解析，比如book条目处理
#		   2.直接列出所有可能的正则表达式一个个匹配，比如article条目处理
#%Date  :: 2017-02-22
#%Note  :: 1.网址之类如果解析出错，应确认其前导词http://之前没有空格
#          2.有些以.连接有从属关系的机构作者，可以把.后的空格去掉便于正确解析
#          3.有些尽管解析到的域不是真实的域，但不影响著录格式(显示效果)，相应条目的域
#            可以在bib文件中完善，尽管从实用角度并不需要这么做。
#
##% ---------------------------------------------------------------
##% todo: 1. pdf 的比较？
##% obsolete intro:
##% 	  1.源文件文档如果个别地方不符合规范，可以修改一下
##% 	   (a):inbook/standard类中，当出现//后面第二项是booktitle且其中存在:时，先把父标题的冒号改成colon，比如
##%			[M]//李承森. 宋史: 第 1 册. 北京: 中华书局. 应把宋史后的冒号改掉
##% 	    [S]//全国文献工作标准化技术委员会. 文献工作国家标准汇编: 3. 北京: 中国标准出版社, 1988: 59–92.
##% ---------------------------------------------------------------


foreach $file(@ARGV){
	print 'file:',$file,"\n";
	if($file=~m/in=/){
	($infile)=($file=~m/in=(.*)/)
	}
	if($file=~m/out=/){
	($outfile)=($file=~m/out=(.*)/)
	}
}

open (FHR,"<$infile");
open (FHW,">$outfile");
print FHW '% Encoding: UTF-8',"\n";

@references=<FHR>;#将所有的文献存为@references数组，各文献以<行>为单位进行区分

$ns=1;
$ne=@references;
$nline=0;
foreach $reference(@references){

	$nline=$nline+1;
	if($nline<$ns){next;} #先跳过几行进行，配合后面的last进行当行测试

	while($reference=~m/–/){
		$reference=~s/–/-/;#直接利用正则表达式更正页码/日期/网址中的连字符
	}
	print "$reference ";#打印各文献的内容
	
	undef	$entrytype;
	undef	$author;
	undef	$title;
	undef	$journal;
	undef	$translator;
	undef	$bookauthor;
	undef	$booktitle;
	undef	$version;
	undef	$address;
	undef	$publisher;
	undef	$institution;
	undef	$year;
	undef	$type;
	undef	$date;
	undef	$volume;
	undef	$number;
	undef	$pages;
	undef	$eventdate;
	undef	$urldate;
	undef	$url;
	undef	$doi;
	undef	$note;
	undef	$eventyvn; 
	undef	$endeventyvn;
	undef	$eventdate; 
	undef	$eventvol; 
	undef	$eventnum;
	undef	$endeventdate; 
	undef	$endeventvol; 
	undef	$endeventnum;
	
	#---------------------------------------------------------------
	#条目类型:期刊和期刊中析出的文献/periodical、article
	#---------------------------------------------------------------
	if(1){
	if($reference=~m/\[J\]/){
		if($reference=~m/:\s/ and $reference=~m/:\s\D/){#根据存在出版社前的冒号加空格区分
			print 'this entry is periodical',"\n";
			$entrytype='periodical';
		}else{
			print 'this entry is article',"\n";
			$entrytype='article';
		}
	}
	
	if($entrytype eq 'periodical'){#字符串比较用eq而数字比较用==，如果用==那么两边都是1，则是真
		$regexformach='\[J\]\.';
		&bfidentifier;
		
		($preadderess, $pospublisher)=($reference=~m/\[J\]\.(.*):\s(.*)/);
		print 'preadderess =',$preadderess,"\n";
		print 'pospublisher=',$pospublisher,"\n";
		($eventyear, $address)=($preadderess=~m/(.*)\.\s(.*)/);
		print 'eventyear   =',$eventyear,"\n";
		print 'address     =',$address,"\n";
		($eventyvn, $endeventyvn)=($eventyear=~m/(.*)\-(.*)/);#yvn表示year，volume，number
		print 'eventyvn    =',$eventyvn,"\n";
		print 'endeventyvn =',$endeventyvn,"\n"; 
		if($eventyvn=~m/.*,.*/){#存在逗号表明有卷信息
			($eventdate, $eventvol, $eventnum)=($eventyvn=~m/\s*(.*),\s(.*)\((.*)\)/);#yvn表示year，volume，number
			print 'eventdate    =',$eventdate,"\n";
			print 'eventvol     =',$eventvol,"\n"; 
			print 'eventnum     =',$eventnum,"\n"; 
			if($endeventyvn){
				($endeventdate, $endeventvol, $endeventnum)=($endeventyvn=~m/\s*(.*),\s(.*)\((.*)\)/);#yvn表示year，volume，number
				print 'endeventdate =',$endeventdate,"\n";
				print 'endeventvol  =',$endeventvol,"\n"; 
				print 'endeventnum  =',$endeventnum,"\n"; 
			}
		}else{
			($eventdate, $eventnum)=($eventyvn=~m/\s*(.*)\((.*)\)/);#yvn表示year，volume，number
			print 'eventdate    =',$eventdate,"\n";
			print 'eventvol     =',$eventvol,"\n"; 
			print 'eventnum     =',$eventnum,"\n"; 
			if($endeventyvn){
				($endeventdate, $endeventnum)=($endeventyvn=~m/\s*(.*)\((.*)\)/);#yvn表示year，volume，number
				print 'endeventdate =',$endeventdate,"\n";
				print 'endeventvol  =',$endeventvol,"\n"; 
				print 'endeventnum  =',$endeventnum,"\n"; 
			}
		}
		if($endeventdate){
			$date=$eventdate.'-'.$endeventdate;
		}else{
			$date=$eventdate
		}
		if($endeventvol){
			$volume=$eventvol.'-'.$endeventvol;
		}else{
			$volume=$eventvol
		}
		if($endeventnum){
			$number=$eventnum.'-'.$endeventnum;
		}else{
			$number=$eventnum
		}
		print 'date      =',$date,"\n";
		print 'volume    =',$volume,"\n"; 
		print 'number    =',$number,"\n"; 
		($publisher)=($pospublisher=~m/(.*),/);
		print 'publisher =',$publisher,"\n";
	}
	
	if($entrytype eq 'article'){
		$regexformach='\[J\]\.';
		&bfidentifier;
	
	    $flagmatched=0;
		$regexbfjournal='\]\.\s(.*),\s(.*),\s(.*)\((.*)\):\s(.*)\.';#包括全部信息
		if($reference=~m/$regexbfjournal/){
			($journal,$date,$volume,$number,$pages)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			print '包括全部信息',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*),\s(.*)\((.*)\)\.';#没有页码
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume,$number)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			print '没有页码',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*),\s(.*):\s(.*)\.';#没有期
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume,$pages)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			print '没有期',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*)\((.*)\):\s(.*)\.';#没有卷/年
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$number,$pages)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
			print '没有卷/年',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*),\s(.*)\.';#没有页码,期
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			print '没有页码,期',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*)\((.*)\)\.';#没有页码,卷/年
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$number)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
			print '没有页码,卷/年',"\n";
		}
		$regexbfjournal='\]\.\s(.*),\s(.*):\s(.*)\.';#没有卷/年,期
		if($reference=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$pages)=($reference=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
			print '没有卷/年,期',"\n";
		}
		
		if($flagmatched==0){
			print 'the text after title was not matched, please add a regex for the current entry in the perl source code!',"\n";
			print '当前条目标题之后的内容没有匹配的正则表达式，请在perl代码中增加适合该条目正则表达式!',"\n";
		}
		
		print 'journal =',$journal,"\n";
		print 'date    =',$date,"\n";
		print 'volume  =',$volume,"\n";
		print 'number  =',$number,"\n";
		print 'pages   =',$pages,"\n";
	
	}
		
	#判断期刊中析出的文献,带url
	if($reference=~m/\[J\/OL\]/){
		print 'this entry is article with url',"\n";
		$entrytype='article';
		
		$regexformach='\[J\/OL\]\.';
		&bfidentifier;
		
		($postitle)=($reference=~m/\[J\/OL\]\.\s(.*)/);
		if($postitle=~m/\[.*\]/){#存在urldate
			($preurldate,$urldate,$posurl)=($postitle=~m/(.*)\[(.*)\]\.\s(.*)/);
		}else{#不存在urldate
			($preurldate,$posurl)=($postitle=~m/(.*)(http:.*)/);
		}
		unless($preurldate=~m/\.$/){$preurldate=$preurldate.'.';}#加个点统一上面两种方式
		
		#处理url和doi
		$regexposurl='(.*)doi:\s(.*)';#处理url和doi
		if($posurl=~m/$regexposurl/i){
			($url,$doi)=($posurl=~m/$regexposurl/i);
		}else{
			$url=$posurl;
		}
		
		#处理urldate前的内容，基本article不带url的情况相同
		$flagmatched=0;
		$regexbfjournal='(.*),\s(.*),\s(.*)\((.*)\):\s(.*)\.';#包括全部信息
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume,$number,$pages)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
		}
		$regexbfjournal='(.*),\s(.*),\s(.*)\((.*)\)\.';#没有页码
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume,$number)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
		}
		$regexbfjournal='(.*),\s(.*),\s(.*):\s(.*)\.';#没有期
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume,$pages)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
		}
		$regexbfjournal='(.*),\s(.*)\((.*)\):\s(.*)\.';#没有卷/年
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$number,$pages)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
		}
		$regexbfjournal='(.*),\s(.*),\s(.*)\.';#没有页码,期
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$volume)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
		}
		$regexbfjournal='(.*),\s(.*)\((.*)\)\.';#没有页码,卷/年
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$number)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
		}
		$regexbfjournal='(.*),\s(.*):\s(.*)\.';#没有卷/年,期
		if($preurldate=~m/$regexbfjournal/ and $flagmatched==0){
			($journal,$date,$pages)=($preurldate=~m/$regexbfjournal/);
			$flagmatched=1;
			if($date!~m/\d{4}/){
			$volume=$date;
			$date='';
			}
		}
		
		if($flagmatched==0){
			print 'the text after title was not matched, please add a regex for the current entry in the perl source code!',"\n";
			print '当前条目标题之后的内容没有匹配的正则表达式，请在perl代码中增加适合该条目正则表达式!',"\n";
		}
		
		print 'journal =',$journal,"\n";
		print 'date    =',$date,"\n";
		print 'volume  =',$volume,"\n";
		print 'number  =',$number,"\n";
		print 'pages   =',$pages,"\n";
		print 'urldate =',$urldate,"\n";
		print 'url     =',$url,"\n";
		print 'doi     =',$doi,"\n";


	}
	}
	
	#---------------------------------------------------------------
	#条目类型:判断报纸中析出的文献/newspaper
	#---------------------------------------------------------------
	if(1){
	if($reference=~m/\[N\]/){
		print 'this entry is newspaper',"\n";
		$entrytype='newspaper';
		$note='news';
		$regexnewsflag='\[N\]';
		$onlineflag=0;
	}
	if($reference=~m/\[N\/OL\]/){
		print 'this entry is newspaper with url',"\n";
		$entrytype='newspaper';
		$note='news';
		$regexnewsflag='\[N\/OL\]';
		$onlineflag=1;
	}
	if($entrytype eq 'newspaper'){
		if($onlineflag==1){
			$regexformach='\[N\/OL\]';
			&bfidentifier;
			
			print 'has url',"\n";
			$flagmatched=0;
			$regexnewspostitle='\.\s(.*),\s(.*)\((.*)\)\s*\[(.*)\]\.\s(.*)';
			if($reference=~m/$regexnewsflag$regexnewspostitle/ and $flagmatched==0){
			$flagmatched=1;
			($journal,$date,$number,$urldate,$posurl)=($reference=~m/$regexnewsflag$regexnewspostitle/);}
			$regexnewspostitle='\.\s(.*),\s(.*)\s*\[(.*)\]\.\s(.*)';
			if($reference=~m/$regexnewsflag$regexnewspostitle/ and $flagmatched==0){
			$flagmatched=1;
			($journal,$date,$urldate,$posurl)=($reference=~m/$regexnewsflag$regexnewspostitle/);}
			if($flagmatched==0){
			print 'the text after title was not matched, please add a regex for the current entry in the perl source code!',"\n";
			print '当前条目标题之后的内容没有匹配的正则表达式，请在perl代码中增加适合该条目正则表达式!',"\n";
			}
		}else{
			$regexformach='\[N\]';
			&bfidentifier;
			
			print 'no url',"\n";
			$regexnewspostitle='\.\s(.*),\s(.*)\((.*)\)';
			($journal,$date,$number)=($reference=~m/$regexnewsflag$regexnewspostitle/);
		}
		#处理url和doi
		$regexposurl='(.*)doi:\s(.*)';#处理url和doi
		if($posurl=~m/$regexposurl/i){
			($url,$doi)=($posurl=~m/$regexposurl/i);
		}else{
			$url=$posurl;
		}
		
		# print 'journal =',$journal,"\n";
		# print 'date    =',$date,"\n";
		# print 'volume  =',$volume,"\n";
		# print 'number  =',$number,"\n";
		# print 'pages   =',$pages,"\n";
		# print 'urldate =',$urldate,"\n";
		# print 'url     =',$url,"\n";
		# print 'doi     =',$doi,"\n";
	}
	}
	
		
	#---------------------------------------------------------------
	#条目类型:论文集中析出的文献/inproceedings
	#---------------------------------------------------------------
	if(1){#\/\/
		if ($reference=~m/\[C\/OL\]\/\//){
			$entrytype='inproceedings';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[C\/OL\]\/\/';
			&bfidentifier;
			
			$regexformach='C\/OL\]\/\/';
			&bfaddressinbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[C\]\/\//){
			$entrytype='inproceedings';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[C\]\/\/';
			&bfidentifier;
			
			$regexformach='C\]\/\/';
			&bfaddressinbook;
			
			&afpublisherbook;
		}
		
		if ($entrytype eq 'inproceedings'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
		}
		
	}
	
	
	#---------------------------------------------------------------
	#条目类型:论文集/proceedings 
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[C\/OL\]\./){
			$entrytype='proceedings';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[C\/OL\]\.';
			&bfidentifier;
			
			$regexformach='C\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[C\]\./){
			$entrytype='proceedings';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[C\]\.';
			&bfidentifier;
			
			$regexformach='C\]\.';
			&bfaddressbook;
			
			&afpublisherbook;
		}
		
		if ($entrytype eq 'proceedings'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
			print 'date=',"$date";
		}
	}
	
	
	
	
	#---------------------------------------------------------------
	#条目类型:未出版物/unpublished
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[Z\/OL\]\./){
			$entrytype='unpublished';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[Z\/OL\]\.';
			&bfidentifier;
			
			$regexformach='Z\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurlb;
		}elsif($reference=~m/\[Z\]\./){
			$entrytype='unpublished';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[Z\]\.';
			&bfidentifier;
			
			$regexformach='Z\]\.';
			&bfaddressbook;
			
			&afpublisherbookb;
		}
		
		if ($entrytype eq 'unpublished'){
			$date=$year;
			print 'date=',"$date";
		}
	}
	
		
	#---------------------------------------------------------------
	#条目类型:手册、档案/manual
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[A\/OL\]\./){
			$entrytype='manual';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[A\/OL\]\.';
			&bfidentifier;
			
			$regexformach='A\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurlb;
		}elsif($reference=~m/\[A\]\./){
			$entrytype='manual';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[A\]\.';
			&bfidentifier;
			
			$regexformach='A\]\.';
			&bfaddressbook;
			
			&afpublisherbookb;
		}
		
		if ($entrytype eq 'manual'){
			$date=$year;
			print 'date=',"$date";
		}
	}
	
	
	
	#---------------------------------------------------------------
	#条目类型:报告/report
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[R\/OL\]\./){
			$entrytype='report';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[R\/OL\]\.';
			&bfidentifier;
			
			$regexformach='R\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurlb;
		}elsif($reference=~m/\[R\]\./){
			$entrytype='report';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[R\]\.';
			&bfidentifier;
			
			$regexformach='R\]\.';
			&bfaddressbook;
			
			&afpublisherbookb;
		}
		
		if ($entrytype eq 'report'){
			$date=$year;
			print 'date=',"$date";
		}
	
	}
	
	#---------------------------------------------------------------
	#条目类型:标准/standard
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[S\/OL\]\./){
			$entrytype='standard';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[S\/OL\]\.';
			&bfidentifier;
			
			$regexformach='S\/OL\]\.';
			&bfaddressbook;
			&afpublisherbookurl;
		}elsif($reference=~m/\[S\]\./){
			$entrytype='standard';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[S\]\.';
			&bfidentifier;
			
			$regexformach='S\]\.';
			&bfaddressbook;
			
			&afpublisherbook;
		}elsif ($reference=~m/\[S\/OL\]\/\//){
			$entrytype='standard';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[S\/OL\]\/\/';
			&bfidentifier;
			
			$regexformach='S\/OL\]\/\/';
			&bfaddressinbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[S\]\/\//){
			$entrytype='standard';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[S\]\/\/';
			&bfidentifier;
			
			$regexformach='S\]\/\/';
			&bfaddressinbook;
			
			&afpublisherbook;
		}
		if ($entrytype eq 'standard'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
			$note='standard';
			print 'date=',"$date";
			print 'note=',"$note";
		}
	
	}
	
	#---------------------------------------------------------------
	#条目类型:学位论文/thesis
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[D\/OL\]\./){
			$entrytype='thesis';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[D\/OL\]\.';
			&bfidentifier;
			
			$regexformach='D\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[D\]\./){
			$entrytype='thesis';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[D\]\.';
			&bfidentifier;
			
			$regexformach='D\]\.';
			&bfaddressbook;
			
			&afpublisherbook;
		}
		
		if ($entrytype eq 'thesis'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
			print 'date=',"$date";
		}
	
	}
	
	
	#---------------------------------------------------------------
	#条目类型:汇编中析出的文献/incollection 
	#---------------------------------------------------------------
	if(1){#\/\/
		if ($reference=~m/\[G\/OL\]\/\//){
			$entrytype='incollection';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[G\/OL\]\/\/';
			&bfidentifier;
			
			$regexformach='G\/OL\]\/\/';
			&bfaddressinbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[G\]\/\//){
			$entrytype='incollection';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[G\]\/\/';
			&bfidentifier;
			
			$regexformach='G\]\/\/';
			&bfaddressinbook;
			
			&afpublisherbook;
		}
		
		if ($entrytype eq 'incollection'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
		}
		
	}
	
	
	#---------------------------------------------------------------
	#条目类型:汇编/collection 
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[G\/OL\]\./){
			$entrytype='collection';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[G\/OL\]\.';
			&bfidentifier;
			
			$regexformach='G\/OL\]\.';
			&bfaddressbook;
		
			&afpublisherbookurl;
		}elsif($reference=~m/\[G\]\./){
			$entrytype='collection';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[G\]\.';
			&bfidentifier;
			
			$regexformach='G\]\.';
			&bfaddressbook;
			
			&afpublisherbook;
		}
		
		if ($entrytype eq 'collection'){
			if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
				$address=""; 
			}
			if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
				$publisher=""; 
			}
			$date=$year;
			print 'date=',"$date";
		}
	}
	
	
	#---------------------------------------------------------------
	#条目类型:专利/patent
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[P\/OL\]\./){
			$entrytype='patent';
			print "this entry's type is: $entrytype with url\n";
			$regexformach='\[P\/OL\]\.';
			&bfidentifier;
		}elsif($reference=~m/\[P\]\./){
			$entrytype='patent';
			print "this entry's type is: $entrytype \n";
			$regexformach='\[P\]\.';
			&bfidentifier;
		}
		
		if($entrytype eq 'patent'){
			($postitle)=($reference=~m/$regexformach\s*(.*)/);
			print 'postitle=',$postitle,"\n";
			$titlenumber=$title;
			if($titlenumber=~m/:\s*\d.*/){
				($title,$number)=($titlenumber=~m/(.*):\s*(\d.*)/);
				print 'title  =',$title,"\n";
				print 'number =',$number,"\n";
			}
			
			if($postitle=~m/\[.*\]/ and $reference=~m/\[P\/OL\]\./){
				($date,$urldate,$posurl)=($postitle=~/(.*)\s*\[(.*)\]\.\s*(.*)/);
				print 'date=',$date,"\n";
				print 'urldate  =',$urldate,"\n";
				print 'posurl   =',$posurl,"\n";
				if($posurl=~m/DOI/i){#匹配存在doi的话
					($url,$doi)=($posurl=~m/(.*)DOI:(.*)\./i);
					print 'url=',"$url \n";
					print 'doi=',"$doi \n";
				}else{
					$url=$posurl;
					print 'url   =',"$url \n";
				}
			}else{
				$posurl=$postitle;
				if($posurl=~m/DOI/i){#匹配存在doi的话
					($date,$doi)=($posurl=~m/(.*)DOI:(.*)\./i);
					print 'date=',"$date \n";
					print 'doi =',"$doi \n";
				}else{
					$date=$posurl;
					print 'date   =',"$date \n";
				}
			}
		}
	}
	
	
	#---------------------------------------------------------------
	#条目类型:电子资源/online
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[EB\/OL\]\./){#匹配[EB/OL]判断为online类型
			$entrytype='online';
			print "this entry's type is: $entrytype \n";
			
			$regexformach='\[EB\/OL\]\.';
			&bfidentifier;
			
			($postitle)=($reference=~m/$regexformach\s*(.*)/);
			print 'postitle=',$postitle,"\n";
			
			if($postitle=~m/\(.*\)/ and $postitle=~m/\[.*\]/){#存在更新日期和引用日期
				($eventdate,$urldate,$posurl)=($postitle=~/\s*\((.*)\)\s*\[(.*)\]\.\s*(.*)/);
			}elsif($postitle=~m/\(.*\)/ and $postitle!~m/\[.*\]/){#存在更新日期但无引用日期
				($eventdate,$posurl)=($postitle=~/\s*\((.*)\)\.\s*(.*)/);
			}elsif($postitle!~m/\(.*\)/ and $postitle=~m/\[.*\]/){#存在引用日期但无更新日期
				($urldate,$posurl)=($postitle=~/\s*\[(.*)\]\.\s*(.*)/);
			}else{
				($posurl)=($postitle=~/\s*(.*)/);
			}
			print 'eventdate=',$eventdate,"\n";
			print 'urldate  =',$urldate,"\n";
			print 'posurl   =',$posurl,"\n";
			
			if($posurl=~m/DOI/i){#匹配存在doi的话
				($url,$doi)=($posurl=~m/(.*)DOI:(.*)\./i);
				print 'url=',"$url \n";
				print 'doi=',"$doi \n";
			}else{
				$url=$posurl;
				print 'url   =',"$url \n";
			}
		}
	}
	
	#---------------------------------------------------------------
	#条目类型:专著/book
	#---------------------------------------------------------------
	if(1){
	if ($reference=~m/\[M\]\./){#匹配[M]判断为book类型
		print "this entry's type is: book \n";
		$entrytype='book';
		
		$regexformach='\[M\]\.';
		&bfidentifier;
				
		$regexformach='M\]\.';
		&bfaddressbook;
		
		&afpublisherbook;
		
		if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
			$address=""; 
		}
		if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
			$publisher=""; 
		}
		$date=$year;
	}
	}
	
	#---------------------------------------------------------------
	#条目类型:专著但存在网址/book with url  
	#---------------------------------------------------------------
	if(1){
	if ($reference=~m/\[M\/OL\]\./){ 
		print "this entry's type is: book with url\n";
		$entrytype='book';
		
		$regexformach='\[M\/OL\]\.';
		&bfidentifier;
		
		$regexformach='M\/OL\]\.';
		&bfaddressbook;
	
		&afpublisherbookurl;

		
		if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
			$address=""; 
		}
		if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
			$publisher=""; 
		}
		$date=$year;
	}
	}
	
		
	#---------------------------------------------------------------
	#条目类型:专著中析出文献/inbook
	#---------------------------------------------------------------
	if(1){
	if ($reference=~m/\[M\]\/\//){#匹配[M]//判断为inbook类型
		print "this entry's type is: inbook \n";
		$entrytype='inbook';
		
		$regexformach='\[M\]\/\/';
		&bfidentifier;
				
		$regexformach='M\]\/\/';
		&bfaddressinbook;
		
		&afpublisherbook;#出版社及之后的信息inbook/book一样的

		
		if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
			$address=""; 
		}
		if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
			$publisher=""; 
		}
		$date=$year;
	}
	}
	

	#---------------------------------------------------------------
	#条目类型:专著中析出文献但存在网址/inbook with url
	#---------------------------------------------------------------
	if(1){
		if ($reference=~m/\[M\/OL\]\/\//){#匹配[M]//判断为inbook类型
		print "this entry's type is: inbook \n";
		$entrytype='inbook';
		
		
		$regexformach='\[M\/OL\]\/\/';
		&bfidentifier;
				
		$regexformach='M\/OL\]\/\/';
		&bfaddressinbook;
		
		&afpublisherbookurl;#出版社及之后的信息inbook/book一样的

		
		if ($address=~m/\[S\.l\.\]/ or $address=~m/出版地不详/) {#当存在英文的[s.n.]
			$address=""; 
		}
		if ($publisher=~m/\[s\.n\.\]/ or $publisher=~m/出版者不详/) {#当存在英文的[s.n.]
			$publisher=""; 
		}
		$date=$year;
	}
	}
	
		
	#---------------------------------------------------------------
	#输出到bib文件中
	#---------------------------------------------------------------
	if(1){
		if($date=~m/-\d{4}/){#存在enddate的情况下，将中间的连字符转化成斜杠
			print 'date=',$date,"\n";
			($datetempa,$datetempb)=($date=~m/(.*)-(\d{4}.*)/);
			$date=$datetempa.'/'.$datetempb;
			print 'date=',$date,"\n";
		}
	
		if($url=~m/.*\.$/){
			$urlplusdot=$url;
			($url)=($urlplusdot=~m/(.*)\.$/);#去掉处于条目末尾的url地址后的点
		}
		#最后输出
		print "\n";
		print '@',"$entrytype",'{',"ref-$nline-$sn",',',"\n";
		$author&& print 'author    = {',$author,'},',"\n";
		$title&& print 'title     = {',$title,'},',"\n";
		$journal&& print 'journal   = {',$journal,'},',"\n";
		$translator&& print 'translator= {',$translator,'},',"\n";
		$bookauthor&& print 'bookauthor= {',$bookauthor,'},',"\n";
		$booktitle&& print 'booktitle = {',$booktitle,'},',"\n";
		$version&& print 'version   = {',$version,'},',"\n";
		$address&& print 'address   = {',$address,'},',"\n";
		$publisher&& print 'publisher = {',$publisher,'},',"\n";
		$type&& print 'type = {',$type,'},',"\n";
		$date&& print 'date      = {',$date,'},',"\n";
		$volume&& print 'volume      = {',$volume,'},',"\n";
		$number&& print 'number      = {',$number,'},',"\n";
		$pages&& print 'pages     = {',$pages,'},',"\n";
		$eventdate&& print 'eventdate   = {',$eventdate,'},',"\n";
		$urldate&& print 'urldate   = {',$urldate,'},',"\n";
		$url&& print 'url       = {',$url,'},',"\n";
		$doi&& print 'doi       = {',$doi,'},',"\n";
		$note&& print 'note       = {',$note,'},',"\n";
		print '}',"\n";
		print 'authorlabel=',$authorlabel,"\n";
	
			
		print FHW '@',"$entrytype",'{',"ref-$nline-$sn-$authorlabel",',',"\n";
		$author&& print FHW 'author    = {',$author,'},',"\n";
		$title&& print FHW 'title     = {',$title,'},',"\n";
		$journal&& print FHW 'journal   = {',$journal,'},',"\n";
		$translator&& print FHW 'translator= {',$translator,'},',"\n";
		$bookauthor&& print FHW 'bookauthor= {',$bookauthor,'},',"\n";
		$booktitle&& print FHW 'booktitle = {',$booktitle,'},',"\n";
		$version&& print FHW 'version   = {',$version,'},',"\n";
		$address&& print FHW 'address   = {',$address,'},',"\n";
		$publisher&& print FHW 'publisher = {',$publisher,'},',"\n";
		$type&& print FHW 'type = {',$type,'},',"\n";
		$date&& print FHW 'date      = {',$date,'},',"\n";
		$volume&& print FHW 'volume      = {',$volume,'},',"\n";
		$number&& print FHW 'number      = {',$number,'},',"\n";
		$pages&& print FHW 'pages     = {',$pages,'},',"\n";
		$eventdate&& print FHW 'eventdate   = {',$eventdate,'},',"\n";
		$urldate&& print FHW 'urldate   = {',$urldate,'},',"\n";
		$url&& print FHW 'url       = {',$url,'},',"\n";
		$doi&& print FHW 'doi       = {',$doi,'},',"\n";
		$note&& print FHW 'note       = {',$note,'},',"\n";
		print FHW '}',"\n";
	}
	
	
	print "\n";
	if($nline>=$ne){last;} #先跳过几行进行，配合后面的last进行当行测试
}

	sub bfidentifier{#bf表示before，标识符前所有的类型都一样
		#$regexpformach=@_;
		#print '@_=',@_,"\n";
		#print 'regexpformach=',"$regexpformach \n";
		#标识符之前很容易匹配三个内容，序号，作者和标题
		if($reference=~m/.*\D\.\s\D.*$regexformach/){#匹配存在作者后的点的话，同时点号周围不是数字，有时标题中可能出现1.1这样的信息
			($sn , $author , $title)=($reference=~m/\[(\d+)\]\s*(.*)\.\s(.*)$regexformach/);
			print 'sn    =',"$sn \n";
			print 'author=',"$author \n";#作者多个姓名还需要处理，还要注意有前后缀的情况
			print 'title =',"$title \n";
			if($author=~m/等/){
				$author=~s/等/others/;#将等换成others
			}else{
				$author=~s/,\s*$//;#将最后一个逗号去掉
			}
			if($author=~m/et\sal/){
				$author=~s/et\sal/others/;#将et al.换成others
			}else{
				$author=~s/,\s*$//;#将最后一个逗号去掉
			}
			while($author=~m/,/){
				$author=~s/,/ and /;#将逗号换成and
			}
			print 'author=',"$author \n";
		}else{#不存在作者的话\[M\]\/\/
			($sn , $title)=($reference=~m/\[(\d+)\]\s*(.*)$regexformach/);#标识符之前很容易匹配三个内容，序号，作者和标题
			print 'sn    =',"$sn \n";
			print 'title =',"$title \n";
		}
		
		#进一步处理责任者的姓名,主要针对英文名需要有一些符号进行区分姓，名，前缀和后缀。
		@names=split('and',$author);
		print 'names=',@names,"\n";
		$author="";
		$j=0;
		foreach $name(@names){#一个姓名一个姓名处理
			
			$j=$j+1;
			#print $name,"\n";
			@nameparts=split(' ',$name);
			#print 'nameparts=',@nameparts,"\n";
			
			$org=0;
			for($k=0;$k<@nameparts;$k++){
			if(@nameparts[$k]=~m/.{2,}/ and @nameparts[$k]!~m/\s*von\s*/i and @nameparts[$k]!~m/\s*jr\s*/i){
			#当分解的单作者的各个部分，存在两个以上为2个字符以上的情况，说明不是一般的姓名而是机构作者
				$org=$org+1;
				print 'org=',"$org\n";
			}
			}
			
			if(@nameparts>1){
				if(@nameparts[0]=~m/\s*von\s*/i){#确定姓的位置
					$family=1;
					@nameparts[1]=@nameparts[1].',';
				}else{
					$family=0;
					@nameparts[0]=@nameparts[0].',';
				}
				if(@nameparts[-1]=~m/\s*jr\s*/i){#确定后缀的位置
					@nameparts[-1]=@nameparts[-1].'.,';
					$given=@nameparts-2;
					$suffix=1;
				}else{
					$suffix=0;
					$given=@nameparts-1;
				}
				print 'family=',$family,"\n";
				print 'given=',$given,"\n";
				print 'suffix=',$suffix,"\n";
				print 'familyname=',@nameparts[$family],"\n";
				
				$namefmt="";
				for($i=0;$i<=$family;$i++){
					$namefmt=$namefmt.@nameparts[$i].' ';
					print $i,$family,$namefmt,"\n";
				}
				if($suffix){
					$namefmt=$namefmt.@nameparts[-1].' ';
				}
				for($i=$family+1;$i<=$given;$i++){
					$namefmt=$namefmt.@nameparts[$i].' ';
					print $i,$family,$namefmt,"\n";
				}
			}else{
				$namefmt=$name;
			}
			if($org > 1){#当是机构作者时
				$namefmt='{'.$name.'}';
			}
			print 'namefmt=',"$namefmt \n";
			
			if($j==1){#把姓名用and连接起来
				$author=$namefmt;
			}else{
				$author=$author.' and '.$namefmt;
			}
			
			if($j==1){#根据第一个作者构建authorlabel
				if($org > 1){#机构作者取各单词的首字母
					$authorlabel='';
					for($k=0;$k<@nameparts;$k++){
						($strtmp)=($nameparts[$k]=~/^(.)/);
						$authorlabel=$authorlabel.$strtmp;
					}
				}else{#姓名则仅取作者姓
					($authorlabel)=$nameparts[$family];
					if($authorlabel=~m/,$/){$authorlabel=~s/,$//;}#去掉最后的逗号
				}
			}
		}
		while($author=~m/\s{2,}/){
				$author=~s/\s{2,}/ /;#将多余的空格去掉
			}
		while($author=~m/\.{2,}/){
				$author=~s/\.{2,}/\./;#将多余的点去掉
			}
		print 'author=',"$author\n";
	}

	
	sub bfaddressbook{#bf表示before，出版者前book和inbook不一样
	#对于book类型，必然存在出版地和出版者信息，以此为根据展开
		print 'sub:bfaddressbook ',"\n";
		if($reference!~m/$regexformach\s*[^:]+:\s\D{1,}.*/){#如果不存在出版地和出版者信息
			($pospublisher)=($reference=~m/$regexformach\s*(.*)/);
			print 'pospublisher=',"$pospublisher \n";
		}else{
			($preaddress, $pospublisher)=($reference=~m/$regexformach\s*([^:]+):\s(\D{1,}.*)/);#标识符之后根据第一个冒号分为包括地址的信息和包括出版者的信息两部分
			print 'preaddress  =',"$preaddress \n";
			print 'pospublisher=',"$pospublisher \n";
			
			#处理出版地及其前面的信息
			if ($preaddress=~m/.*\[S\.l\.\].*/) {#当存在英文的[S.l.]，英文的一般不存在译者，所以下面处理比较简单
				$preaddress=~s/\[S\.l\.\]/\[S-l-\]/; #先将[S.l.]换成[S-l-]然后换回来
			}
				if ($preaddress=~m/.*\d.*\.\s*.*/){#匹配存在数字版本的话
					($preversion, $version, $address)=($preaddress=~m/(.*)(\d)[^\.]*\.\s*(.*)/);
					print 'preversion  =',"$preversion \n";
					print 'version     =',"$version \n";
					print 'address     =',"$address \n";
					if($preversion=~m/.*\..*/){#如果存在译者等信息
						($translator)=($preversion=~m/(.*)\..*/);
						print 'translator  =',"$translator \n";#作者多个姓名还需要处理,还有译这个标识
					}
				}else {#不存在数字版本的话
					if($preaddress=~m/.*\.\s+.*/){#存在点加空格，表示存在其他作者信息，区别点在末尾但无空格
					($preversion,$address)=($preaddress=~m/(.*)\.\s*(.*)/);
					print 'preversion  =',"$preversion \n";
					print 'address     =',"$address \n";
					$translator=$preversion;
					print 'translator  =',"$translator \n";
					}else{
					$address=$preaddress;
					print 'address     =',"$address \n";
					}
				}
				
				if($translator=~m/译/){#当译者真实存在
					$translator=~s/,\s*译//;#将译去掉
					if($translator=~m/等/){
						$translator=~s/等/others/;#将等换成others
					}else{
						$translator=~s/,\s*$//;#将最后一个逗号去掉
					}
					while($translator=~m/,/){
						$translator=~s/,/ and /;#将逗号换成and
					}
					print 'translator  =',"$translator \n";
				}else {#当译者不存在，那么translator中信息可能是非数字的版本信息
					unless($version) {#除非version没有信息
					$version=$translator;
					$translator="";
					}else{
					print "version is already exisit!\n";
					print 'version=',$version,"\n";
					print 'translator=',$translator,"\n";
					}
				}
				
			if ($address=~m/.*\[S-l-\].*/) {#当存在英文的[S-l-][S.l.]
				$address=~s/\[S-l-\]/\[S\.l\.\]/; #将[S-l-]换回[S.l.]
			}
		}
	}

	
	sub bfaddressinbook{#bf表示before，出版者前book和inbook不一样
		($postitle)=($reference=~m/$regexformach\s*(.*)/);
		print 'postitle=',$postitle,"\n";
		if($postitle=~m/^[^:\.]+:[^:\.]+\./){#当存在析出源第一项中出现:时
			$postitle=~s/:/colon/;#先将该冒号换成colon
			print 'postitle=',$postitle,"\n";
		}
		#对于inbook类型，必然存在出版地和出版者信息，以此为根据展开
		($preaddress, $pospublisher)=($postitle=~m/\s*(.*):\s(\D.*)/);
		#($preaddress, $pospublisher)=($postitle=~m/\s*([^:]+):\s(\D.*)/);
		#标识符之后根据第一个冒号分为包括地址的信息和包括出版者的信息两部分
		print 'preaddress  =',"$preaddress \n";
		print 'pospublisher=',"$pospublisher \n";
		
		#处理出版地及其前面的信息
		if ($preaddress=~m/.*\[S\.l\.\].*/) {#当存在英文的[S.l.]，英文的一般不存在译者，所以下面处理比较简单
			$preaddress=~s/\[S\.l\.\]/\[S-l-\]/; #先将[S.l.]换成[S-l-]然后换回来
		}
			if ($preaddress=~m/.*\d.*\.\s+.*/ and ($preaddress=~m/.*th\sed.*/ or $preaddress=~m/.*版.*/)){#匹配存在数字版本的话
				($preversion, $version, $address)=($preaddress=~m/(.*)(\d)[^\.]*\.\s+(.*)/);
				print 'preversion  =',"$preversion \n";
				print 'version     =',"$version \n";
				print 'address     =',"$address \n";
				if($preversion=~m/.*\.\s+.*/){#如果存在译者等信息
					($translator)=($preversion=~m/(.*)\.\s+.*/);
					print 'translator  =',"$translator \n";#作者多个姓名还需要处理,还有译这个标识
				}
			}else {#不存在数字版本的话
				if($preaddress=~m/.*\.\s+.*/){#存在点加空格，表示存在其他作者信息，区别点在末尾但无空格
					($preversion,$address)=($preaddress=~m/(.*)\.\s+(.*)/);
					print 'preversion  =',"$preversion \n";
					print 'address     =',"$address \n";
					if($preversion=~m/.*\.\s+.*/){#中间还存在点加空格
						($bookauthor,$booktitle)=($preversion=~m/(.*)\.\s+(.*)/);
						
						if($bookauthor=~m/等/){
							$bookauthor=~s/等/others/;#将等换成others
						}else{
							$bookauthor=~s/,\s*$//;#将最后一个逗号去掉
						}
						if($bookauthor=~m/et\sal/){
							$bookauthor=~s/et\sal/others/;#将et al.换成others
						}else{
							$bookauthor=~s/,\s*$//;#将最后一个逗号去掉
						}
						while($bookauthor=~m/,/){
							$bookauthor=~s/,/ and /;#将逗号换成and
						}
						print 'bookauthor=',"$bookauthor \n";
					}else{
						$booktitle=$preversion;
					}
				}else{
				$address=$preaddress;
				print 'address     =',"$address \n";
				}
			}
			
		if ($address=~m/.*\[S-l-\].*/) {#当存在英文的[S-l-][S.l.]
			$address=~s/\[S-l-\]/\[S\.l\.\]/; #将[S-l-]换回[S.l.]
		}
		if ($booktitle=~m/.*colon.*/) {#当存在colon
			$booktitle=~s/colon/:/; #将colon换回:
		}
		
		#进一步处理责任者的姓名,主要针对英文名需要有一些符号进行区分姓，名，前缀和后缀。
		@names=split('and',$bookauthor);
		print 'names=',@names,"\n";
		$bookauthor="";
		$j=0;
		foreach $name(@names){
			$j=$j+1;
			#print $name,"\n";
			@nameparts=split(' ',$name);
			#print 'nameparts=',@nameparts,"\n";
			
			$org=0;
			for($k=0;$k<@nameparts;$k++){
			if(@nameparts[$k]=~m/.{2,}/ and @nameparts[$k]!~m/\s*von\s*/i and @nameparts[$k]!~m/\s*jr\s*/i){
			#当分解的单作者的各个部分，存在两个以上为2个字符以上的情况，说明不是一般的姓名而是机构作者
				$org=$org+1;
				print 'org=',"$org\n";
			}
			}
			
			if(@nameparts>1){
				if(@nameparts[0]=~m/\s*von\s*/i){#确定姓的位置
					$family=1;
					@nameparts[1]=@nameparts[1].',';
				}else{
					$family=0;
					@nameparts[0]=@nameparts[0].',';
				}
				if(@nameparts[-1]=~m/\s*jr\s*/i){#确定后缀的位置
					@nameparts[-1]=@nameparts[-1].'.,';
					$given=@nameparts-2;
					$suffix=1;
				}else{
					$suffix=0;
					$given=@nameparts-1;
				}
				#print 'family=',$family,"\n";
				#print 'given=',$given,"\n";
				#print 'suffix=',$suffix,"\n";
				
				$namefmt="";
				for($i=0;$i<=$family;$i++){
					$namefmt=$namefmt.@nameparts[$i].' ';
					#print $i,$family,$namefmt,"\n";
				}
				if($suffix){
					$namefmt=$namefmt.@nameparts[-1].' ';
				}
				for($i=$family+1;$i<=$given;$i++){
					$namefmt=$namefmt.@nameparts[$i].' ';
				}
			}else{
				$namefmt=$name;
			}
			if($org > 1){#当是机构作者时
				$namefmt='{'.$name.'}';
			}
			#print 'namefmt=',"$namefmt \n";
			
			if($j==1){
				$bookauthor=$namefmt;
			}else{
				$bookauthor=$bookauthor.' and '.$namefmt;
			}
		}
		while($bookauthor=~m/\s{2,}/){
				$bookauthor=~s/\s{2,}/ /;#将多余的空格去掉
			}
		while($bookauthor=~m/\.{2,}/){
				$bookauthor=~s/\.{2,}/\./;#将多余的点去掉
			}
		print 'bookauthor=',"$bookauthor\n";
	}
	

	sub afpublisherbook{#af表示after，出版者后book和inbook一样，但如果存在url则不同
	    #处理出版者及其后面的信息
		if ($pospublisher=~m/.*\[s\.n\.\].*/) {#当存在英文的[s.n.]
			$pospublisher=~s/\[s\.n\.\]/\[s-n-\]/; #先将[s.n.]换成[s-n-]然后换回来
		}
			if ($pospublisher=~m/.*,\s*\d{4}\S+/){#匹配存在年份的话
				($publisher, $year, $posyear)=($pospublisher=~m/(.*),\s*(\d{4})(.*)/);
				print 'publisher=',"$publisher \n";
				print 'year     =',"$year \n";
				print 'posyear  =',"$posyear \n";
				if($posyear=~m/^:/){#匹配存在页码前面的冒号的话
					($pages, $pospages)=($posyear=~m/^:([^\.]+)\.(.*)/);
					print 'pages   =',"$pages \n";
					print 'pospages=',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}else{#不存在页码的话
					if($posyear=~m/DOI/i){#匹配存在doi的话
					($doi)=($posyear=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}
			}else{#不存在年份，匹配一下是否存在冒号和页码
				if($pospublisher=~m/.*[^DOI]:.*/i){#当存在不是doi后面的冒号时，说明有页码
					($publisher, $pages, $pospages)=($pospublisher=~m/([^:]*):([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pages    =',"$pages \n";
					print 'pospages =',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}else{#没有页码冒号以点作为出版者后的分隔点
					($publisher, $pospages)=($pospublisher=~m/([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pospages =',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}
			}
		if ($publisher=~m/.*\[s-n-\].*/) {#当存在英文的[s-n-]
			$publisher=~s/\[s-n-\]/\[s\.n\.\]/; #将[s-n-]换回[s.n.]
		}
	}
	
	
	sub afpublisherbookurl{#af表示after，出版者后book和inbook一样，但如果存在url则不同
			#处理出版者及其后面的信息
		if ($pospublisher=~m/.*\[s\.n\.\].*/) {#当存在英文的[s.n.]
			$pospublisher=~s/\[s\.n\.\]/\[s-n-\]/; #先将[s.n.]换成[s-n-]然后换回来
		}
			if ($pospublisher=~m/.*,\s*\d{4}[^\d-]/){#匹配存在年份的话,4个数字后面跟着不能是数字和连字符-
				($publisher, $year, $posyear)=($pospublisher=~m/(.*),\s*(\d{4})(.*)/);
				print 'publisher=',"$publisher \n";
				print 'year     =',"$year \n";
				print 'posyear  =',"$posyear \n";
				if($posyear=~m/^:/){#匹配存在页码前面的冒号的话
					($pages, $pospages)=($posyear=~m/^:([^\.]+)\.(.*)/);
					print 'pages   =',"$pages \n";
					print 'pospages=',"$pospages \n";
					if($pages=~m/\[.*\]/){
						($pagesa, $urldate)=($pages=~m/(.*)\[(.*)\]/);
						$pages=$pagesa;
						print 'urldate=',"$urldate \n";
						print 'pages=',"$pages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
				else{#不存在页码的话
					if($posyear=~m/\[.*\]/){
						($urldate,$pospages)=($posyear=~m/.*\[(.*)\]\.(.*)/);
						print 'urldate=',"$urldate \n";
						print 'pospages=',"$pospages \n";
					}
					else{#不存在页码,又不存在引用日期的话，那么会有一个点和空格
						($pospages)=($posyear=~m/.*\s(.*)/);
						print 'pospages=',"$pospages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
			}else{#不存在年份，匹配一下是否存在冒号和页码
				if($pospublisher=~m/.*[^DOIhttp]:.*/i){#当存在不是doi或http后面的冒号时，说明有页码
					($publisher, $pages, $pospages)=($pospublisher=~m/([^:]*):([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pages    =',"$pages \n";
					print 'pospages =',"$pospages \n";
					if($pages=~m/\[.*\]/){
						($pagesa, $urldate)=($pages=~m/(.*)\[(.*)\]/);
						$pages=$pagesa;
						print 'urldate=',"$urldate \n";
						print 'pages=',"$pages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}else{#没有页码冒号以点作为出版者后的分隔点
					($publisher, $pospages)=($pospublisher=~m/([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pospages =',"$pospages \n";
					if($publisher=~m/\[.*\]/){
						($publishera, $urldate)=($publisher=~m/(.*)\[(.*)\]/);
						$publisher=$publishera;
						print 'urldate=',"$urldate \n";
						print 'publisher=',"$publisher \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
			}
		if ($publisher=~m/.*\[s-n-\].*/) {#当存在英文的[s-n-]
			$publisher=~s/\[s-n-\]/\[s\.n\.\]/; #将[s-n-]换回[s.n.]
		}
	}


	sub afpublisherbookb{#af表示after，出版者后book和inbook一样，但如果存在url则不同
	    #处理出版者及其后面的信息
		if ($pospublisher=~m/.*\[s\.n\.\].*/) {#当存在英文的[s.n.]
			$pospublisher=~s/\[s\.n\.\]/\[s-n-\]/; #先将[s.n.]换成[s-n-]然后换回来
		}
			if ($pospublisher=~m/.*[\.\s,]*\d{4}[\D\S]+/){#匹配存在年份的话，年份前面没有逗号+空格
				($publisher, $year, $posyear)=($pospublisher=~m/(.*)[\.\s,]*(\d{4})([\D\S].*)/);
				print 'publisher=',"$publisher \n";
				if($publisher=~m/[,\s]+$/){$publisher=~s/[,\s]+$//;}#去掉最后的逗号
				unless($address){#当没有出版地时，也没有必要存在
					$version=$publisher;
					$publisher='';
				}
				print 'year     =',"$year \n";
				print 'posyear  =',"$posyear \n";
				if($posyear=~m/^:/){#匹配存在页码前面的冒号的话
					($pages, $pospages)=($posyear=~m/^:([^\.]+)\.(.*)/);
					print 'pages   =',"$pages \n";
					print 'pospages=',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}else{#不存在页码的话
					if($posyear=~m/DOI/i){#匹配存在doi的话
					($doi)=($posyear=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}
			}else{#不存在年份，匹配一下是否存在冒号和页码
				if($pospublisher=~m/.*[^DOI]:.*/i){#当存在不是doi后面的冒号时，说明有页码
					($publisher, $pages, $pospages)=($pospublisher=~m/([^:]*):([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pages    =',"$pages \n";
					print 'pospages =',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}else{#没有页码冒号以点作为出版者后的分隔点
					($publisher, $pospages)=($pospublisher=~m/([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pospages =',"$pospages \n";
					if($pospages=~m/DOI/i){#匹配存在doi的话
					($doi)=($pospages=~m/DOI:(.*)\./i);
					print 'doi=',"$doi \n";
					}
				}
				if($publisher=~m/,$/){$publisher=~s/,$//;}#去掉最后的逗号
				unless($address){#当没有出版地时，也没有必要存在
						$type=$publisher;
						$publisher='';
				}
			}
		if ($publisher=~m/.*\[s-n-\].*/) {#当存在英文的[s-n-]
			$publisher=~s/\[s-n-\]/\[s\.n\.\]/; #将[s-n-]换回[s.n.]
		}
	}
	
	
		
	sub afpublisherbookurlb{#af表示after，出版者后book和inbook一样，但如果存在url则不同
			#处理出版者及其后面的信息
		if ($pospublisher=~m/.*\[s\.n\.\].*/) {#当存在英文的[s.n.]
			$pospublisher=~s/\[s\.n\.\]/\[s-n-\]/; #先将[s.n.]换成[s-n-]然后换回来
		}
			if ($pospublisher=~m/.*[\.\s,]*\d{4}[^\d-]/){#匹配存在年份的话,4个数字后面跟着不能是数字和连字符-
				($publisher, $year, $posyear)=($pospublisher=~m/(.*)[\.\s,]*(\d{4})([^\d-].*)/);
				print 'publisher=',"$publisher \n";
				print 'year     =',"$year \n";
				print 'posyear  =',"$posyear \n";
				if($publisher=~m/,$/){$publisher=~s/,$//;}#去掉最后的逗号
				unless($address){#当没有出版地时，也没有必要存在
					$version=$publisher;
					$publisher='';
				}
				if($posyear=~m/^:/){#匹配存在页码前面的冒号的话
					($pages, $pospages)=($posyear=~m/^:([^\.]+)\.(.*)/);
					print 'pages   =',"$pages \n";
					print 'pospages=',"$pospages \n";
					if($pages=~m/\[.*\]/){
						($pagesa, $urldate)=($pages=~m/(.*)\[(.*)\]/);
						$pages=$pagesa;
						print 'urldate=',"$urldate \n";
						print 'pages=',"$pages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
				else{#不存在页码的话
					if($posyear=~m/\[.*\]/){
						($urldate,$pospages)=($posyear=~m/.*\[(.*)\]\.(.*)/);
						print 'urldate=',"$urldate \n";
						print 'pospages=',"$pospages \n";
					}
					else{#不存在页码,又不存在引用日期的话，那么会有一个点和空格
						($pospages)=($posyear=~m/.*\s(.*)/);
						print 'pospages=',"$pospages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
			}else{#不存在年份，匹配一下是否存在冒号和页码
				if($pospublisher=~m/.*[^DOIhttp]:.*/i){#当存在不是doi或http后面的冒号时，说明有页码
					($publisher, $pages, $pospages)=($pospublisher=~m/([^:]*):([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pages    =',"$pages \n";
					print 'pospages =',"$pospages \n";
					if($pages=~m/\[.*\]/){
						($pagesa, $urldate)=($pages=~m/(.*)\[(.*)\]/);
						$pages=$pagesa;
						print 'urldate=',"$urldate \n";
						print 'pages=',"$pages \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}else{#没有页码冒号以点作为出版者后的分隔点
					($publisher, $pospages)=($pospublisher=~m/([^\.]*)\.(.*)/);
					print 'publisher=',"$publisher \n";
					print 'pospages =',"$pospages \n";
					if($publisher=~m/\[.*\]/){
						($publishera, $urldate)=($publisher=~m/(.*)\[(.*)\]/);
						$publisher=$publishera;
						print 'urldate=',"$urldate \n";
						print 'publisher=',"$publisher \n";
					}
					if($pospages=~m/DOI/i){#匹配存在doi的话
						($url, $doi)=($pospages=~m/(.*)\.\s*DOI:(.*)\./i);
						print 'url=',"$url \n";
						print 'doi=',"$doi \n";
					}else{
						($url)=($pospages=~m/(.*)\./i);
						print 'url=',"$url \n";
					}
				}
				if($publisher=~m/,$/){$publisher=~s/,$//;}#去掉最后的逗号
				unless($address){#当没有出版地时，也没有必要存在
						$type=$publisher;
						$publisher='';
				}
			}
		if ($publisher=~m/.*\[s-n-\].*/) {#当存在英文的[s-n-]
			$publisher=~s/\[s-n-\]/\[s\.n\.\]/; #将[s-n-]换回[s.n.]
		}
	}


	
close (FHR);
close (FHW);