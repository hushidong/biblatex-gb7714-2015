#!/usr/bin/env python3
#_∗_coding: utf-8 _∗_

import os
import shutil
import pathlib
import re
import subprocess


def updateversion(filename='',versioninfo=''):
    
    if filename:
        filelist=[filename]
    else:
        filelist=['gb7714-2015.bbx','gb7714-2015ay.bbx','gb7714-2015ms.bbx','gb7714-2015mx.bbx','readme.md']
        
    for file in filelist:
        try:
            if 'bbx' in file:
                f = open(file, 'r', encoding='utf-8')
                contents= f.readlines()
                newcontents=[]
                i=0
                for  line in contents:
                    i+=1
                    
                    if r'\def\versionofgbtstyle' in line:
                        linea=r'\def\versionofgbtstyle{'+versioninfo+'}\n'
                    else:
                        linea=line
                    if i<20:
                        print(line)
                        print(linea)
                    newcontents.append(linea)
                
                g=open(file, 'w', encoding='utf-8')
                for line in newcontents:
                    g.write(line)
                g.close()
                print(f'{file} has updated!')
            elif 'md' in file:
                f = open(file, 'r', encoding='utf-8')
                contents= f.readlines()
                newcontents=[]
                i=0
                historylineid=10000
                flg_hisupdate=False
                for  line in contents:
                    i+=1
                    
                    if r'Date of last change' in line:
                        linea=r'<b>Date of last change: '+versioninfo+'</b>\n'
                    elif r'Version history' in line:
                        historylineid=i
                        linea=line
                    elif not flg_hisupdate and i>historylineid+3 and line=='\n':
                        linea=r'* '+versioninfo+',ctan,github\n'
                        flg_hisupdate=True
                    else:
                        linea=line
                    if i<20:
                        print(line)
                        print(linea)
                    newcontents.append(linea)
                
                g=open(file, 'w', encoding='utf-8')
                for line in newcontents:
                    g.write(line)
                g.close()
                print(f'{file} has updated!')
                
        except ImportError:
            print('warning: file not loaded!')

    
    return None

if __name__ == '__main__':
    
    #compileall('all')
    #compileall('compare')
    updateversion(versioninfo='2025/06/10 v1.1v') 